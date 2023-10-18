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
			pstmt = conn.prepareStatement("SELECT p.id_producto , p.stock , p.descripcion, p.imagen, s.unidad, s.valor, pr.precio, pr.fecha_desde"
					+ "FROM precio pr"
					+ "INNER JOIN producto p ON p.id_producto = pr.id_producto"
					+ "INNER JOIN suplemento s ON s.id_producto = pr.id_producto"
					+ "WHERE pr.fecha_desde = (select max(p2.fecha_desde)"
					+ "FROM precio p2 WHERE p2.fecha_desde < CURRENT_DATE");
			
			
			pstmt2 = conn.prepareStatement("SELECT p.id_producto , p.stock , p.descripcion, p.imagen, i.talle, pr.precio, pr.fecha_desde"
					+ "FROM precio pr"
					+ "INNER JOIN producto p ON p.id_producto = pr.id_producto"
					+ "INNER JOIN indumentaria i ON s.id_producto = pr.id_producto"
					+ "WHERE pr.fecha_desde = (select max(p2.fecha_desde)"
					+ "FROM precio p2 WHERE p2.fecha_desde < CURRENT_DATE"); 
			
											
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
