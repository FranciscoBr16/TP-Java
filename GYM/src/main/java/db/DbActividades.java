package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import entities.Clase;
import entities.Empleado;
import entities.Inscripcion;

public class DbActividades extends DbHandler {
	
	public DbActividades() {
		super();
	}

	public ArrayList<Clase> getActividades(){
		PreparedStatement pstmt=null;
		Connection conn = null;
		ResultSet rs = null;
		
		ArrayList<Clase> actividades = new ArrayList<>();
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("SELECT c.id_clase, c.nombre_clase, descripcion, cupo, horario, e.nombre, e.apellido, count(i.dni) FROM clase c"
					+ "INNER JOIN empleado e ON e.id_empleado = c.id_empleado"
					+ "INNER JOIN inscripcion i ON c.id_clase = i.id_clase"
					+ "WHERE tipo='actividad'"
					+ "group by 1,2,3,4,5,6,7;"); 
			rs = pstmt.executeQuery(); 
			
			while (rs.next() && rs!= null ) { 

	            Clase ac = new Clase();
	            ac.setIdClase(rs.getInt("id_clase"));
	            ac.setNombre(rs.getString("nombre_clase"));
	            ac.setDescripcion(rs.getString("descripcion"));
	            ac.setCupo(rs.getInt("cupo"));
	            ac.setHorario(rs.getInt("horario"));
	            Empleado emp = new Empleado();
	            emp.setNombre(rs.getString("nombre"));
	            emp.setApellido(rs.getString("apellido"));
	            ac.setEmpleado(emp);
	            ArrayList<Inscripcion> ins = new ArrayList<>();
	            
	            
	            
	            ac.setImagen(rs.getString("imagen"));
	            ac.setDia(rs.getString("dia"));
	            ac.setTipo(rs.getString("tipo"));
	           
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
		Connection conn = null;
		ResultSet rs = null;
		
		ArrayList<Clase> actividades = new ArrayList<>();
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("SELECT c.id_clase, c.nombre_clase, cupo, horario, count(i.dni) FROM clase c"
					+ "INNER JOIN inscripcion i ON c.id_clase = i.id_clase"
					+ "WHERE tipo='musculacion'"
					+ "group by 1,2,3,4,5,6,7;"); 
			rs = pstmt.executeQuery(); 
			
			while (rs.next() && rs!= null ) { 

	            Clase ac = new Clase();
	            ac.setIdClase(rs.getInt("id_clase"));
	            ac.setNombre(rs.getString("nombre_clase"));
	            ac.setCupo(rs.getInt("cupo"));
	            ac.setHorario(rs.getInt("horario"));
	            
	            ArrayList<Inscripcion> ins = new ArrayList<>(); // PENSAR PREGUNTAR EN CONSULTA
	            
	            ac.setDia(rs.getString("dia"));
	            ac.setTipo(rs.getString("tipo"));
	           
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
}
