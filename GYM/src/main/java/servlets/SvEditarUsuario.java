package servlets;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.DbUsuario;
import entities.Usuario;

@WebServlet("/SvEditarUsuario")
public class SvEditarUsuario extends HttpServlet {

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

        String dni = request.getParameter("dni");

        DbUsuario db = new DbUsuario();
        Usuario u = db.getUsuarioByDni(dni);

        request.setAttribute("usuario", u);

        request.getRequestDispatcher("/pages/editarUsuario.jsp")
               .forward(request, response);
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dni = request.getParameter("dni");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String clave = request.getParameter("clave");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");

        boolean admin = request.getParameter("admin") != null;
        boolean estado = request.getParameter("estado") != null;

        LocalDate fecha = LocalDate.parse(request.getParameter("fecha"));

        Usuario u = new Usuario(telefono,dni,clave,correo, nombre, apellido,admin,fecha,estado);
        u.setAdmin(admin);

        DbUsuario db = new DbUsuario();
        db.actualizarUsuarioAdmin(u);

        response.sendRedirect("/GYM/SvUsuarios");
    }
}