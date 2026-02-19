package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbFactura;
import entities.Factura;
import entities.Usuario;

@WebServlet("/SvMisFacturas")
public class SvMisFacturas extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public SvMisFacturas() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario usuario = (Usuario) request.getSession().getAttribute("user");

        if (usuario == null) {
            response.sendRedirect("/GYM/pages/logIn.jsp");
            return;
        }

        String estado = request.getParameter("estado");
        String nroFacturaStr = request.getParameter("nro");
        String ordenFecha = request.getParameter("orden");
        String dniCliente = request.getParameter("dniCliente");

        Integer nroFactura = null;
        if (nroFacturaStr != null && !nroFacturaStr.isEmpty()) {
            nroFactura = Integer.parseInt(nroFacturaStr);
        }

        DbFactura dbFactura = new DbFactura();
        ArrayList<Factura> facturas;

        // 1. Buscamos y juntamos las facturas (Productos + Abonos)
        if (usuario.isAdmin()) {
            facturas = dbFactura.getFacturasFiltradasAdmin(nroFactura, estado, ordenFecha, dniCliente);
            facturas.addAll(dbFactura.getFacturasAbonosFiltradasAdmin(nroFactura, estado, ordenFecha, dniCliente));
        } else {
            facturas = dbFactura.getFacturasFiltradasUsuario(usuario.getDni(), nroFactura, estado, ordenFecha);
            facturas.addAll(dbFactura.getFacturasAbonosFiltradasUsuario(usuario.getDni(), nroFactura, estado, ordenFecha));
        }

        // =========================================================================
        // 2. SOLUCIÓN AL BUG: Reordenamos la lista combinada final en Java
        // =========================================================================
        if (facturas != null && !facturas.isEmpty()) {
            if ("asc".equalsIgnoreCase(ordenFecha)) {
                // Ordenar de más antiguas a más recientes (Ascendente)
                facturas.sort((f1, f2) -> {
                    if (f1.getFecha() == null && f2.getFecha() == null) return 0;
                    if (f1.getFecha() == null) return 1;
                    if (f2.getFecha() == null) return -1;
                    return f1.getFecha().compareTo(f2.getFecha());
                });
            } else {
                // Por defecto o "desc": ordenar de más recientes a más antiguas (Descendente)
                facturas.sort((f1, f2) -> {
                    if (f1.getFecha() == null && f2.getFecha() == null) return 0;
                    if (f1.getFecha() == null) return 1;
                    if (f2.getFecha() == null) return -1;
                    return f2.getFecha().compareTo(f1.getFecha());
                });
            }
        }

        // 3. Mandamos los datos a la vista
        request.setAttribute("facturas", facturas);
        request.setAttribute("estado", estado);
        request.setAttribute("nro", nroFacturaStr);
        request.setAttribute("orden", ordenFecha);
        request.setAttribute("dniCliente", dniCliente);

        request.getRequestDispatcher("/pages/misFacturas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}