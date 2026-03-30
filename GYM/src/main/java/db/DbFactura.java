package db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import entities.Abono;
import entities.Detalle_Factura;
import entities.Factura;
import entities.Producto;
import entities.Usuario;

public class DbFactura extends DbHandler{

	public int nuevaFactura(Factura fac) {
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    Connection conn = null;

	    try {
	        conn = this.getConnection();

	        pstmt = conn.prepareStatement(
	            "INSERT INTO factura (fecha, tipo, cuit, dni, total, estado) VALUES (?,?,?,?,?,?)",
	            Statement.RETURN_GENERATED_KEYS
	        );

	        pstmt.setDate(1, java.sql.Date.valueOf(fac.getFecha()));
	        pstmt.setString(2, fac.getTipo());
	        pstmt.setString(3, fac.getCUIT());
	        pstmt.setString(4, fac.getDNI());
	        pstmt.setDouble(5, fac.getTotal());
	        pstmt.setString(6, fac.getEstado());

	        pstmt.executeUpdate();

	        rs = pstmt.getGeneratedKeys();
	        if (rs.next()) {
	            return rs.getInt(1);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) {
					rs.close();
				}
	            if (pstmt != null) {
					pstmt.close();
				}
	            if (conn != null) {
					conn.close();
				}
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return -1; // error
	}

	public Factura getFacturaAbono(Factura f) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;

		try {
			conn = this.getConnection();
			pstmt = conn.prepareStatement(
				"SELECT * FROM factura f " +
				"LEFT JOIN `detalle-factura-abono` dfa ON dfa.nro_factura = f.nro_factura " +
				"WHERE f.nro_factura = ?"
			);
			pstmt.setInt(1, f.getNroFactura());
			rs = pstmt.executeQuery();

			if (!rs.next()) {
				return null;
			}

			Factura f2 = new Factura();
			f2.setNroFactura(f.getNroFactura());

			Date fecha = rs.getDate("fecha");
			if (fecha != null) {
				f2.setFecha(fecha.toLocalDate());
			}

			f2.setTipo(rs.getString("tipo"));
			f2.setCUIT(rs.getString("cuit"));
			f2.setDNI(rs.getString("dni"));
			f2.setTotal(rs.getFloat("total"));
			f2.setEstado(rs.getString("estado"));

			ArrayList<Detalle_Factura> dfs = new ArrayList<>();
			int idAbono = rs.getInt("id_abono");
			if (!rs.wasNull()) {
				Detalle_Factura df = new Detalle_Factura();
				Abono a = new Abono();
				a.setIdAbono(idAbono);
				df.setAbono(a);
				dfs.add(df);
			}

			f2.setDetalles(dfs);
			return f2;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public ArrayList<Factura> getmisfacturas(Usuario usuario) {
		ArrayList<Factura> facturas = new ArrayList<>();
		String sql = "Select * from factura where dni=?";

		try (Connection conn = this.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, usuario.getDni());
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					Factura fac = new Factura();
					fac.setNroFactura(rs.getInt("nro_factura"));
					Date fechaux = rs.getDate("fecha");
					if (fechaux != null) {
						fac.setFecha(fechaux.toLocalDate());
					}
					fac.setTipo(rs.getString("tipo"));
					fac.setCUIT(rs.getString("cuit"));
					fac.setUsuario(usuario);
					fac.setTotal(rs.getFloat("total"));
					fac.setEstado(rs.getString("estado"));


					fac.setDetalles(getDetallesFactura(conn, fac.getNroFactura()));
					facturas.add(fac);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return facturas;
	}

	public boolean crearDetalleFactura(Detalle_Factura df) {
	    PreparedStatement pstmt = null;
	    Connection conn = null;

	    try {
	        conn = this.getConnection();
	        pstmt = conn.prepareStatement(
	            "INSERT INTO `detalle-factura` (nro_factura, id_producto, cantidad, sub_total) VALUES (?,?,?,?)"
	        );

	        pstmt.setInt(1, df.getNroFactura());
	        pstmt.setInt(2, df.getIdProducto());
	        pstmt.setInt(3, df.getCantidad());
	        pstmt.setDouble(4, df.getSubTotal());

	        pstmt.executeUpdate();
	        return true;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    } finally {
	        try {
	            if (pstmt != null) {
					pstmt.close();
				}
	            if (conn != null) {
					conn.close();
				}
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

	public ArrayList<Factura> getFacturas() {
	    ArrayList<Factura> facturas = new ArrayList<>();
	    String sqlFactura = "SELECT * FROM factura";

	    try (Connection conn = this.getConnection();
	         PreparedStatement psFactura = conn.prepareStatement(sqlFactura);
	         ResultSet rsFactura = psFactura.executeQuery()) {

	        while (rsFactura.next()) {
	            Factura fac = new Factura();
	            fac.setNroFactura(rsFactura.getInt("nro_factura"));

	            Date fecha = rsFactura.getDate("fecha");
	            if (fecha != null) {
					fac.setFecha(fecha.toLocalDate());
				}

	            fac.setTipo(rsFactura.getString("tipo"));
	            fac.setCUIT(rsFactura.getString("cuit"));
	            fac.setDNI(rsFactura.getString("dni"));
	            fac.setTotal(rsFactura.getDouble("total"));
	            fac.setEstado(rsFactura.getString("estado"));


	            fac.setDetalles(getDetallesFactura(conn, fac.getNroFactura()));
	            facturas.add(fac);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return facturas;
	}

	public boolean actualizarEstadoFactura(int nroFactura, String estado) {
	    String sql = "UPDATE factura SET estado = ? WHERE nro_factura = ?";
	    try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setString(1, estado);
	        ps.setInt(2, nroFactura);
	        return ps.executeUpdate() > 0;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	public ArrayList<Factura> getFacturasFiltradasUsuario(String dniUsuario, Integer nroFactura, String estado, String ordenFecha) {
	    ArrayList<Factura> facturas = new ArrayList<>();
	    StringBuilder sql = new StringBuilder("SELECT * FROM factura WHERE dni = ? AND tipo = 'C' ");

	    if (nroFactura != null) {
			sql.append("AND nro_factura = ? ");
		}
	    if (estado != null && !estado.isEmpty()) {
			sql.append("AND estado = ? ");
		}

	    if ("asc".equalsIgnoreCase(ordenFecha)) {
			sql.append("ORDER BY fecha ASC ");
		} else {
			sql.append("ORDER BY fecha DESC ");
		}

	    try (Connection conn = this.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

	        int index = 1;
	        pstmt.setString(index++, dniUsuario);

	        if (nroFactura != null) {
				pstmt.setInt(index++, nroFactura);
			}
	        if (estado != null && !estado.isEmpty()) {
				pstmt.setString(index++, estado);
			}

	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                Factura f = new Factura();
	                f.setNroFactura(rs.getInt("nro_factura"));

	                Date fechaSql = rs.getDate("fecha");
	                if (fechaSql != null) {
						f.setFecha(fechaSql.toLocalDate());
					}

	                f.setTipo(rs.getString("tipo"));
	                f.setCUIT(rs.getString("cuit"));
	                f.setDNI(rs.getString("dni"));
	                f.setTotal(rs.getDouble("total"));
	                f.setEstado(rs.getString("estado"));


	                f.setDetalles(getDetallesFactura(conn, f.getNroFactura()));
	                facturas.add(f);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return facturas;
	}

	public ArrayList<Factura> getFacturasFiltradasAdmin(Integer nroFactura, String estado, String ordenFecha, String dniCliente) {
	    ArrayList<Factura> facturas = new ArrayList<>();
	    StringBuilder sql = new StringBuilder("SELECT * FROM factura WHERE tipo='C' ");

	    if (nroFactura != null) {
			sql.append("AND nro_factura = ? ");
		}
	    if (estado != null && !estado.isEmpty()) {
			sql.append("AND estado = ? ");
		}
	    if (dniCliente != null && !dniCliente.trim().isEmpty()) {
			sql.append("AND dni LIKE ? ");
		}

	    if ("asc".equalsIgnoreCase(ordenFecha)) {
			sql.append("ORDER BY fecha ASC ");
		} else {
			sql.append("ORDER BY fecha DESC ");
		}

	    try (Connection conn = this.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

	        int index = 1;
	        if (nroFactura != null) {
				pstmt.setInt(index++, nroFactura);
			}
	        if (estado != null && !estado.isEmpty()) {
				pstmt.setString(index++, estado);
			}
	        if (dniCliente != null && !dniCliente.trim().isEmpty()) {
				pstmt.setString(index++, "%" + dniCliente.trim() + "%");
			}

	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                Factura f = new Factura();
	                f.setNroFactura(rs.getInt("nro_factura"));

	                Date fechaSql = rs.getDate("fecha");
	                if (fechaSql != null) {
						f.setFecha(fechaSql.toLocalDate());
					}

	                f.setTipo(rs.getString("tipo"));
	                f.setCUIT(rs.getString("cuit"));
	                f.setDNI(rs.getString("dni"));
	                f.setTotal(rs.getDouble("total"));
	                f.setEstado(rs.getString("estado"));


	                f.setDetalles(getDetallesFactura(conn, f.getNroFactura()));
	                facturas.add(f);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return facturas;
	}

	public ArrayList<Factura> getFacturasAbonosFiltradasAdmin(Integer nroFactura, String estado, String ordenFecha, String dniCliente) {
	    ArrayList<Factura> facturas = new ArrayList<>();
	    StringBuilder sql = new StringBuilder("SELECT * FROM factura WHERE tipo= 'S' ");

	    if (nroFactura != null) {
			sql.append("AND nro_factura = ? ");
		}
	    if (estado != null && !estado.isEmpty()) {
			sql.append("AND estado = ? ");
		}
	    if (dniCliente != null && !dniCliente.trim().isEmpty()) {
			sql.append("AND dni LIKE ? ");
		}

	    if ("asc".equalsIgnoreCase(ordenFecha)) {
			sql.append("ORDER BY fecha ASC ");
		} else {
			sql.append("ORDER BY fecha DESC ");
		}

	    try (Connection conn = this.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

	        int index = 1;
	        if (nroFactura != null) {
				pstmt.setInt(index++, nroFactura);
			}
	        if (estado != null && !estado.isEmpty()) {
				pstmt.setString(index++, estado);
			}
	        if (dniCliente != null && !dniCliente.trim().isEmpty()) {
				pstmt.setString(index++, "%" + dniCliente.trim() + "%");
			}

	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                Factura f = new Factura();
	                f.setNroFactura(rs.getInt("nro_factura"));

	                Date fechaSql = rs.getDate("fecha");
	                if (fechaSql != null) {
						f.setFecha(fechaSql.toLocalDate());
					}

	                f.setTipo(rs.getString("tipo"));
	                f.setCUIT(rs.getString("cuit"));
	                f.setDNI(rs.getString("dni"));
	                f.setTotal(rs.getDouble("total"));
	                f.setEstado(rs.getString("estado"));


	                f.setDetalles(getDetalleFacturaAbono(conn, f.getNroFactura()));
	                facturas.add(f);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return facturas;
	}



	public ArrayList<Detalle_Factura> getDetallesFactura(Connection conn, int nroFactura) {
	    ArrayList<Detalle_Factura> detalles = new ArrayList<>();
	    String sql = "SELECT df.*, p.nombre, p.descripcion, p.imagen " +
	                 "FROM `detalle-factura` df " +
	                 "JOIN producto p ON df.id_producto = p.id_producto " +
	                 "WHERE df.nro_factura = ?";


	    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, nroFactura);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                Detalle_Factura df = new Detalle_Factura();
	                df.setNroFactura(rs.getInt("nro_factura"));
	                df.setIdProducto(rs.getInt("id_producto"));
	                df.setCantidad(rs.getInt("cantidad"));
	                df.setSubTotal(rs.getDouble("sub_total"));

	                Producto p = new Producto();
	                p.setIdProducto(df.getIdProducto());
	                p.setNombre(rs.getString("nombre"));
	                p.setDescripcion(rs.getString("descripcion"));
	                p.setImagen(rs.getString("imagen"));

	                df.setProducto(p);
	                detalles.add(df);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return detalles;
	}

	public ArrayList<Detalle_Factura> getDetalleFacturaAbono(Connection conn, int nroFactura) {
		ArrayList<Detalle_Factura> detalles = new ArrayList<>();
	    String sql = "SELECT dfa.nro_factura, dfa.precio, a.id_abono, a.nombreAbono, a.descripcion, a.imagen " +
	                 "FROM `detalle-factura-abono` dfa " +
	                 "JOIN abono a ON a.id_abono = dfa.id_abono " +
	                 "WHERE dfa.nro_factura = ?";

	    // Usamos el 'conn' que nos pasan
	    try (PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setInt(1, nroFactura);
	        try (ResultSet rs = ps.executeQuery()) {
		        while (rs.next()) {
		            Abono a = new Abono();
		            a.setIdAbono(rs.getInt("id_abono"));
		            a.setNombreAbono(rs.getString("nombreAbono"));
		            a.setDescripcion(rs.getString("descripcion"));
		            a.setImagen(rs.getString("imagen"));

		            Detalle_Factura d = new Detalle_Factura();
		            d.setNroFactura(nroFactura);
		            d.setAbono(a);
		            d.setSub_total(rs.getDouble("precio"));
		            d.setCantidad(1);

		            detalles.add(d);
		        }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return detalles;
	}

	public boolean facturarAbono(Detalle_Factura df) {
		PreparedStatement pstmt = null;
	    Connection conn = null;

	    try {
	        conn = this.getConnection();
	        pstmt = conn.prepareStatement(
	            "INSERT INTO `detalle-factura-abono` (nro_factura, id_abono, precio) VALUES (?,?,?)"
	        );

	        pstmt.setInt(1, df.getNroFactura());
	        pstmt.setInt(2, df.getIdProducto());
	        pstmt.setDouble(3, df.getSubTotal());

	        pstmt.executeUpdate();
	        return true;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    } finally {
	        try {
	            if (pstmt != null) {
					pstmt.close();
				}
	            if (conn != null) {
					conn.close();
				}
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

	public ArrayList<Factura> getFacturasAbonosFiltradasUsuario(String dni, Integer nroFactura, String estado, String ordenFecha) {
		ArrayList<Factura> facturas = new ArrayList<>();
	    StringBuilder sql = new StringBuilder("SELECT * FROM factura WHERE dni = ? AND tipo = 'S'");

	    if (nroFactura != null) {
			sql.append("AND nro_factura = ? ");
		}
	    if (estado != null && !estado.isEmpty()) {
			sql.append("AND estado = ? ");
		}

	    if ("asc".equalsIgnoreCase(ordenFecha)) {
			sql.append("ORDER BY fecha ASC ");
		} else {
			sql.append("ORDER BY fecha DESC ");
		}

	    try (Connection conn = this.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

	        int index = 1;
	        pstmt.setString(index++, dni);

	        if (nroFactura != null) {
				pstmt.setInt(index++, nroFactura);
			}
	        if (estado != null && !estado.isEmpty()) {
				pstmt.setString(index++, estado);
			}

	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                Factura f = new Factura();
	                f.setNroFactura(rs.getInt("nro_factura"));

	                Date fechaSql = rs.getDate("fecha");
	                if (fechaSql != null) {
						f.setFecha(fechaSql.toLocalDate());
					}

	                f.setTipo(rs.getString("tipo"));
	                f.setCUIT(rs.getString("cuit"));
	                f.setDNI(rs.getString("dni"));
	                f.setTotal(rs.getDouble("total"));
	                f.setEstado(rs.getString("estado"));

	                if(!"S".equals(f.getTipo())) {
	                	f.setDetalles(getDetallesFactura(conn, f.getNroFactura()));
	                } else {
	                	f.setDetalles(getDetalleFacturaAbono(conn, f.getNroFactura()));
	                }

	                facturas.add(f);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return facturas;
	}
}