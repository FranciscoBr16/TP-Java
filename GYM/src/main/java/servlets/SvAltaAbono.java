package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbAbono;
import entities.Abono;


@WebServlet("/SvAltaAbono")
public class SvAltaAbono extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public SvAltaAbono() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Integer cantReservas = (Integer.parseInt(request.getParameter("cantReservas")));
		Integer precio = (Integer.parseInt(request.getParameter("precio")));
		String nombreAbono = request.getParameter("nombreAbono");
		String descripcion = request.getParameter("descripcion");
		
		Abono abono = new Abono( cantReservas, precio, nombreAbono, descripcion);
		
		DbAbono dbAbono = new DbAbono();
		
		dbAbono.insertarAbono(abono);
		
		response.sendRedirect("/GYM/SvAbono");
		
		
		
		
}
}
