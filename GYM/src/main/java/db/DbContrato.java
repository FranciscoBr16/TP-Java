package db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import entities.Abono;
import entities.Contrato;
import entities.Usuario;

public class DbContrato extends DbHandler {

	public DbContrato() {
		super();
	}

	public Contrato getContratoActualUsu(Usuario user) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		ResultSet rs = null;
		Contrato cont = new Contrato();
		Abono ab = new Abono();
		try{
			conn = this.getConnection();
			LocalDate fecha = LocalDate.now();
			String fechaFormateada = fecha.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

			pstmt = conn.prepareStatement("SELECT * FROM contrato c INNER JOIN abono a ON a.id_abono = c.id_abono WHERE dni_usuario = ? AND ? BETWEEN fecha_desde AND fecha_hasta ");
			pstmt.setString(1, user.getDni());
			pstmt.setString(2, fechaFormateada);

			rs = pstmt.executeQuery();

			if(rs.next()) {
				ab.setIdAbono(rs.getInt("id_abono"));
				ab.setPrecio(rs.getInt("precio"));
				ab.setCantReservas(rs.getInt("cant_reservas"));
				ab.setDescripcion(rs.getString("descripcion"));
	
				cont.setAbono(ab);
				cont.setReservasRestantes(rs.getInt("clases_disponibles"));
	
				Date fechaux = rs.getDate("fecha_desde");
				if (fechaux != null) {
					cont.setFechaDesde(fechaux.toLocalDate());
				} else {
					cont.setFechaDesde(null);
				}
	
				Date fechaux2 = rs.getDate("fecha_hasta");
				if (fechaux2 != null) {
					cont.setFechaHasta(fechaux2.toLocalDate()); 
				} else {
					cont.setFechaHasta(null);
				}
				return cont;
			}
			return null;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(rs!=null) rs.close();
				this.cerrarConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public boolean actualizaClasesDisponibles(Usuario usuario) {
		PreparedStatement pstmt=null;
		Connection conn = null;

		try {
			conn = this.getConnection();
			
			// Usamos EXACTAMENTE la misma fecha que en el getter para que no falle
			LocalDate fecha = LocalDate.now();
			String fechaFormateada = fecha.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			
			pstmt = conn.prepareStatement("UPDATE contrato SET clases_disponibles = clases_disponibles - 1 WHERE dni_usuario = ? AND ? BETWEEN fecha_desde AND fecha_hasta AND clases_disponibles > 0");
			pstmt.setString(1, usuario.getDni());
			pstmt.setString(2, fechaFormateada);
			
			int filasAfectadas = pstmt.executeUpdate();
			return filasAfectadas > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				this.cerrarConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public boolean crearContrato(String dniUsuario, int idAbono) {
		PreparedStatement pstmt = null;
		PreparedStatement pstmtAbono = null;
		Connection conn = null;
		ResultSet rs = null;

		try {
			conn = this.getConnection();
			pstmtAbono = conn.prepareStatement("SELECT cant_reservas FROM abono WHERE id_abono = ?");
			pstmtAbono.setInt(1, idAbono);
			rs = pstmtAbono.executeQuery();

			int cantReservas = 0;
			if (rs.next()) {
				cantReservas = rs.getInt("cant_reservas");
			} else {
				return false;
			}

			LocalDate fechaDesde = LocalDate.now();
			LocalDate fechaHasta = fechaDesde.plusDays(30);

			pstmt = conn.prepareStatement(
				"INSERT INTO contrato (dni_usuario, id_abono, fecha_desde, fecha_hasta, clases_disponibles) " +
				"VALUES (?, ?, ?, ?, ?)"
			);

			pstmt.setString(1, dniUsuario);
			pstmt.setInt(2, idAbono);
			pstmt.setDate(3, java.sql.Date.valueOf(fechaDesde));
			pstmt.setDate(4, java.sql.Date.valueOf(fechaHasta));
			pstmt.setInt(5, cantReservas);

			pstmt.executeUpdate();
			return true;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmtAbono != null) pstmtAbono.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public boolean tieneContratoActivo(String dniUsuario) {
	    PreparedStatement pstmt = null;
	    Connection conn = null;
	    ResultSet rs = null;

	    try {
	        conn = this.getConnection();
	        LocalDate hoy = LocalDate.now();

	        pstmt = conn.prepareStatement(
	            "SELECT COUNT(*) AS total " +
	            "FROM contrato " +
	            "WHERE dni_usuario = ? " +
	            "AND ? BETWEEN fecha_desde AND fecha_hasta"
	        );

	        pstmt.setString(1, dniUsuario);
	        pstmt.setDate(2, java.sql.Date.valueOf(hoy));

	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            return rs.getInt("total") > 0;
	        }

	        return false;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false; 
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

	// ===============================================================
	// NUEVO MÉTODO: SUMAR CLASES A UN CONTRATO QUE YA ESTÁ ACTIVO
	// ===============================================================
	public boolean sumarClasesAlContrato(String dniUsuario, int idAbono) {
		PreparedStatement pstmt = null;
		PreparedStatement pstmtAbono = null;
		Connection conn = null;
		ResultSet rs = null;

		try {
			conn = this.getConnection();

			// 1. Buscamos cuántas clases trae este pack/abono
			pstmtAbono = conn.prepareStatement("SELECT cant_reservas FROM abono WHERE id_abono = ?");
			pstmtAbono.setInt(1, idAbono);
			rs = pstmtAbono.executeQuery();

			int cantReservas = 0;
			if (rs.next()) {
				cantReservas = rs.getInt("cant_reservas");
			} else {
				return false; // Si no encuentra el abono, falla
			}

			// 2. Le sumamos esas clases al contrato que está vigente hoy
			LocalDate fecha = LocalDate.now();
			String fechaFormateada = fecha.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

			pstmt = conn.prepareStatement(
				"UPDATE contrato SET clases_disponibles = clases_disponibles + ? " +
				"WHERE dni_usuario = ? AND ? BETWEEN fecha_desde AND fecha_hasta"
			);
			pstmt.setInt(1, cantReservas);
			pstmt.setString(2, dniUsuario);
			pstmt.setString(3, fechaFormateada);

			int filasAfectadas = pstmt.executeUpdate();
			return filasAfectadas > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmtAbono != null) pstmtAbono.close();
				if (pstmt != null) pstmt.close();
				this.cerrarConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}