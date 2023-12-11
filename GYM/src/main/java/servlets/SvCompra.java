package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbProducto;
import entities.Producto;


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
		db.actualizarStock(p2);
		response.sendRedirect("/GYM/index.jsp");
	}

}
