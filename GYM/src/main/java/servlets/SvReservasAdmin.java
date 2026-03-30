package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbActividades;

@WebServlet("/SvReservasAdmin")
public class SvReservasAdmin extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    DbActividades db = new DbActividades();
	    
	    String dni = request.getParameter("dni");
	    String nombre = request.getParameter("nombre");
	    String fecha = request.getParameter("fecha");

	    boolean hayFiltros = (dni != null && !dni.trim().isEmpty()) ||
	                         (nombre != null && !nombre.trim().isEmpty()) ||
	                         (fecha != null && !fecha.trim().isEmpty());

	    if (hayFiltros) {
	        request.setAttribute("reservas", db.getReservasFiltradas(dni, nombre, fecha));
	    } else {
	        request.setAttribute("reservas", db.getTodasLasReservas());
	    }

	    request.getRequestDispatcher("/pages/reservasAdmin.jsp").forward(request, response);
	}
        
}
