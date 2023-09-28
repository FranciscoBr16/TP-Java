package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbHandler;
import entities.Abono;

@WebServlet("/SvAbono")
public class SvAbono extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public SvAbono() {
 
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DbHandler manejador = new DbHandler();
		ArrayList<Abono> abonos = new ArrayList<>();
		abonos.addAll(manejador.getAbonos());
		request.getSession().setAttribute("listaAbono", abonos);
		response.sendRedirect("/GYM/Abono");
	
	}

}
