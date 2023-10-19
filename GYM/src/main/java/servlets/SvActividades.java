package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbAbono;
import db.DbActividades;
import entities.Clase;


@WebServlet("/SvActividades")
public class SvActividades extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SvActividades() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DbActividades manejador = new DbActividades();
		ArrayList<Clase> actividades = new ArrayList<>();
		actividades.addAll(manejador.getActividades());
		request.setAttribute("actividades", actividades);
		request.getRequestDispatcher("/pages/actividades.jsp").forward(request,response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
