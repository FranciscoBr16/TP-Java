package db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import entities.Empleado;
import entities.Indumentaria;
import entities.Precio;
import entities.Producto;
import entities.Suplemento;


public class DbProducto extends DbHandler{
	
	public ArrayList<Producto> getProductos(){
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
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
				Suplemento sup = new Suplemento();
			
	            sup.setIdProducto(rs.getInt("p.id_producto"));
	            sup.setStock(rs.getInt("p.stock"));
	            sup.setDescripcion(rs.getString("p.descripcion"));
	            sup.setImagen(rs.getString("imagen"));
	            sup.setUnidad(rs.getString("s.unidad"));
	            sup.setValor(rs.getFloat("s.valor"));
	            Precio pre = new Precio(rs.getInt("pr.precio"));
	            sup.setPrecio(pre);
	            productos.add(sup);
	}
			
			
			rs2 = pstmt2.executeQuery(); 
			
			while (rs2.next() && rs2!= null ) { 
				Indumentaria ind = new Indumentaria();
			
	            ind.setIdProducto(rs2.getInt("p.id_producto"));
	            ind.setStock(rs2.getInt("p.stock"));
	            ind.setDescripcion(rs2.getString("p.descripcion"));
	            ind.setImagen(rs2.getString("imagen"));
	            ind.setTalle(rs2.getString("i.talle"));
	            Precio pre = new Precio(rs2.getInt("pr.precio"));
	            ind.setPrecio(pre);
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

	public Suplemento nuevoSuplemento(Suplemento sup) {
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		PreparedStatement pstmt3=null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Insert into producto (id_producto, stock, descripcion, nombre) values (?,?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, sup.getIdProducto() );
			pstmt.setInt(2, sup.getStock());
			pstmt.setString(3, sup.getDescripcion());
			pstmt.setString(4, sup.getNombre());
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
			if(rs!=null && rs.next()) {
				int id = rs.getInt(1);
				sup.setIdProducto(id);
				pstmt2 = conn.prepareStatement("INSERT INTO suplemento (id_producto, unidad, valor) VALUES (?,?,?)");
				pstmt2.setInt(1, id);
				pstmt2.setString(2, sup.getUnidad());
				pstmt2.setFloat(3, sup.getValor());
				pstmt2.executeUpdate();
				pstmt3 = conn.prepareStatement("INSERT INTO precio (id_producto, fecha_desde, precio) VALUES (?,?,?)");
				pstmt3.setInt(1, id);
				pstmt3.setDate(2, java.sql.Date.valueOf(LocalDate.now()));
				pstmt3.setInt(3, sup.getValorPrecio());
				pstmt3.executeUpdate();
			}
			
			return sup;
			
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

	public int actualizarImg(Producto pro) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("UPDATE producto SET imagen = ? where id_producto = ?");
			pstmt.setString(1, pro.getImagen());
			pstmt.setInt(2, pro.getIdProducto());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if(pstmt!=null)pstmt.close();
				this.cerrarConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
		
	}

	public Indumentaria nuevaIndumentaria(Indumentaria ind) {
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		PreparedStatement pstmt3=null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Insert into producto (id_producto, stock, descripcion, nombre) values (?,?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, ind.getIdProducto() );
			pstmt.setInt(2, ind.getStock());
			pstmt.setString(3, ind.getDescripcion());
			pstmt.setString(4, ind.getNombre());
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
			if(rs!=null && rs.next()) {
				int id = rs.getInt(1);
				ind.setIdProducto(id);
				pstmt2 = conn.prepareStatement("INSERT INTO indumentaria (id_producto, talle) VALUES (?,?)");
				pstmt2.setInt(1, id);
				pstmt2.setString(2, ind.getTalle());
				pstmt2.executeUpdate();
				pstmt3 = conn.prepareStatement("INSERT INTO precio (id_producto, fecha_desde, precio) VALUES (?,?,?)");
				pstmt3.setInt(1, id);
				pstmt3.setDate(2, java.sql.Date.valueOf(LocalDate.now()));
				pstmt3.setInt(3, ind.getValorPrecio());
				pstmt3.executeUpdate();
			}
			
			return ind;
			
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

	public Producto getProducto(Producto p) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		ResultSet rs = null;
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Select * from producto pro INNER JOIN precio pre ON pro.id_producto = pre.id_producto where id_producto=? ");
			pstmt.setInt(1, p.getIdProducto());
			rs = pstmt.executeQuery();
			
			rs.next();
			 p.setIdProducto(rs.getInt("id_producto"));
			 p.setStock(rs.getInt("stock"));
	         p.setDescripcion(rs.getString("descripcion"));
	            /*p.setImagen(rs.getString("imagen")); */
	         p.setNombre(rs.getString("Nombre"));
	         
	         Date fechaux = rs.getDate("fecha_desde");
	         Precio pre = new Precio(fechaux.toLocalDate(), rs.getInt("precio"));
				p.setPrecio(pre);	
					
				return p;
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

	public int actualizarProducto(Producto p) {
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		Connection conn = null;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("UPDATE producto SET stock = ?, descripcion = ?, nombre = ? where id_producto = ?");
			pstmt2 = conn.prepareStatement("INSERT INTO precio (id_producto,fecha_desde,precio) VALUES (?,?,?)"); // validar que se quiera cambiar el precio
			pstmt.setInt(1, p.getStock());
			pstmt.setString(2, p.getDescripcion());
			pstmt.setString(3, p.getNombre());
			pstmt.setInt(4, p.getIdProducto());
			pstmt2.setInt(1, p.getIdProducto());
			pstmt2.setDate(2, java.sql.Date.valueOf(p.getPrecio().getFechaDesde()));
			pstmt2.setInt(3, p.getPrecio().getPrecio());
		
			pstmt2.execute();
			return pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if(pstmt!=null || pstmt2!=null)
					pstmt.close();
					pstmt2.close();
				this.cerrarConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
	}



}
