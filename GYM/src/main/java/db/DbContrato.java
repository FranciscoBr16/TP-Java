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

			rs.next();

			ab.setIdAbono(rs.getInt("id_abono"));
			ab.setPrecio(rs.getInt("precio"));
			ab.setCantReservas(rs.getInt("cant_reservas"));
			ab.setDescripcion(rs.getString("descripcion"));

			cont.setAbono(ab);

			Date fechaux = rs.getDate("fecha_desde");
			if (fechaux != null) {
				cont.setFechaDesde(fechaux.toLocalDate());
			} else {
				cont.setFechaDesde(null);
			}

			Date fechaux2 = rs.getDate("fecha_hasta");
			if (fechaux2 != null) {
				cont.setFechaHasta(fechaux.toLocalDate());
			} else {
				cont.setFechaHasta(null);
			}


			return cont;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(pstmt!=null) {
					pstmt.close();
				}
				if(rs!=null) {
					rs.close();
				}
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
			pstmt = conn.prepareStatement("UPDATE contrato SET clases_disponibles = clases_disponibles-1 WHERE dni_usuario =?");
			pstmt.setString(1, usuario.getDni());
			pstmt.executeUpdate();
			return true;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if(pstmt!=null) {
					pstmt.close();
				}
				this.cerrarConnection();
				} catch (SQLException e) {
				e.printStackTrace();
				}
			}
	}

	/**
	 * Crea un contrato de 30 días a partir de hoy para un usuario con un abono específico
	 * @param dniUsuario DNI del usuario
	 * @param idAbono ID del abono contratado
	 * @return true si se creó correctamente, false en caso de error
	 */
	public boolean crearContrato(String dniUsuario, int idAbono) {
		PreparedStatement pstmt = null;
		PreparedStatement pstmtAbono = null;
		Connection conn = null;
		ResultSet rs = null;

		try {
			conn = this.getConnection();

			// Primero obtener la cantidad de reservas del abono
			pstmtAbono = conn.prepareStatement("SELECT cant_reservas FROM abono WHERE id_abono = ?");
			pstmtAbono.setInt(1, idAbono);
			rs = pstmtAbono.executeQuery();

			int cantReservas = 0;
			if (rs.next()) {
				cantReservas = rs.getInt("cant_reservas");
			} else {
				System.err.println("DbContrato.crearContrato: No se encontró el abono con id " + idAbono);
				return false;
			}

			// Calcular fechas
			LocalDate fechaDesde = LocalDate.now();
			LocalDate fechaHasta = fechaDesde.plusDays(30);

			// Insertar el contrato
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

			System.out.println("DbContrato.crearContrato: Contrato creado exitosamente para DNI " + dniUsuario +
			                   " desde " + fechaDesde + " hasta " + fechaHasta +
			                   " con " + cantReservas + " clases disponibles");

			return true;

		} catch (SQLException e) {
			System.err.println("DbContrato.crearContrato: Error SQL - " + e.getMessage());
			e.printStackTrace();
			return false;
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(pstmtAbono != null) {
					pstmtAbono.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * Verifica si un usuario ya tiene un contrato activo
	 * @param dniUsuario DNI del usuario
	 * @return true si tiene contrato activo, false si no
	 */
	public boolean tieneContratoActivo(String dniUsuario) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;

		try {
			conn = this.getConnection();
			LocalDate hoy = LocalDate.now();

			pstmt = conn.prepareStatement(
				"SELECT COUNT(*) as total FROM contrato " +
				"WHERE dni_usuario = ? AND ? BETWEEN fecha_desde AND fecha_hasta"
			);

			pstmt.setString(1, dniUsuario);
			pstmt.setDate(2, java.sql.Date.valueOf(hoy));

			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt("total") > 0;
			}

			return false;

		} catch (SQLException e) {
			System.err.println("DbContrato.tieneContratoActivo: Error SQL - " + e.getMessage());
			e.printStackTrace();
			return false;
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}