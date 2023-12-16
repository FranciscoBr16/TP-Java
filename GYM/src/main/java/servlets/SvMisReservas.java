package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbActividades;
import entities.Inscripcion;
import entities.Usuario;


@WebServlet("/SvMisReservas")
public class SvMisReservas extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SvMisReservas() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Usuario usuario = (Usuario) request.getSession().getAttribute("user");
		DbActividades db = new DbActividades();
		ArrayList<Inscripcion> ins = new ArrayList<>();
		ins.addAll(db.getMisReservas(usuario));
		request.setAttribute("reservas", ins);
		request.getRequestDispatcher("/pages/misInscripciones.jsp").forward(request,response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

}
