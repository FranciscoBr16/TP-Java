package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entities.Empleado;
import entities.Indumentaria;
import entities.Precio;
import entities.Producto;

public class DbProducto extends DbHandler{
	
	public ArrayList<Producto> getProductos(){
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		Connection conn = null;
		ResultSet rs = null;
		ArrayList<Producto> productos = new ArrayList<>();
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Select id_producto , stock , descripcion, imagen, talle , MAX(p.fecha_desde) AS fecha from producto p "
					+ "INNER JOIN precio pr ON p.id_producto = pr.id_producto"
					+ "INNER JOIN indumentaria i ON i.id_producto = p.id_producto"
					+ "WHEREstock > 0 AND p.fecha_desde < CURRENT_DATE"
					+ "GROUP BY 1,2,3,4,5"); 
			
			
			pstmt2 = conn.prepareStatement("Select id_producto , stock , descripcion, imagen, kg , MAX(p.fecha_desde) AS fecha from producto p "
					+ "INNER JOIN precio pr ON p.id_producto = pr.id_producto"
					+ "INNER JOIN suplemento s ON s.id_producto = p.id_producto"
					+ "WHERE stock > 0 AND p.fecha_desde < CURRENT_DATE"
					+ "GROUP BY 1,2,3,4,5"); 
			
											
			rs = pstmt.executeQuery(); 
			
			while (rs.next() && rs!= null ) { 
				Indumentaria ind = new Indumentaria();
			
	            
	            ind.setIdProducto(rs.getInt("id_producto"));
	            ind.setStock(rs.getInt("stock"));
	            ind.setDescripcion(rs.getString("descripcion"));
	            ind.setImagen(rs.getString("imagen"));
	            ind.setTalle(rs.getString("talle"));
	            
	            Precio p = new Precio();
	  
	           
	            productos.add(ind);
	}
			return productos;
			
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
