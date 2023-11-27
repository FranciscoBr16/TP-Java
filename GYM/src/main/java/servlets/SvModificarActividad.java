package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbAbono;
import db.DbActividades;
import db.DbEmpleado;
import entities.Abono;
import entities.Clase;


@WebServlet("/SvModificarActividad")
public class SvModificarActividad extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public SvModificarActividad() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 Clase c = new Clase(Integer.parseInt(request.getParameter("id")));
		DbActividades manejador = new DbActividades();
		DbEmpleado manejaEmp = new DbEmpleado();
		Clase a = manejador.getClase(c);
		request.setAttribute("clase", a);
		request.setAttribute("empleados", manejaEmp.getEmpleados());
		request.getRequestDispatcher("/pages/modificarActividad.jsp").forward(request, response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer idClase = Integer.parseInt(request.getParameter("idClase"));
		String nombreClase = request.getParameter("nombreClase"); 
		String descripcion = request.getParameter("descripcion"); 
		Integer cupo = Integer.parseInt(request.getParameter("cupo")); 
		String horario = request.getParameter("horario"); 
		
		Integer idEmpleado = Integer.parseInt(request.getParameter("idEmpleado")); 
		String dia = request.getParameter("dia"); 
		String tipo = request.getParameter("tipo"); 

		
		Clase clase = new Clase(idClase, nombreClase,descripcion, cupo, dia, horario, tipo, idEmpleado);
		
		DbActividades manejadorDb = new DbActividades();
		
		if(manejadorDb.actualizarActividad(clase) > 0 ) {
			response.sendRedirect("/GYM/SvActividades");
		} else {
			response.sendRedirect("/GYM/index.jsp");
		}
	}

}
