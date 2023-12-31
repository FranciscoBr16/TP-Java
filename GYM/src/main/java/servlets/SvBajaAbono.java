package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbAbono;
import entities.Abono;

@WebServlet({"/SvBajaAbono"})
public class SvBajaAbono extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public SvBajaAbono() {
        super();
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Abono abono = new Abono(Integer.parseInt(request.getParameter("id")));
		DbAbono dbabono = new DbAbono();
		
		if (dbabono.deleteAbono(abono) > 0) {
			response.sendRedirect("/GYM/SvAbono");
		} else {
			response.sendRedirect("/GYM/index.jsp");
		}
		
	}

}
