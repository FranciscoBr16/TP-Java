package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbFactura;
import entities.Factura;
import entities.Usuario;

/**
 * Servlet implementation class SvCancelarFactura
 */
@WebServlet("/SvCancelarFactura")
public class SvCancelarFactura extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	DbFactura db = new DbFactura();
        db.cancelarFacturasVencidas();
        Usuario user = (Usuario) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("/GYM/index.jsp");
            return;
        }

        int nroFactura = Integer.parseInt(request.getParameter("nroFactura"));

        
        Factura f = new Factura();
        f.setDNI(user.getDni());
        f.setNroFactura(nroFactura);
        int resultado = db.cancelarFactura(f) ;

        if (resultado > 0) {
            request.getSession().setAttribute("mensaje", "Factura #" + nroFactura + " cancelada correctamente.");
            request.getSession().setAttribute("tipoMensaje", "success");
        } else {
            request.getSession().setAttribute("mensaje", "No se pudo cancelar la factura.");
            request.getSession().setAttribute("tipoMensaje", "error");
        }

        response.sendRedirect("/GYM/SvMisFacturas");
    }
}