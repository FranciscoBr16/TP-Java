package db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;

import entities.Clase;
import entities.Empleado;
import entities.Inscripcion;
import entities.Usuario;
import logic.LogicaActividad;

public class DbActividades extends DbHandler {
	
	public DbActividades() {
		super();
	}

	public ArrayList<Clase> getActividades(){
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		LogicaActividad la = new LogicaActividad();
		
		ArrayList<Clase> actividades = new ArrayList<>();
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM clase c INNER JOIN empleado e ON e.id_empleado = c.id_empleado WHERE c.tipo='actividad' AND c.estado=1 "); 
			rs = pstmt.executeQuery(); 
			
			while (rs.next() && rs!= null ) { 

	            Clase ac = new Clase();
	            ac.setIdClase(rs.getInt("id_clase"));
	            
	            ac.setNombre(rs.getString("nombre_clase"));
	            ac.setDescripcion(rs.getString("descripcion"));
	            ac.setHorario(rs.getString("horario"));
	            ac.setTipo(rs.getString("tipo"));
	            int cupo = rs.getInt("cupo");
	            Empleado emp = new Empleado();
	            emp.setNombre(rs.getString("nombre"));
	            emp.setApellido(rs.getString("apellido"));
	            ac.setEmpleado(emp);
	            ac.setImagen(rs.getString("imagen"));
	            String d = rs.getString("dia");
	            ac.setDia(d);
	            LocalDate fecha = la.fechaIncripcion(d);
	            Date f1 = java.sql.Date.valueOf(fecha.plusDays(-7));
	            Date f2 = java.sql.Date.valueOf(fecha);
	            pstmt2 = conn.prepareStatement("SELECT id_clase, count(dni) AS cantidad FROM inscripcion WHERE id_clase=? AND fecha BETWEEN ? AND ? GROUP BY 1");
	            System.out.println(f1+"   "+f2);
	            pstmt2.setInt(1, ac.getIdClase());
	            pstmt2.setDate(2, f1);
	            pstmt2.setDate(3, f2);
	            rs2 = pstmt2.executeQuery();
	            
	            if (rs2.next()){
	            int cantidad = rs2.getInt("cantidad");
	            ac.setCupo(cupo - cantidad);}
	            else {ac.setCupo(cupo);}

	            actividades.add(ac);
	}
			return actividades;
			
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

	public ArrayList<Clase> getClases() {
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		LogicaActividad la = new LogicaActividad();
		
		ArrayList<Clase> actividades = new ArrayList<>();
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM clase c WHERE c.tipo='musculacion' AND estado=1"); 
			rs = pstmt.executeQuery(); 
			
			while (rs.next() && rs!= null ) { 

	            Clase ac = new Clase();
	            ac.setIdClase(rs.getInt("id_clase"));
	            ac.setNombre(rs.getString("nombre_clase"));
	            ac.setTipo(rs.getString("tipo"));
	            int cupo = rs.getInt("cupo");
	            ac.setHorario(rs.getString("horario"));
	            String dia = rs.getString("dia");
	            ac.setDia(dia);

	            LocalDate fecha = la.fechaIncripcion(dia);
	            Date f1 = java.sql.Date.valueOf(fecha.plusDays(-7));
	            Date f2 = java.sql.Date.valueOf(fecha);
	            
	            pstmt2 = conn.prepareStatement("SELECT id_clase, count(dni) AS cantidad FROM inscripcion WHERE id_clase=? AND fecha BETWEEN ? AND ? GROUP BY 1");
	            pstmt2.setInt(1, ac.getIdClase());
	            pstmt2.setDate(2, f1);
	            pstmt2.setDate(3, f2);
	            rs2 = pstmt2.executeQuery();
	            if (rs2.next()){
		            int cantidad = rs2.getInt("cantidad");
		            ac.setCupo(cupo - cantidad);}
		            else {ac.setCupo(cupo);}
	            actividades.add(ac);
			}
			return actividades;
			
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
	
	public Clase nuevaClase(Clase cl) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Insert into clase (nombre_clase, descripcion, cupo, horario, id_empleado, imagen, dia, tipo ) values (?,?,?,?,?,?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, cl.getNombre() );
			pstmt.setString(2, cl.getDescripcion());
			pstmt.setInt(3, cl.getCupo());
			pstmt.setString(4, cl.getHorario());
			int idempleado = cl.getEmpleado().getIdEmpleado() ;
			if (idempleado != 0) {
			pstmt.setInt(5, idempleado);} else {pstmt.setNull(5, idempleado);}
			pstmt.setString(6, cl.getImagen());
			pstmt.setString(7, cl.getDia());
			pstmt.setString(8, cl.getTipo());
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
			if(rs!=null && rs.next()) {
				int id = rs.getInt(1);
				cl.setIdClase(id);
			}
			
			return cl;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(pstmt!=null)pstmt.close();
				this.cerrarConnection();
				if(rs!=null) rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	
			}
	}

