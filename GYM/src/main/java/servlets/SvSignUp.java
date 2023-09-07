package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbHandler;
import entities.Usuario;

@WebServlet("/SvSignUp")
public class SvSignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public SvSignUp() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		String fechaStr = request.getParameter("fecha");
		LocalDate fecha = LocalDate.parse(fechaStr);
		Usuario usu = new Usuario((String)request.getParameter("dni"),(String)request.getParameter("name"),(String)request.getParameter("surname"),(String)request.getParameter("password"),(String)request.getParameter("email"),(String) request.getParameter("phonenumber"),fecha);
		DbHandler db = new DbHandler();		
		if(db.newUser(usu)){
			response.sendRedirect("/GYM/pages/signUpExitoso.jsp");
		} else {
			response.sendRedirect("index.jsp");
		}
	}

}
