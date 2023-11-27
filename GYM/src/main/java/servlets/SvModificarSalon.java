package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbActividades;
import db.DbEmpleado;
import entities.Clase;


@WebServlet("/SvModificarSalon")
public class SvModificarSalon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public SvModificarSalon() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 Clase c = new Clase(Integer.parseInt(request.getParameter("id")));
			DbActividades manejador = new DbActividades();
			Clase a = manejador.getClase(c);
			request.setAttribute("clase", a);
			request.getRequestDispatcher("/pages/modificarSalon.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer idClase = Integer.parseInt(request.getParameter("id"));
		String nombreClase = request.getParameter("nombre"); 
		Integer cupo = Integer.parseInt(request.getParameter("cupo")); 
		String horario = request.getParameter("horario"); 
		String dia = request.getParameter("dia"); 
		String tipo = request.getParameter("tipo"); 

		
		Clase clase = new Clase(idClase, nombreClase, cupo, dia, horario, tipo);
		
		DbActividades manejadorDb = new DbActividades();
		
		if(manejadorDb.actualizarSalon(clase) > 0 ) {
			response.sendRedirect("/GYM/SvMusculacion");
		} else {
			response.sendRedirect("/GYM/index.jsp");
		}
	}
		
	}


