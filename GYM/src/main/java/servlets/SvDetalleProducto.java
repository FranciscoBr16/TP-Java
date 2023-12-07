package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbProducto;
import entities.Producto;


@WebServlet("/SvDetalleProducto")
public class SvDetalleProducto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public SvDetalleProducto() {
        super();
       
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DbProducto db = new DbProducto();
		int id = Integer.parseInt(request.getParameter("id"));
		Producto p = new Producto(id);
		Producto p2 = db.getProducto(p);
		request.setAttribute("producto", p2);
		request.getRequestDispatcher("/pages/detalleProducto.jsp").forward(request,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
