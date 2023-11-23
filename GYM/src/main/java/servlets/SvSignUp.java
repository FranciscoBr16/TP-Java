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
		String fechaStr = (String)request.getParameter("fecha");
		LocalDate fecha = LocalDate.parse(fechaStr);
		Usuario usu = new Usuario(request.getParameter("dni"),request.getParameter("name"),request.getParameter("surname"),request.getParameter("password"),request.getParameter("email"),request.getParameter("phonenumber"),fecha,request.getParameter("imagenesPerfil"));
		DbUsuario db = new DbUsuario();		
		if(db.newUser(usu)){
			response.sendRedirect("/GYM/pages/signUpExitoso.jsp");
		} else {
			response.sendRedirect("index.jsp");
		}
	}

}
