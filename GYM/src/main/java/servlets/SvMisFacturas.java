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

        if (usuario.isAdmin()) {
            facturas = dbFactura.getFacturasFiltradasAdmin(nroFactura, estado, ordenFecha, dniCliente);
            facturas.addAll(dbFactura.getFacturasAbonosFiltradasAdmin(nroFactura, estado, ordenFecha, dniCliente));
        } else {
            facturas = dbFactura.getFacturasFiltradasUsuario(usuario.getDni(), nroFactura, estado, ordenFecha);
            facturas.addAll(dbFactura.getFacturasAbonosFiltradasUsuario(usuario.getDni(), nroFactura, estado, ordenFecha));
        }

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