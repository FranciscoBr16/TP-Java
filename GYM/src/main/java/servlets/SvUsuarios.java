package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.DbUsuario;
import entities.Usuario;

@WebServlet("/SvUsuarios")
public class SvUsuarios extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        HttpSession session = request.getSession(false);
        Usuario userLogueado = (session != null) ? (Usuario) session.getAttribute("user") : null;

        if (userLogueado == null || !userLogueado.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String filtraNombre = request.getParameter("nombre");
        String filtraDni    = request.getParameter("dni");

        DbUsuario dbUsuario = new DbUsuario();
        ArrayList<Usuario> listaUsuarios = dbUsuario.getUsuariosConContrato(filtraNombre, filtraDni);

        request.setAttribute("listaUsuarios", listaUsuarios);
        request.setAttribute("activePage", "usuarios");

        request.getRequestDispatcher("/pages/listaUsuarios.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
