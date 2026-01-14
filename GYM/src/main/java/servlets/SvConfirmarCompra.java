package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import db.DbFactura;
import db.DbProducto;
import entities.Detalle_Factura;
import entities.Factura;
import entities.ItemCarrito;
import entities.Producto;
import entities.Usuario;

@WebServlet("/SvConfirmarCompra")
public class SvConfirmarCompra extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /* =========================
       GET → Mostrar confirmación
       ========================= */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("user");
        ArrayList<ItemCarrito> carrito =
                (ArrayList<ItemCarrito>) session.getAttribute("carrito");

        if (user == null) {
            response.sendRedirect("/GYM/pages/logIn.jsp");
            return;
        }

        if (carrito == null || carrito.isEmpty()) {
            response.sendRedirect("/GYM/SvProductos");
            return;
        }

        double total = 0;
        for (ItemCarrito item : carrito) {
            total += item.getCantidad() * item.getPrecio();
        }

        request.setAttribute("total", total);
        request.getRequestDispatcher("/pages/finalCompra.jsp")
               .forward(request, response);
    }

    /* =========================
       POST → Confirmar compra
       ========================= */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("user");
        ArrayList<ItemCarrito> carrito =
                (ArrayList<ItemCarrito>) session.getAttribute("carrito");

        if (user == null || carrito == null || carrito.isEmpty()) {
            response.sendRedirect("/GYM/SvProductos");
            return;
        }

        DbFactura dbFactura = new DbFactura();
        DbProducto dbProducto = new DbProducto();

        try {
            /* ===== VALIDAR STOCK ===== */
            for (ItemCarrito item : carrito) {
                int stockActual = dbProducto.getProducto(item).getStock();
                if (item.getCantidad() > stockActual) {
                    request.setAttribute("error",
                        "No hay stock suficiente del producto: " + item.getNombre());
                    request.getRequestDispatcher("/pages/finalCompra.jsp")
                           .forward(request, response);
                    return;
                }
            }

            /* ===== CREAR FACTURA ===== */
            Factura factura = new Factura();
            factura.setFecha(LocalDate.now());
            factura.setTipo("C");
            factura.setCUIT("6942069");
            factura.setDNI(user.getDni());
            factura.setEstado("pendiente de pago");

            double total = 0;
            for (ItemCarrito item : carrito) {
                total += item.getCantidad() * item.getPrecio();
            }
            factura.setTotal(total);

            int nroFactura = dbFactura.nuevaFactura(factura);
            
            

            /* ===== CREAR DETALLES + DESCONTAR STOCK ===== */
            for (ItemCarrito item : carrito) {
            	
            	Detalle_Factura df = new Detalle_Factura(nroFactura,item.getCantidad(),item.getIdProducto(),item.getCantidad() * item.getPrecio());
                dbFactura.crearDetalleFactura(df);

                Producto p = new Producto();
                p.setIdProducto(item.getIdProducto());

                dbProducto.actualizarStock(p, item.getCantidad());
            }

            /* ===== LIMPIAR CARRITO ===== */
            session.removeAttribute("carrito");

            /* ===== REDIRIGIR A MIS FACTURAS ===== */
            response.sendRedirect("/GYM/SvMisFacturas");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error",
                "Ocurrió un error al confirmar la compra. Intente nuevamente.");
            request.getRequestDispatcher("/pages/finalCompra.jsp")
                   .forward(request, response);
        }
    }
}
