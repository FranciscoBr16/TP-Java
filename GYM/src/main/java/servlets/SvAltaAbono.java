package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		Integer idAbono = (Integer.parseInt(request.getParameter("idAbono")));
		Integer cantReservas = (Integer.parseInt(request.getParameter("cantReservas")));
		Integer precio = (Integer.parseInt(request.getParameter("precio")));
		String nombreAbono = request.getParameter("nombreAbono");
		String descripcion = request.getParameter("descripcion");
		
		Abono abono = new Abono(idAbono, cantReservas, precio, nombreAbono, descripcion);
		
		/* falta llamado al metodo del manejador */
}
}
