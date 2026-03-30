package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbUsuario;
import entities.Usuario;

@WebServlet("/SvBajaUsuario")
public class SvBajaUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SvBajaUsuario() {
        super();
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Usuario user = (Usuario)request.getSession().getAttribute("user");

		if (user != null) {
			DbUsuario dbusu = new DbUsuario();

			if (dbusu.deleteUsuario(user) > 0) {
				// 1. Destruimos la sesión actual por seguridad
				request.getSession().invalidate();

				// 2. Creamos una sesión nueva limpia (true) para mandar el mensaje
				request.getSession(true).setAttribute("mensaje", "Tu cuenta ha sido eliminada con éxito. ¡Esperamos verte pronto!");
				request.getSession().setAttribute("tipoMensaje", "success");

				// 3. Redirigimos al inicio
				response.sendRedirect(request.getContextPath() + "/index.jsp");
			} else {
				// Si falla, vuelve al perfil con error
				request.getSession().setAttribute("mensaje", "Hubo un error al intentar eliminar la cuenta.");
				request.getSession().setAttribute("tipoMensaje", "error");
				response.sendRedirect(request.getContextPath() + "/SvUsuario");
			}
		} else {
			response.sendRedirect(request.getContextPath() + "/pages/logIn.jsp");
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}