package db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entities.Empleado;


public class DbEmpleado extends DbHandler {
	
	public DbEmpleado() {
		super();
	}
	
	public ArrayList<Empleado> getEmpleados() {
		PreparedStatement pstmt=null;
		Connection conn = null;
		ResultSet rs = null;
		ArrayList<Empleado> empleados = new ArrayList<>();
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM empleado"); 
			rs = pstmt.executeQuery(); 
			
			while (rs.next() && rs!= null ) {

	            Empleado emp = new Empleado();
	            emp.setIdEmpleado(rs.getInt("id_empleado"));
	            emp.setNombre(rs.getString("nombre"));
	            emp.setApellido(rs.getString("apellido"));
	            emp.setCorreo(rs.getString("mail"));
	            //emp.setImagen(rs.getString("imagen"));
	            emp.setRol(rs.getString("rol"));
	            
	            Date fechaux = rs.getDate("fecha_desde");
				if (fechaux != null) {
					emp.setFechaDesde(fechaux.toLocalDate());
				} else emp.setFechaDesde(null);
	            empleados.add(emp);
	}
			return empleados;
			
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
	
	public Empleado getEmpleado(Empleado emp) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		ResultSet rs = null;
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Select * from empleado where id_empleado=? ");
			pstmt.setInt(1, emp.getIdEmpleado());
			rs = pstmt.executeQuery();
			
			rs.next();
			 emp.setIdEmpleado(rs.getInt("id_empleado"));
	            emp.setNombre(rs.getString("nombre"));
	            emp.setApellido(rs.getString("apellido"));
	            emp.setCorreo(rs.getString("mail"));
	            /*emp.setImagen(rs.getString("imagen")); */
	            emp.setRol(rs.getString("rol"));
	            
	            Date fechaux = rs.getDate("fecha_desde");
				if (fechaux != null) {
					emp.setFechaDesde(fechaux.toLocalDate());
				} else emp.setFechaDesde(null);
	          
			return emp;
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
	
	public int deleteEmpleado(Empleado emp) {
        PreparedStatement pstmt=null;
        Connection conn;

        try {

            conn = this.getConnection();
            pstmt = conn.prepareStatement("UPDATE empleado SET estado= ? WHERE id_empleado =?");
            pstmt.setBoolean(1, false);
            pstmt.setInt(2, emp.getIdEmpleado());
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
	
	public boolean nuevoEmpleado(Empleado emp) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Insert into empleado(id_empleado, nombre, apellido, mail, fecha_desde, rol) values (?,?,?,?,?,?)");
			pstmt.setInt(1, emp.getIdEmpleado() );
			pstmt.setString(2, emp.getNombre() );
			pstmt.setString(3, emp.getApellido() );
			pstmt.setString(4, emp.getCorreo() );
			pstmt.setDate(5, java.sql.Date.valueOf(emp.getFechaDesde()));
			pstmt.setString(6, emp.getRol());
			pstmt.executeUpdate();
			return true;
		}
		catch (SQLException e) {
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
	
	public int actualizarEmpleado(Empleado emp) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("UPDATE empleado SET nombre = ?, apellido = ?, email = ?, rol= ?, fechaDesde = ? where id = ?");
			pstmt.setString(1, emp.getNombre());
			pstmt.setString(2, emp.getApellido());
			pstmt.setString(3, emp.getCorreo());
			pstmt.setString(3, emp.getRol());
			pstmt.setDate(4, java.sql.Date.valueOf(emp.getFechaDesde()));
			pstmt.setInt(5, emp.getIdEmpleado());
			
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


	

}
