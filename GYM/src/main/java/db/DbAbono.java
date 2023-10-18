package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entities.Abono;

public class DbAbono extends DbHandler {
	
	public DbAbono() {
		super();
	}
	
	
	public ArrayList<Abono> getAbonos() {
		PreparedStatement pstmt=null;
		Connection conn = null;
		ResultSet rs = null;
		ArrayList<Abono> abonos = new ArrayList<>();
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Select * from abono"); // diseñar consulta
			rs = pstmt.executeQuery(); // se ejecuta la consulta y se asigna el resultado al resultset
			
			while (rs.next() && rs!= null ) { // avanza en las filas de las tablas hasta llegar al final

	            Abono ab = new Abono();
	            ab.setIdAbono(rs.getInt("id_abono"));
	            ab.setNombreAbono(rs.getString("nombreAbono"));
	            ab.setCantReservas(rs.getInt("cant_reservas"));
	            ab.setPrecio(rs.getInt("precio"));
	            abonos.add(ab);
	}
			return abonos;
			
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
	
	
	public boolean insertarAbono(Abono abono) {
        PreparedStatement pstmt = null;
        Connection conn = null;
        try {
            conn = this.getConnection();
            pstmt = conn.prepareStatement("INSERT INTO abono (id_abono, nombreAbono, cant_reservas, precio, descripcion) VALUES (?, ?, ?, ?, ?)");
            pstmt.setInt(1, abono.getIdAbono());
            pstmt.setString(2, abono.getNombreAbono());
            pstmt.setInt(3, abono.getCantReservas());
            pstmt.setInt(4, abono.getPrecio());
            pstmt.setString(5, abono.getDescripcion());
            return pstmt.execute();
            // ejecuta la consulta de inserción

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
            // manejo de errores
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                this.cerrarConnection();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
	
	
	
}
