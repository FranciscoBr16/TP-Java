package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import db.DbActividades;
import entities.Clase;


@WebServlet("/SvAltaSalon")
public class SvAltaSalon extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SvAltaSalon() {
        super();
     
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
					
		Clase c = new Clase(request.getParameter("nombre"), Integer.parseInt(request.getParameter("cupo")), request.getParameter("dia"), request.getParameter("horario"),request.getParameter("tipo"));
		
		DbActividades manejador = new DbActividades();
		
		if (manejador.nuevoSalon(c) > 0) {
		
		response.sendRedirect("/GYM/pages/reservas.jsp");
		} else  response.sendRedirect("/GYM/index.jsp");
	
	}

}
