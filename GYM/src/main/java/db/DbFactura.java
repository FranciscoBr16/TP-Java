package db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;



import entities.Factura;

public class DbFactura extends DbHandler{
	
	
	public boolean nuevaFactura(Factura fac) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("INSERT INTO factura (fecha, tipo, cuit, dni, total, id_producto) VALUES (?,?,?,?,?,?)");
		
			pstmt.setDate(1, java.sql.Date.valueOf(fac.getFecha()));
			pstmt.setString(2, fac.getTipo());
			pstmt.setString(3, fac.getCUIT());
			pstmt.setString(4, fac.getUsuario().getDni());
			pstmt.setDouble(5, fac.getProducto().getPrecio().getPrecio());
			pstmt.setInt(6, fac.getProducto().getIdProducto());
			pstmt.executeUpdate();
			return true;
	
		} catch (SQLException e) {
            e.printStackTrace();
            return false;
	}
		

}
}
