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
        DbContrato dbcon = new DbContrato();
        Usuario usuario = (Usuario) request.getSession().getAttribute("user");

        String mensaje = null;
        String tipo = "danger"; 

        if (!dbact.cupoClases(clase)) {
            mensaje = "No hay cupos disponibles para esta clase.";
        } 
        else if (!dbact.disponibilidadAbono(usuario)) {
            mensaje = "No tenés clases disponibles en tu abono.";
        } 
        else if (!dbact.agregarInscripcion(usuario, clase)) {
            mensaje = "Ocurrió un error al realizar la inscripción.";
        } 
        else {
            dbcon.actualizaClasesDisponibles(usuario);
            mensaje = "Inscripción realizada correctamente.";
            tipo = "success";
        }

        request.getSession().setAttribute("mensaje", mensaje);
        request.getSession().setAttribute("tipoMensaje", tipo);

        response.sendRedirect(request.getContextPath() + "/SvMusculacion");
    }
		
		
		
		
	}


