package db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entities.Abono;
import entities.Clase;
import entities.Usuario;

public class DbAbono extends DbHandler {
	
	public DbAbono() {
		super();
	}
	
	
	public ArrayList<Abono> getAbonos() {
		PreparedStatement pstmt=null;
		Connection conn = null;
		ResultSet rs = null;
		ArrayList<Abono> abonos = new ArrayList<>();
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Select * from abono WHERE estado = 1"); // diseñar consulta
			rs = pstmt.executeQuery(); // se ejecuta la consulta y se asigna el resultado al resultset
			
			while (rs.next() && rs!= null ) { // avanza en las filas de las tablas hasta llegar al final

	            Abono ab = new Abono();
	            ab.setIdAbono(rs.getInt("id_abono"));
	            ab.setNombreAbono(rs.getString("nombreAbono"));
	            ab.setCantReservas(rs.getInt("cant_reservas"));
	            ab.setPrecio(rs.getInt("precio"));
	            ab.setImagen(rs.getString("imagen"));
	            abonos.add(ab);
	}
			return abonos;
			
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
	
	
	public Abono nuevoAbono(Abono abono) {
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rs = null;
        try {
            conn = this.getConnection();
            pstmt = conn.prepareStatement("INSERT INTO abono (nombreAbono, cant_reservas, precio, descripcion) VALUES (?, ?, ?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
      
            pstmt.setString(1, abono.getNombreAbono());
            pstmt.setInt(2, abono.getCantReservas());
            pstmt.setInt(3, abono.getPrecio());
            pstmt.setString(4, abono.getDescripcion());
            pstmt.executeUpdate();
            // ejecuta la consulta de inserción
            rs=pstmt.getGeneratedKeys();
			if(rs!=null && rs.next()) {
				int id = rs.getInt(1);
				abono.setIdAbono(id);
			}
			return abono;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
            // manejo de errores
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if(rs!=null) rs.close();
                this.cerrarConnection();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
	
	
public int deleteAbono(Abono abono) {
	
	PreparedStatement pstmt=null;
	Connection conn;

	try {
		conn = this.getConnection();
		pstmt = conn.prepareStatement("UPDATE abono SET estado = 0 WHERE id_abono =?");
		pstmt.setInt(1, abono.getIdAbono());
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
public Abono getAbono(Abono abono) {
	PreparedStatement pstmt=null;
	Connection conn = null;
	ResultSet rs = null;
	try{
		conn = this.getConnection();
		pstmt = conn.prepareStatement("Select * from abono where id_abono=?");
		pstmt.setInt(1, abono.getIdAbono());
		rs = pstmt.executeQuery();
		
		rs.next();
		
		abono.setNombreAbono(rs.getString("nombreAbono"));
		abono.setCantReservas(rs.getInt("cant_reservas"));
		abono.setPrecio(rs.getInt("precio"));
		abono.setDescripcion(rs.getString("descripcion"));
		abono.setImagen(rs.getString("imagen"));
		
		return abono;
		
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


public int actualizarAbono(Abono abono) {
	PreparedStatement pstmt=null;
	Connection conn = null;
	try {
		conn = this.getConnection();
		pstmt = conn.prepareStatement("UPDATE abono SET nombreAbono = ?, cant_reservas = ?, precio = ? , descripcion = ? where id_abono = ?");
		pstmt.setString(1, abono.getNombreAbono());
		pstmt.setInt(2, abono.getCantReservas());
		pstmt.setInt(3, abono.getPrecio());
		pstmt.setString(4, abono.getDescripcion());
		pstmt.setInt(5, abono.getIdAbono());
		
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

public int actualizarImgAbono(Abono a) {
	PreparedStatement pstmt=null;
	Connection conn = null;
	try {
		conn = this.getConnection();
		pstmt = conn.prepareStatement("UPDATE abono SET imagen = ? where id_abono = ?");
		pstmt.setString(1, a.getImagen());
		pstmt.setInt(2, a.getIdAbono());
		
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


