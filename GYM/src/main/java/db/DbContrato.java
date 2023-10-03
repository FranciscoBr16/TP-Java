package db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

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
			} else cont.setFechaDesde(null);
			
			Date fechaux2 = rs.getDate("fecha_hasta");
			if (fechaux2 != null) {
				cont.setFechaHasta(fechaux.toLocalDate());
			} else cont.setFechaHasta(null);
			
			
			return cont;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(pstmt!=null)pstmt.close();
				this.cerrarConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	
			}
		
		
	}

}
