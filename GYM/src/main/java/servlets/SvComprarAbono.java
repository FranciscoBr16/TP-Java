package servlets;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entities.Usuario;
import logic.LogicaFactura;

@WebServlet("/SvComprarAbono")
public class SvComprarAbono extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        Usuario user = (Usuario) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("/GYM/pages/logIn.jsp");
            return;
        }

        try {

            int idAbono = Integer.parseInt(request.getParameter("id_abono"));

            LogicaFactura logicaFactura = new LogicaFactura();

            logicaFactura.comprarAbono(idAbono, user);

            request.getSession().setAttribute("mensaje",
                    "¡Compra realizada exitosamente! La factura quedó pendiente de pago.");
            request.getSession().setAttribute("tipoMensaje", "success");

            response.sendRedirect("/GYM/SvMisFacturas");

        } catch (NumberFormatException e) {

            request.getSession().setAttribute("mensaje", "ID de abono inválido");
            request.getSession().setAttribute("tipoMensaje", "error");
            response.sendRedirect("/GYM/SvAbono");

        } catch (Exception e) {

            request.getSession().setAttribute("mensaje", e.getMessage());
            request.getSession().setAttribute("tipoMensaje", "error");
            response.sendRedirect("/GYM/SvAbono");
        }
    }
}