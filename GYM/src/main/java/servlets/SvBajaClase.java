package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbActividades;
import entities.Clase;



@WebServlet("/SvBajaClase")
public class SvBajaClase extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public SvBajaClase() {
        super();
       
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Clase c = new Clase(Integer.parseInt(request.getParameter("id")));
		DbActividades mnj = new DbActividades();
		if (mnj.deleteActividad(c) > 0) {
			getServletContext().getRequestDispatcher("/pages/reservas.jsp").forward(request, response);
		} else {
			getServletContext().getRequestDispatcher("/pages/reservas.jsp").forward(request, response);
		}
		
		
	}

}
