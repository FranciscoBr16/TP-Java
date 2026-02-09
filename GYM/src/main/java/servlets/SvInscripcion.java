package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
	    
	    HttpSession session = request.getSession();

	    if (usuario == null) {
	        session.setAttribute("mensaje", "Debes iniciar sesión para reservar.");
	        session.setAttribute("tipoMensaje", "warning");
	        response.sendRedirect(origen);
	        return;
	    }

	    if (!dbact.cupoClases(clase)) {
	        session.setAttribute("mensaje", "No hay cupos disponibles para esta clase.");
	        session.setAttribute("tipoMensaje", "danger");
	        response.sendRedirect(origen);
	        return;
	    }

	    if (!dbact.disponibilidadAbono(usuario)) {
	        session.setAttribute("mensaje", "No tienes un abono disponible.");
	        session.setAttribute("tipoMensaje", "warning");
	        response.sendRedirect(origen);
	        return;
	    }

	    if (dbact.agregarInscripcion(usuario, clase)) {
	        dbcon.actualizaClasesDisponibles(usuario);
	        session.setAttribute("mensaje", "Reserva realizada con éxito.");
	        session.setAttribute("tipoMensaje", "success");
	        response.sendRedirect(origen);
	    } else {
	        session.setAttribute("mensaje", "No se pudo realizar la reserva.");
	        session.setAttribute("tipoMensaje", "danger");
	        response.sendRedirect(origen);
	    }
	}

		
		
		
		
	}


