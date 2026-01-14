package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbUsuario;
import entities.Usuario;

@WebServlet("/SvLogIn")
public class SvLogIn extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dni = request.getParameter("dni");
        String password = request.getParameter("password");

        DbUsuario db = new DbUsuario();
        Usuario user = db.logIn(new Usuario(dni, password));

        if (user != null) {
            request.getSession().setAttribute("user", user);
            response.sendRedirect("/GYM/index.jsp");
        } else {
            request.setAttribute("errorLogin", "DNI o contraseña incorrectos");
            request.getRequestDispatcher("/pages/logIn.jsp")
                   .forward(request, response);
        }
    }
}
