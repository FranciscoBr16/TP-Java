package db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import entities.Abono;
import entities.Clase;
import entities.Factura;
import entities.Usuario;

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
			pstmt.setDouble(5, fac.getProducto().getPrecio().getPrecio()); // lo hacemos asi debido a que es solo 1 producto
			pstmt.setInt(6, fac.getProducto().getIdProducto());
			pstmt.executeUpdate();
			return true;
	
		} catch (SQLException e) {
            e.printStackTrace();
            return false;
	}
		

}
	
	public ArrayList<Factura> getmisfacturas(Usuario usuario) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		ResultSet rs = null;
		ArrayList<Factura> facturas = new ArrayList<>();
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Select * from factura where dni=?");
			pstmt.setString(1, usuario.getDni());
			rs = pstmt.executeQuery();
			
			while (rs.next() && rs!= null ) { // avanza en las filas de las tablas hasta llegar al final

	            Factura fac = new Factura();
	            fac.setNroFactura(rs.getInt("nro_factura"));;
	            Date fechaux = rs.getDate("fecha");
				if (fechaux != null) {
					fac.setFecha(fechaux.toLocalDate());
				} else fac.setFecha(null);
				fac.setTipo(rs.getString("tipo"));
				fac.setCUIT(rs.getString("cuit"));
				fac.setUsuario(usuario);
				fac.setTotal(rs.getFloat("total"));
				// fac.setProducto();
				fac.setEstado(rs.getBoolean("estado"));
	            
	            facturas.add(fac);
	            
	}
			return facturas;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(pstmt!=null)pstmt.close();
				this.cerrarConnection();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	
			}
	
}
	
}