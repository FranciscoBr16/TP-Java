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


@WebServlet("/SvModificacionUsuario")
public class SvModificacionUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public SvModificacionUsuario() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email"); 
		String clave = request.getParameter("password"); 
		String name = request.getParameter("name"); 
		String surname = request.getParameter("surname"); 
		String phonenumber = request.getParameter("phonenumber"); 
		String fechaStr = request.getParameter("birthdate");
		LocalDate fecha = LocalDate.parse(fechaStr);
		String dni = ((Usuario)request.getSession().getAttribute("user")).getDni();
		
		Usuario user = new Usuario(dni, name, surname, clave, email, phonenumber, fecha);
		
		DbUsuario manejadorDb = new DbUsuario();
		
		if(manejadorDb.actualizarUsuario(user) > 0 ) {
			request.getSession().setAttribute("user",user);
			response.sendRedirect("/GYM/SvUsuario");
		} else {
			response.sendRedirect("/GYM/index.jsp");
		}
		
		
	}

}
