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

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Clase clase = new Clase(Integer.parseInt(request.getParameter("id")));
		DbActividades dbact = new DbActividades();
		Usuario usuario = (Usuario)request.getSession().getAttribute("user");
		DbContrato dbcon = new DbContrato();
		
		
		if(dbact.cupoClases(clase)) {
			if(dbact.disponibilidadAbono(usuario)) {
				if(dbact.agregarInscripcion(usuario, clase)) {
					dbcon.actualizaClasesDisponibles(usuario);
					response.sendRedirect("/GYM/SvUsuario");
				}
			}
		}	else {
			response.sendRedirect("/GYM/index.jsp");
		}
		
		
		
		
	}

}
