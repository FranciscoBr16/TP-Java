package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import db.DbFactura;
import entities.Clase;
import entities.Factura;
import entities.Usuario;


@WebServlet("/SvMisFacturas")
public class SvMisFacturas extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public SvMisFacturas() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Usuario usuario = (Usuario) request.getSession().getAttribute("user");
		DbFactura dbfac = new DbFactura();
		ArrayList<Factura> facturas = new ArrayList<>();
		facturas.addAll(dbfac.getmisfacturas(usuario));
		request.setAttribute("facturas", facturas);
		request.getRequestDispatcher("/pages/misFacturas.jsp").forward(request,response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
