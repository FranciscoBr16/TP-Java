package db;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedList;

import entities.Usuario;

public class DbHandler {

	private Connection conn;
	private String host = "localhost";
	private String db = "gimnasio";
	private String user = "consultando";
	private String password = "gimnasio345";
	
	public DbHandler() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private Connection getConnection() {
		try {
			if(conn==null || conn.isClosed())
			conn=DriverManager.getConnection("jdbc:mysql://"+host+"/"+db, user, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	private void cerrarConnection() {
		try {
			if(conn!=null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public boolean newUser(Usuario user) {
		PreparedStatement pstmt=null;
		Connection conn;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Insert into usuario (nom_usuario, nombre, apellido, clave, correo, telefono, beneficio, admin) values (?,?,?,?,?,?)");
			pstmt.setString(1, user.getUsername() );
			pstmt.setString(2, user.getNombre());
			pstmt.setString(3, user.getApellido());
			pstmt.setString(4, user.getPassword());
			pstmt.setString(5, user.getEmail());
			pstmt.setInt(6, user.getTelefono());
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
}
