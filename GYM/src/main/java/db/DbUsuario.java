package db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import entities.Usuario;

public class DbUsuario extends DbHandler {
	
	public DbUsuario() {
		super();
	}
	
	public boolean newUser(Usuario user) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Insert into usuario (nom_usuario, nombre, apellido, clave, correo, telefono, fechaNacimiento) values (?,?,?,?,?,?,?)");
			pstmt.setString(1, user.getDni() );
			pstmt.setString(2, user.getNombre());
			pstmt.setString(3, user.getApellido());
			pstmt.setString(4, user.getPassword());
			pstmt.setString(5, user.getEmail());
			pstmt.setString(6, user.getTelefono());
			pstmt.setDate(7, java.sql.Date.valueOf(user.getFechaNac()));
			pstmt.executeUpdate();
			
			return true;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if(pstmt!=null)pstmt.close();
				this.cerrarConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	
			}
	}
	
	public Usuario logIn(Usuario user) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		ResultSet rs = null;
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Select * from usuario where dni=? AND clave=?");
			pstmt.setString(1, user.getDni());
			pstmt.setString(2, user.getPassword());
			rs = pstmt.executeQuery();
			
			rs.next();
			user.setDni(rs.getString("dni"));
			user.setNombre(rs.getString("nombre"));
			user.setApellido(rs.getString("apellido"));
			user.setEmail(rs.getString("correo"));
			user.setTelefono(rs.getString("telefono"));
			user.setBeneficio(rs.getBoolean("beneficio"));
			user.setAdmin(rs.getBoolean("admin"));
			// user.setImagen(rs.getString("imagen"));
			Date fechaux = rs.getDate("fechaNacimiento");
			if (fechaux != null) {
				user.setFechaNac(fechaux.toLocalDate());
			} else user.setFechaNac(null);
			return user;
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