package servlets;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbFactura;
import db.DbProducto;
import entities.Factura;
import entities.Producto;
import entities.Usuario;


@WebServlet("/SvCompra")
public class SvCompra extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public SvCompra() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Producto p = new Producto(Integer.parseInt(request.getParameter("id")));
		DbProducto db = new DbProducto();
		request.setAttribute("producto", db.getProducto(p));
		request.getRequestDispatcher("/pages/finalCompra.jsp").forward(request,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Producto p = new Producto(Integer.parseInt(request.getParameter("id")));
		DbProducto db = new DbProducto();
		Producto p2 = db.getProducto(p);
		DbFactura dbf = new DbFactura();
		Factura f = new Factura();
		
		f.setFecha(LocalDate.now());
		f.setTipo("C");
		f.setCUIT("6942069");
		f.setUsuario((Usuario) request.getSession().getAttribute("user"));
		f.setProducto(p2);
		
		if(dbf.nuevaFactura(f)){
			db.actualizarStock(p2);
			response.sendRedirect("/GYM/SvUsuario");
		}
		else {
			response.sendRedirect("/GYM/index.jsp");
		}
		
		
		
	}
	
	

}
