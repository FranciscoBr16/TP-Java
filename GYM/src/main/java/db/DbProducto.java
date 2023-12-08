package db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import entities.Indumentaria;
import entities.Precio;
import entities.Producto;
import entities.Suplemento;


public class DbProducto extends DbHandler{
	
	public ArrayList<Producto> getProductos(){
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		PreparedStatement pstmt3=null;
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		ArrayList<Producto> productos = new ArrayList<>();
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("DROP TEMPORARY TABLE IF EXISTS tt_precios; ");
			pstmt.executeUpdate();
			pstmt2 = conn.prepareStatement("CREATE TEMPORARY TABLE tt_precios AS (SELECT id_producto , max(fecha_desde) AS fecha_desde FROM precio WHERE fecha_desde <= CURRENT_DATE GROUP BY id_producto);");
			pstmt2.executeUpdate();
			pstmt3 = conn.prepareStatement("SELECT p.id_producto , p.stock , p.nombre, p.imagen, pr.precio, pr.fecha_desde "
					+ "FROM producto p "
					+ "INNER JOIN tt_precios tt ON tt.id_producto = p.id_producto "
					+ "INNER JOIN precio pr ON pr.id_producto = p.id_producto "
					+ "WHERE pr.fecha_desde = tt.fecha_desde AND p.stock > 0");
			

			
			
			rs = pstmt3.executeQuery();
			while (rs.next() && rs!= null ) { 
				Producto pro = new Producto();
			
	            pro.setIdProducto(rs.getInt("p.id_producto"));
	            pro.setStock(rs.getInt("p.stock"));
	            pro.setNombre(rs.getString("p.nombre"));
	            pro.setImagen(rs.getString("p.imagen"));
	            Precio pre = new Precio(rs.getInt("pr.precio"));
	            pro.setPrecio(pre);
	            productos.add(pro);
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
		PreparedStatement pstmt2=null;
	
		Connection conn = null;
		ResultSet rs = null;
		try{
			conn = this.getConnection();
			pstmt2 = conn.prepareStatement("SET @FechaProxima = (SELECT max(fecha_desde) FROM precio WHERE fecha_desde <= current_date() AND id_producto = ?);");
			pstmt2.setInt(1,p.getIdProducto());
			pstmt2.executeUpdate();
			
			pstmt = conn.prepareStatement("Select pro.id_producto, pro.stock, pro.descripcion, pro.imagen, pro.nombre, pre.fecha_desde, pre.precio, i.talle, s.unidad, s.valor from producto pro "
					+ "INNER JOIN precio pre ON pro.id_producto = pre.id_producto "
					+ "LEFT JOIN indumentaria i ON i.id_producto = pro.id_producto "
					+ "LEFT JOIN suplemento s ON s.id_producto = pro.id_producto "
					+ "where pro.id_producto=? AND pre.fecha_desde = @FechaProxima;");
		
			pstmt.setInt(1, p.getIdProducto());
			
			rs = pstmt.executeQuery();
			
			rs.next();
			int id = rs.getInt("id_producto");
			int stock = rs.getInt("stock");
	        String desc =rs.getString("descripcion");
	        String img = rs.getString("imagen");
	        String nomb = rs.getString("nombre");
	        LocalDate fecha = rs.getDate("fecha_desde").toLocalDate();
	        int pre = rs.getInt("precio");
			
	        Producto p2;
	        
			String c = null;
			c = rs.getString("talle");
			if (c != null) {
				p2 = new Indumentaria (id, stock, desc, img, nomb, fecha, pre , c);
				} else {
				String unidad = rs.getString("unidad");
				Float valor = rs.getFloat("valor");
				p2 = new Suplemento (id, stock, desc, img, nomb, fecha, pre , unidad, valor);
				}
			
				
					
				return p2;
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

	public ArrayList<Producto> getAllProductos(){
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		PreparedStatement pstmt3=null;
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		ArrayList<Producto> productos = new ArrayList<>();
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("DROP TEMPORARY TABLE IF EXISTS tt_precios; ");
			pstmt.executeUpdate();
			pstmt2 = conn.prepareStatement("CREATE TEMPORARY TABLE tt_precios AS (SELECT id_producto , max(fecha_desde) AS fecha_desde FROM precio WHERE fecha_desde <= CURRENT_DATE GROUP BY id_producto);");
			pstmt2.executeUpdate();
			pstmt3 = conn.prepareStatement("SELECT p.id_producto , p.stock , p.nombre, p.imagen, pr.precio, pr.fecha_desde "
					+ "FROM producto p "
					+ "INNER JOIN tt_precios tt ON tt.id_producto = p.id_producto "
					+ "INNER JOIN precio pr ON pr.id_producto = p.id_producto "
					+ "WHERE pr.fecha_desde = tt.fecha_desde");
			
			rs = pstmt3.executeQuery();
			while (rs.next() && rs!= null ) { 
				Producto pro = new Producto();
			
	            pro.setIdProducto(rs.getInt("p.id_producto"));
	            pro.setStock(rs.getInt("p.stock"));
	            pro.setNombre(rs.getString("p.nombre"));
	            pro.setImagen(rs.getString("p.imagen"));
	            Precio pre = new Precio(rs.getInt("pr.precio"));
	            pro.setPrecio(pre);
	            productos.add(pro);
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

	public int actualizarIndumentaria(Indumentaria i) {
		PreparedStatement pstmt=null;
		
		PreparedStatement pstmt3=null;
		Connection conn = null;
		try {
			conn = this.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement("UPDATE producto SET stock = ?, descripcion = ?, nombre = ? WHERE id_producto = ?;");
	        pstmt.setInt(1, i.getStock());
	        pstmt.setString(2, i.getDescripcion());
	        pstmt.setString(3, i.getNombre());
	        pstmt.setInt(4, i.getIdProducto());
	        
			
	        pstmt3 = conn.prepareStatement("UPDATE indumentaria SET talle = ? WHERE id_producto = ?;");
	        pstmt3.setString(1, i.getTalle());
	        pstmt3.setInt(2, i.getIdProducto());
	        pstmt.executeUpdate();
	        
	        int result = pstmt3.executeUpdate();
			
	        
	        conn.commit();
			return result;
			
			
		} catch (SQLException e) {
			e.printStackTrace();
	        try {
	            if (conn != null) {
	                conn.rollback();
	            }
	        } catch (SQLException e2) {
	            e2.printStackTrace();
	        }
			return 0;
		} finally {
			try {
				if(pstmt!=null || pstmt3!=null)
					pstmt.close();
					
					pstmt3.close();
				this.cerrarConnection();
			} catch (SQLException e) {
				e.printStackTrace();
	
	 
			}
	}
	}	

	public int actualizarSuplemento(Suplemento s) {
		PreparedStatement pstmt=null;
		
		PreparedStatement pstmt3=null;
		Connection conn = null;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("UPDATE producto SET stock = ?, descripcion = ?, nombre = ? where id_producto = ?;");
			
			pstmt3 = conn.prepareStatement("UPDATE suplemento SET valor = ?, unidad =? where id_producto= ?;");
			pstmt.setInt(1, s.getStock());
			pstmt.setString(2, s.getDescripcion());
			pstmt.setString(3, s.getNombre());
			pstmt.setInt(4, s.getIdProducto());
			
			pstmt3.setString(1,s.getUnidad());
			pstmt3.setFloat(2,s.getValor());
			pstmt3.setInt(3, s.getIdProducto());
			
			pstmt.executeUpdate();
			
			return pstmt3.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if(pstmt!=null || pstmt3!=null)
					pstmt.close();
			
					pstmt3.close();
				this.cerrarConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
		
	}

	public boolean actualizarPrecio(Producto p) {
		PreparedStatement pstmt2=null;
		Connection conn = null;
		try {
			conn = this.getConnection();
		pstmt2 = conn.prepareStatement("INSERT INTO precio (id_producto,fecha_desde,precio) VALUES (?,?,?);"); 
		pstmt2.setInt(1, p.getIdProducto());
		pstmt2.setDate(2, java.sql.Date.valueOf(p.getPrecio().getFechaDesde()));
		pstmt2.setInt(3, p.getPrecio().getPrecio());
		pstmt2.execute();
		return true;
	} catch (SQLException e) {
		e.printStackTrace();
		return false;
	} finally {
		try {
			if( pstmt2!=null)
				
				pstmt2.close();
				
			this.cerrarConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
}
	}
	}
