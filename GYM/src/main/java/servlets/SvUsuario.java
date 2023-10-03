package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbContrato;
import entities.Contrato;
import entities.Usuario;


@WebServlet("/SvUsuario")
public class SvUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public SvUsuario() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Usuario usuario = (Usuario) request.getSession().getAttribute("user");
		DbContrato dbcont = new DbContrato();
		Contrato miContrato = dbcont.getContratoActualUsu(usuario);
		request.setAttribute("contrato", miContrato);
		request.getRequestDispatcher("/pages/perfil.jsp").forward(request,response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