	public int actualizarImgClase(Clase c) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("UPDATE clase SET imagen = ? where id_clase = ?");
			pstmt.setString(1, c.getImagen());
			pstmt.setInt(2, c.getIdClase());
			
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

	public Clase getClase(Clase c) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		ResultSet rs = null;
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Select * from clase where id_clase = ?");
			pstmt.setInt(1, c.getIdClase());
			
			rs = pstmt.executeQuery();
			
			rs.next();
			c.setNombre(rs.getString("nombre_clase"));
			c.setDescripcion(rs.getString("descripcion"));
			c.setCupo(rs.getInt("cupo"));
			c.setHorario(rs.getString("horario"));
			Empleado e = new Empleado(rs.getInt("id_empleado"));
			c.setEmpleado(e);
			c.setImagen(rs.getString("imagen"));
			c.setDia(rs.getString("dia"));
			c.setTipo(rs.getString("tipo"));
			
			return c;
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

	public int actualizarActividad(Clase clase) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("UPDATE clase SET nombre_clase = ?, descripcion = ?, cupo = ? , horario = ?, id_empleado = ?, dia = ?, tipo = ? where id_clase = ?");
			pstmt.setString(1, clase.getNombre());
			pstmt.setString(2, clase.getDescripcion());
			pstmt.setInt(3, clase.getCupo());
			pstmt.setString(4, clase.getHorario());
			pstmt.setInt(5, clase.getEmpleado().getIdEmpleado());
			pstmt.setString(6, clase.getDia());
			pstmt.setString(7, clase.getTipo());
			pstmt.setInt(8, clase.getIdClase());
			
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

	public int deleteActividad(Clase c) {
		PreparedStatement pstmt=null;
		Connection conn;

		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("UPDATE clase SET estado = 0 WHERE id_clase =?");
			pstmt.setInt(1, c.getIdClase());
			return pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
			
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				this.cerrarConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
	}

	public int nuevoSalon(Clase c) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Insert into clase (nombre_clase, cupo, horario, dia, tipo ) values (?,?,?,?,?)");
			pstmt.setString(1, c.getNombre() );
			pstmt.setInt(2, c.getCupo());
			pstmt.setString(3, c.getHorario());
			pstmt.setString(4, c.getDia());
			pstmt.setString(5, c.getTipo());
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

	public int actualizarSalon(Clase clase) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("UPDATE clase SET nombre_clase = ?, cupo = ? , horario = ?, dia = ?, tipo = ? where id_clase = ?");
			pstmt.setString(1, clase.getNombre());
			pstmt.setInt(2, clase.getCupo());
			pstmt.setString(3, clase.getHorario());
			pstmt.setString(4, clase.getDia());
			pstmt.setString(5, clase.getTipo());
			pstmt.setInt(6, clase.getIdClase());
			
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
	
	public boolean cupoClases(Clase clase) {
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		int cant = 0;
		int cupo = 0;
		
		LogicaActividad la = new LogicaActividad();
		try {
			conn = this.getConnection();
			pstmt2 = conn.prepareStatement("SELECT dia, cupo FROM clase WHERE id_clase=?");
			pstmt2.setInt(1, clase.getIdClase());
			rs = pstmt.executeQuery(); 
			
				while (rs.next() && rs!= null ) { 
					  String dia = rs.getString("dia");
					  cupo = rs.getInt("cupo");
					  LocalDate fecha = la.fechaIncripcion(dia);
			            Date f1 = java.sql.Date.valueOf(fecha.plusDays(-7));
			            Date f2 = java.sql.Date.valueOf(fecha);
				
			pstmt = conn.prepareStatement("SELECT id_clase, count(dni) AS cantidad FROM inscripcion WHERE id_clase=? AND fecha BETWEEN ? AND ? GROUP BY 1");
			pstmt.setInt(1, clase.getIdClase());
			pstmt.setDate(2, f1);
			pstmt.setDate(3, f2);
			rs2 = pstmt.executeQuery();
			
					while(rs2.next() && rs2!= null) {
						cant = rs2.getInt("cantidad");
					}
				}
			
				if(cupo - cant > 0) {
					return true;
				}else {
					return false;
				}
				
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
