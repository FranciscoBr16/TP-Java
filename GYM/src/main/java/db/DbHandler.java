package db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

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

	protected Connection getConnection() {
		try {
			if(conn==null || conn.isClosed()) {
				conn=DriverManager.getConnection("jdbc:mysql://"+host+"/"+db, user, password);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}

	protected void cerrarConnection() {
		try {
			if(conn!=null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}





}
