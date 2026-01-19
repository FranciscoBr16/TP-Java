package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbActividades;
import db.DbContrato;
import entities.Clase;
import entities.Usuario;


@WebServlet("/SvInscripcion")
public class SvInscripcion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public SvInscripcion() {
        super(); 
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    Clase clase = new Clase(Integer.parseInt(request.getParameter("id")));
	    DbActividades dbact = new DbActividades();
	    Usuario usuario = (Usuario) request.getSession().getAttribute("user");
	    DbContrato dbcon = new DbContrato();

	    String origen = request.getHeader("Referer"); 

	    if (usuario == null) {
	        request.getSession().setAttribute("mensajeError", "Debes iniciar sesión para reservar.");
	        response.sendRedirect(origen);
	        return;
	    }

	    if (!dbact.cupoClases(clase)) {
	        request.getSession().setAttribute("mensajeError", "No hay cupos disponibles para esta clase.");
	        response.sendRedirect(origen);
	        return;
	    }

	    if (!dbact.disponibilidadAbono(usuario)) {
	        request.getSession().setAttribute("mensajeError", "No tienes un abono disponible.");
	        response.sendRedirect(origen);
	        return;
	    }

	    if (dbact.agregarInscripcion(usuario, clase)) {
	        dbcon.actualizaClasesDisponibles(usuario);
	        request.getSession().setAttribute("mensajeOk", "Reserva realizada con éxito.");
	        response.sendRedirect(origen);
	    } else {
	        request.getSession().setAttribute("mensajeError", "No se pudo realizar la reserva.");
	        response.sendRedirect(origen);
	    }
	}

		
		
		
		
	}


