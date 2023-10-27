package servlets;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbAbono;
import entities.Abono;


@WebServlet("/SvModificarAbono")
public class SvModificarAbono extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public SvModificarAbono() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		Abono a = new Abono(Integer.parseInt(request.getParameter("id")));
		DbAbono manejador = new DbAbono();
		a = manejador.getAbono(a);
		request.setAttribute("abono", a);
		request.getRequestDispatcher("/pages/modificarAbono.jsp").forward(request, response);
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nombreAbono = request.getParameter("nombreAbono"); 
		Integer cantReservas = Integer.parseInt(request.getParameter("cantReservas")); 
		Integer precio = Integer.parseInt(request.getParameter("precio")); 
		String descripcion = request.getParameter("descripcion"); 
		Integer idAbono = Integer.parseInt(request.getParameter("idAbono")); 
		
		Abono abono = new Abono(idAbono, nombreAbono, cantReservas, precio, descripcion);
		
		DbAbono manejadorDb = new DbAbono();
		
		if(manejadorDb.actualizarAbono(abono) > 0 ) {
			response.sendRedirect("/GYM/SvAbono");
		} else {
			response.sendRedirect("/GYM/index.jsp");
		}
		
		
	}

}