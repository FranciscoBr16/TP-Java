package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbAbono;
import db.DbUsuario;
import entities.Abono;
import entities.Usuario;


@WebServlet("/SvDeleteUser")
public class SvDeleteUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SvDeleteUser() {
        super();
 
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Abono abono = new Abono(Integer.parseInt((String)request.getAttribute("id")));
		
		DbAbono dbabono = new DbAbono();
		if (dbabono.deleteAbono(abono)) {
			request.getSession().setAttribute("user", null);
			response.sendRedirect("index.jsp");
		} else {
			response.sendRedirect("/GYM/SvUsuario");
		}
		
	}

}
