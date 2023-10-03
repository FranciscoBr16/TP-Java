package servlets;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbUsuario;
import entities.Usuario;

@WebServlet("/SvSignUp")
public class SvSignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fechaStr = request.getParameter("fecha");
		LocalDate fecha = LocalDate.parse(fechaStr);
		Usuario usu = new Usuario((String)request.getParameter("dni"),(String)request.getParameter("name"),(String)request.getParameter("surname"),(String)request.getParameter("password"),(String)request.getParameter("email"),(String) request.getParameter("phonenumber"),fecha);
		DbUsuario db = new DbUsuario();		
		if(db.newUser(usu)){
			response.sendRedirect("/GYM/pages/signUpExitoso.jsp");
		} else {
			response.sendRedirect("index.jsp");
		}
	}

}
