package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entities.Clase;
import entities.Empleado;

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
			pstmt = conn.prepareStatement("Select * from clase where tipo='actividad'"); 
			rs = pstmt.executeQuery(); 
			
			while (rs.next() && rs!= null ) { 

	            Clase ac = new Clase();
	            ac.setIdClase(rs.getInt("id_clase"));
	            ac.setNombre(rs.getString("nombre_clase"));
	            ac.setDescripcion(rs.getString("descripcion"));
	            ac.setCupo(rs.getInt("cupo"));
	            ac.setHorario(rs.getInt("horario"));
	            Empleado emp = new Empleado();
	            emp.setIdEmpleado(rs.getInt("id_empleado"));
	            ac.setEmpleado(emp);
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
}
