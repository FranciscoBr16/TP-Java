package servlets;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.DbFactura;
import db.DbProducto;
import entities.Detalle_Factura;
import entities.Factura;
import entities.ItemCarrito;
import entities.Producto;
import entities.Usuario;
import logic.LogicaFactura;

@WebServlet("/SvConfirmarCompra")
public class SvConfirmarCompra extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /* =========================
       GET → Mostrar confirmación
       ========================= */
    @Override
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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("user");
        ArrayList<ItemCarrito> carrito = (ArrayList<ItemCarrito>) session.getAttribute("carrito");

        if (user == null || carrito == null || carrito.isEmpty()) {
            response.sendRedirect("/GYM/SvProductos");
            return;
        }

        try {
            LogicaFactura logica = new LogicaFactura();
            logica.comprarProductos(carrito, user);

            session.removeAttribute("carrito");
            response.sendRedirect("/GYM/SvMisFacturas");

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/pages/finalCompra.jsp").forward(request, response);
        }
    }
}
