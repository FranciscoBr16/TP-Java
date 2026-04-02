package db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entities.Abono;
import entities.Contrato;
import entities.Usuario;

public class DbUsuario extends DbHandler {

	public DbUsuario() {
		super();
	}

	public boolean newUser(Usuario user) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("INSERT INTO usuario (dni, nombre, apellido, clave, correo, telefono, fechaNacimiento, imagen) VALUES (?,?,?,?,?,?,?,?)");
			pstmt.setString(1, user.getDni() );
			pstmt.setString(2, user.getNombre());
			pstmt.setString(3, user.getApellido());
			pstmt.setString(4, user.getPassword());
			pstmt.setString(5, user.getEmail());
			pstmt.setString(6, user.getTelefono());
			pstmt.setDate(7, java.sql.Date.valueOf(user.getFechaNac()));
			pstmt.setString(8, "/GYM/img/perfil/"+user.getImagen());
			pstmt.executeUpdate();

			return true;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if(pstmt!=null) {
					pstmt.close();
				}
				this.cerrarConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}

			}
	}

	public Usuario logIn(Usuario user) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		ResultSet rs = null;
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Select * from usuario where dni=? AND clave=? AND estado = 1");
			pstmt.setString(1, user.getDni());
			pstmt.setString(2, user.getPassword());
			rs = pstmt.executeQuery();

			rs.next();
			user.setDni(rs.getString("dni"));
			user.setNombre(rs.getString("nombre"));
			user.setApellido(rs.getString("apellido"));
			user.setEmail(rs.getString("correo"));
			user.setTelefono(rs.getString("telefono"));
			user.setBeneficio(rs.getBoolean("beneficio"));
			user.setAdmin(rs.getBoolean("admin"));
			user.setImagen(rs.getString("imagen"));
			Date fechaux = rs.getDate("fechaNacimiento");
			if (fechaux != null) {
				user.setFechaNac(fechaux.toLocalDate());
			} else {
				user.setFechaNac(null);
			}
			return user;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(pstmt!=null) {
					pstmt.close();
				}
				this.cerrarConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}

			}
	}

	public int actualizarUsuario(Usuario user) {
		PreparedStatement pstmt=null;
		Connection conn = null;
		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("UPDATE usuario SET nombre = ?, apellido = ?, clave = ? , correo = ?, telefono = ?, fechaNacimiento = ?, imagen= ? where dni = ?");
			pstmt.setString(1, user.getNombre());
			pstmt.setString(2, user.getApellido());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getEmail());
			pstmt.setString(5, user.getTelefono());
			pstmt.setDate(6, java.sql.Date.valueOf(user.getFechaNac()));
			pstmt.setString(7, user.getImagen());
			pstmt.setString(8, user.getDni());

			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if(pstmt!=null) {
					pstmt.close();
				}
				this.cerrarConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
	}

	public int deleteUsuario(Usuario user) {

		PreparedStatement pstmt=null;
		Connection conn;

		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement("UPDATE usuario SET estado = 0 WHERE dni =?");
			pstmt.setString(1, user.getDni());
			return pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return 0;

		}finally {
			try {
				if(pstmt!=null) {
					pstmt.close();
				}
				this.cerrarConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}

}
	public boolean existeDni(String dni) {
	    PreparedStatement pstmt = null;
	    Connection conn = null;
	    ResultSet rs = null;
	    try {
	        conn = this.getConnection();
	        pstmt = conn.prepareStatement("SELECT COUNT(*) as total FROM usuario WHERE dni = ?");
	        pstmt.setString(1, dni);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            return rs.getInt("total") > 0;
	        }
	        return false;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    } finally {
	        try {
	            if (rs != null) {
					rs.close();
				}
	            if (pstmt != null) {
					pstmt.close();
				}
	            this.cerrarConnection();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

	public boolean existeEmail(String email) {
	    PreparedStatement pstmt = null;
	    Connection conn = null;
	    ResultSet rs = null;
	    try {
	        conn = this.getConnection();
	        pstmt = conn.prepareStatement("SELECT COUNT(*) as total FROM usuario WHERE correo = ?");
	        pstmt.setString(1, email);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            return rs.getInt("total") > 0;
	        }
	        return false;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    } finally {
	        try {
	            if (rs != null) {
					rs.close();
				}
	            if (pstmt != null) {
					pstmt.close();
				}
	            this.cerrarConnection();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
	
	public ArrayList<Usuario> getUsuariosConContrato(String filtraNombre, String filtraDni) {
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<Usuario> lista = new ArrayList<>();
	 
	    try {
	        Connection conn = this.getConnection();
	 
	        StringBuilder sql = new StringBuilder(
	            "SELECT u.dni, u.nombre, u.apellido, u.correo, u.telefono, u.admin, u.imagen, c.id_abono, c.fecha_desde, c.fecha_hasta, c.clases_disponibles, a.nombreAbono " +
	            "FROM usuario u " +
	            "LEFT JOIN contrato c ON u.dni = c.dni_usuario AND c.fecha_hasta >= CURDATE() " +
	            "LEFT JOIN abono a ON c.id_abono = a.id_abono " +
	            "WHERE u.estado = 1 "
	        );
	 
	        if (filtraNombre != null && !filtraNombre.trim().isEmpty()) {
	            sql.append("AND (u.nombre LIKE ? OR u.apellido LIKE ?) ");
	        }
	        if (filtraDni != null && !filtraDni.trim().isEmpty()) {
	            sql.append("AND u.dni = ? ");
	        }
	        sql.append("ORDER BY u.apellido, u.nombre");
	 
	        pstmt = conn.prepareStatement(sql.toString());
	 
	        int idx = 1;
	        if (filtraNombre != null && !filtraNombre.trim().isEmpty()) {
	            String like = "%" + filtraNombre.trim() + "%";
	            pstmt.setString(idx++, like);
	            pstmt.setString(idx++, like);
	        }
	        if (filtraDni != null && !filtraDni.trim().isEmpty()) {
	            pstmt.setString(idx++, filtraDni.trim());
	        }
	 
	        rs = pstmt.executeQuery();
	 
	        while (rs.next()) {
	            Usuario u = new Usuario(
	                rs.getString("dni"),
	                rs.getString("nombre"),
	                rs.getString("apellido"),
	                "",                          // no exponemos la clave
	                rs.getString("correo"),
	                rs.getString("telefono"),
	                null,                       
	                rs.getString("imagen")
	            );
	            u.setAdmin(rs.getBoolean("admin"));
	 
	            int idAbono = rs.getInt("id_abono");
	            if (!rs.wasNull()) {             
	                Abono abono = new Abono();
	                abono.setIdAbono(idAbono);
	                abono.setNombreAbono(rs.getString("nombreAbono"));
	 
	                Contrato contrato = new Contrato();
	                contrato.setAbono(abono);
	                contrato.setReservasRestantes(rs.getInt("clases_disponibles"));
	 
	                Date fd = rs.getDate("fecha_desde");
	                Date fh = rs.getDate("fecha_hasta");
	                if (fd != null) contrato.setFechaDesde(fd.toLocalDate());
	                if (fh != null) contrato.setFechaHasta(fh.toLocalDate());
	 
	                u.getContratos().add(contrato);
	            }
	 
	            lista.add(u);
	        }
	 
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs    != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            this.cerrarConnection();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	 
	    return lista;
	}
	
	public Usuario getUsuarioByDni(String dni){

	    PreparedStatement pstmt=null;
	    Connection conn=null;
	    ResultSet rs=null;

	    try{

	        conn=this.getConnection();

	        pstmt=conn.prepareStatement("SELECT * FROM usuario WHERE dni=?");
	        pstmt.setString(1,dni);

	        rs=pstmt.executeQuery();

	        if(rs.next()){

	            Usuario u = new Usuario(
	                    rs.getString("dni"),
	                    rs.getString("nombre"),
	                    rs.getString("apellido"),
	                    rs.getString("clave"),
	                    rs.getString("correo"),
	                    rs.getString("telefono"),
	                    rs.getDate("fechaNacimiento").toLocalDate(),
	                    rs.getString("imagen")
	            );

	            u.setAdmin(rs.getBoolean("admin"));

	            return u;
	        }

	    }catch(Exception e){
	        e.printStackTrace();
	    }

	    return null;
	}
	
	public int actualizarUsuarioAdmin(Usuario user) {

	    PreparedStatement pstmt = null;
	    Connection conn = null;

	    try {
	        conn = this.getConnection();

	        pstmt = conn.prepareStatement(
	            "UPDATE usuario SET nombre=?, apellido=?, clave=?, correo=?, telefono=?, fechaNacimiento=?, admin=?, estado=? WHERE dni=?"
	        );

	        pstmt.setString(1, user.getNombre());
	        pstmt.setString(2, user.getApellido());
	        pstmt.setString(3, user.getPassword());
	        pstmt.setString(4, user.getEmail());
	        pstmt.setString(5, user.getTelefono());
	        pstmt.setDate(6, java.sql.Date.valueOf(user.getFechaNac()));
	        pstmt.setBoolean(7, user.isAdmin());
	        pstmt.setBoolean(8, user.isEstado());
	        pstmt.setString(9, user.getDni());

	        return pstmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return 0;

	    } finally {
	        try {
	            if (pstmt != null) pstmt.close();
	            this.cerrarConnection();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
}
