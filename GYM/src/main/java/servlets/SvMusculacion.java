package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbActividades;
import entities.Clase;


@WebServlet("/SvMusculacion")
public class SvMusculacion extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public SvMusculacion() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DbActividades manejador = new DbActividades();
		ArrayList<Clase> clases = new ArrayList<>();
		clases.addAll(manejador.getClases());
		request.setAttribute("clases", clases);
		request.getRequestDispatcher("/pages/salonDeMusculacion.jsp").forward(request,response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

}
