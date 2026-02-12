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
				System.err.println("DbFactura.getFacturaAbono: No se encontró factura con nro " + f.getNroFactura());
				return null;
			}

			Factura f2 = new Factura();
			f2.setNroFactura(f.getNroFactura());

			// Validar y setear fecha
			Date fecha = rs.getDate("fecha");
			if (fecha != null) {
				f2.setFecha(fecha.toLocalDate());
			}

			f2.setTipo(rs.getString("tipo"));
			f2.setCUIT(rs.getString("cuit"));
			f2.setDNI(rs.getString("dni"));
			f2.setTotal(rs.getFloat("total"));
			f2.setEstado(rs.getString("estado")); // Corregido: era "string"

			// Solo agregar abono si existe en la tabla detalle-factura-abono
			ArrayList<Detalle_Factura> dfs = new ArrayList<>();

			int idAbono = rs.getInt("id_abono");
			if (!rs.wasNull()) { // Verificar que id_abono no sea NULL
				Detalle_Factura df = new Detalle_Factura();
				Abono a = new Abono();
				a.setIdAbono(idAbono);
				df.setAbono(a);
				dfs.add(df);
			}

			f2.setDetalles(dfs);

			return f2;

		} catch (SQLException e) {
			System.err.println("DbFactura.getFacturaAbono: Error SQL - " + e.getMessage());
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
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;
		Connection conn = null;
		ResultSet rs=null , rs2 = null;

		ArrayList<Factura> facturas = new ArrayList<>();
		try{
			conn = this.getConnection();
			pstmt = conn.prepareStatement("Select * from factura where dni=?");
			pstmt.setString(1, usuario.getDni());
			rs = pstmt.executeQuery();

			while (rs.next() && rs!= null ) {

	            Factura fac = new Factura();
	            fac.setNroFactura(rs.getInt("nro_factura"));
	            Date fechaux = rs.getDate("fecha");
				if (fechaux != null) {
					fac.setFecha(fechaux.toLocalDate());
				} else {
					fac.setFecha(null);
				}
				fac.setTipo(rs.getString("tipo"));
				fac.setCUIT(rs.getString("cuit"));
				fac.setUsuario(usuario);
				fac.setTotal(rs.getFloat("total"));
				fac.setEstado(rs.getString("estado"));
				pstmt2 = conn.prepareStatement("SELECT * FROM `detalle-factura` where nro_factura =?");
				pstmt2.setInt(1, fac.getNroFactura());
				rs2 = pstmt2.executeQuery();
				DbProducto bdp = new DbProducto();
				ArrayList<Detalle_Factura> detalles = new ArrayList<>();
				while (rs2.next() && rs2!=null) {

					Detalle_Factura df = new Detalle_Factura();
					df.setNroFactura(rs2.getInt("nro_factura"));
					df.setIdProducto(rs2.getInt("id_producto"));
					df.setCantidad(rs2.getInt("cantidad"));
					df.setSubTotal(rs2.getFloat("sub_total"));

					Producto p = bdp.getProducto(new Producto(rs2.getInt("id_producto")));
					df.setProducto(p);
					detalles.add(df);
				}

				fac.setDetalles(detalles);


	            facturas.add(fac);

	}
			return facturas;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
		    try {
		        if (rs2 != null) {
					rs2.close();
				}
		        if (rs != null) {
					rs.close();
				}
		        if (pstmt2 != null) {
					pstmt2.close();
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
	public boolean crearDetalleFactura(Detalle_Factura df) {
	    PreparedStatement pstmt = null;
	    Connection conn = null;

	    try {
	        conn = this.getConnection();

	        pstmt = conn.prepareStatement(
	            "INSERT INTO `detalle-factura` (nro_factura, id_producto, cantidad, sub_total) " +
	            "VALUES (?,?,?,?)"
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
	    String sqlDetalle = "SELECT * FROM `detalle-factura` WHERE nro_factura = ?";

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

	            /* ===== DETALLES ===== */
	            ArrayList<Detalle_Factura> detalles = new ArrayList<>();

	            try (PreparedStatement psDetalle = conn.prepareStatement(sqlDetalle)) {
	                psDetalle.setInt(1, fac.getNroFactura());

	                try (ResultSet rsDetalle = psDetalle.executeQuery()) {
	                    DbProducto dbProducto = new DbProducto();

	                    while (rsDetalle.next()) {
	                        Detalle_Factura df = new Detalle_Factura();
	                        df.setNroFactura(fac.getNroFactura());
	                        df.setIdProducto(rsDetalle.getInt("id_producto"));
	                        df.setCantidad(rsDetalle.getInt("cantidad"));
	                        df.setSubTotal(rsDetalle.getDouble("sub_total"));

	                        Producto p = new Producto(rsDetalle.getInt("id_producto"));
	                        p = dbProducto.getProducto(p);
	                        df.setProducto(p);

	                        detalles.add(df);
	                    }
	                }
	            }

	            fac.setDetalles(detalles);
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

	public ArrayList<Factura> getFacturasFiltradasUsuario(
	        String dniUsuario,
	        Integer nroFactura,
	        String estado,
	        String ordenFecha) {

	    ArrayList<Factura> facturas = new ArrayList<>();

	    StringBuilder sql = new StringBuilder(
	        "SELECT * FROM factura WHERE dni = ? AND tipo = 'C' "
	    );

	    if (nroFactura != null) {
	        sql.append("AND nro_factura = ? ");
	    }

	    if (estado != null && !estado.isEmpty()) {
	        sql.append("AND estado = ? ");
	    }

	    if ("asc".equalsIgnoreCase(ordenFecha)) {
	        sql.append("ORDER BY fecha ASC ");
	    } else if ("desc".equalsIgnoreCase(ordenFecha)) {
	        sql.append("ORDER BY fecha DESC ");
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


	                f.setDetalles(getDetallesFactura(f.getNroFactura()));

	                facturas.add(f);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return facturas;
	}


	public ArrayList<Factura> getFacturasFiltradasAdmin(
	        Integer nroFactura,
	        String estado,
	        String ordenFecha) {

	    ArrayList<Factura> facturas = new ArrayList<>();
	    StringBuilder sql = new StringBuilder(
	        "SELECT * FROM factura WHERE tipo='C' "
	    );

	    if (nroFactura != null) {
	        sql.append("AND nro_factura = ? ");
	    }

	    if (estado != null && !estado.isEmpty()) {
	        sql.append("AND estado = ? ");
	    }

	    if ("asc".equalsIgnoreCase(ordenFecha)) {
	        sql.append("ORDER BY fecha ASC ");
	    } else if ("desc".equalsIgnoreCase(ordenFecha)) {
	        sql.append("ORDER BY fecha DESC ");
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


	                f.setDetalles(getDetallesFactura(f.getNroFactura()));

	                facturas.add(f);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return facturas;
	}

	public ArrayList<Factura> getFacturasAbonosFiltradasAdmin(
	        Integer nroFactura,
	        String estado,
	        String ordenFecha) {

	    ArrayList<Factura> facturas = new ArrayList<>();
	    StringBuilder sql = new StringBuilder(
	        "SELECT * FROM factura WHERE tipo= 'S' "
	    );

	    if (nroFactura != null) {
	        sql.append("AND nro_factura = ? ");
	    }

	    if (estado != null && !estado.isEmpty()) {
	        sql.append("AND estado = ? ");
	    }

	    if ("asc".equalsIgnoreCase(ordenFecha)) {
	        sql.append("ORDER BY fecha ASC ");
	    } else if ("desc".equalsIgnoreCase(ordenFecha)) {
	        sql.append("ORDER BY fecha DESC ");
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

	                // Cargar detalles de abonos
	                f.setDetalles(getDetalleFacturaAbono(f.getNroFactura()));

	                facturas.add(f);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return facturas;
	}



	public ArrayList<Detalle_Factura> getDetallesFactura(int nroFactura) {

	    ArrayList<Detalle_Factura> detalles = new ArrayList<>();
	    String sql = "SELECT * FROM `detalle-factura` WHERE nro_factura = ?";

	    try (Connection conn = this.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, nroFactura);

	        try (ResultSet rs = pstmt.executeQuery()) {

	            DbProducto dbProducto = new DbProducto();

	            while (rs.next()) {
	                Detalle_Factura df = new Detalle_Factura();

	                df.setNroFactura(nroFactura);
	                df.setIdProducto(rs.getInt("id_producto"));
	                df.setCantidad(rs.getInt("cantidad"));
	                df.setSubTotal(rs.getDouble("sub_total"));

	                Producto p = new Producto();
	                p.setIdProducto(df.getIdProducto());
	                p = dbProducto.getProducto(p);

	                df.setProducto(p);

	                detalles.add(df);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return detalles;
	}

	public ArrayList<Detalle_Factura> getDetalleFacturaAbono(int nroFactura) {
		ArrayList<Detalle_Factura> detalles = new ArrayList<>();
	    String sql = "SELECT dfa.nro_factura, dfa.precio, a.id_abono, a.nombreAbono, a.descripcion, a.imagen " +
	                 "FROM `detalle-factura-abono` dfa " +
	                 "JOIN abono a ON a.id_abono = dfa.id_abono " +
	                 "WHERE dfa.nro_factura = ?";

	    try (Connection conn = this.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);) {

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
		            d.setCantidad(1); // Los abonos siempre tienen cantidad 1

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
	            "INSERT INTO `detalle-factura-abono` (nro_factura, id_abono, precio) " +
	            "VALUES (?,?,?)"
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


	public ArrayList<Factura> getFacturasAbonosFiltradasUsuario(String dni, Integer nroFactura, String estado,
			String ordenFecha) {
		ArrayList<Factura> facturas = new ArrayList<>();

	    StringBuilder sql = new StringBuilder(
	        "SELECT * FROM factura WHERE dni = ? AND tipo = 'S'"
	    );

	    if (nroFactura != null) {
	        sql.append("AND nro_factura = ? ");
	    }

	    if (estado != null && !estado.isEmpty()) {
	        sql.append("AND estado = ? ");
	    }

	    if ("asc".equalsIgnoreCase(ordenFecha)) {
	        sql.append("ORDER BY fecha ASC ");
	    } else if ("desc".equalsIgnoreCase(ordenFecha)) {
	        sql.append("ORDER BY fecha DESC ");
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

	                f.setDetalles(getDetallesFactura(f.getNroFactura()));
	                } else {
	                f.setDetalles(getDetalleFacturaAbono(f.getNroFactura()));
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