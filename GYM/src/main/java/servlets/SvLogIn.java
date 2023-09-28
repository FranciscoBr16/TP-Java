package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbHandler;
import entities.Usuario;

@WebServlet("/SvLogIn")
public class SvLogIn extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SvLogIn() {
        super();
       
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Usuario user = new Usuario(request.getParameter("dni"), request.getParameter("password"));
		// hay que validar que sea un usuario valido 
		DbHandler db = new DbHandler();	
		if ( db.logIn(user) != null) {
			request.getSession().setAttribute("user",user);
			
			response.sendRedirect("index.jsp");
		} else {
			response.sendRedirect("/GYM/SvLogIn");
		}
			
	}

}
