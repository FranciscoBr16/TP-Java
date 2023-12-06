package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbProducto;


@WebServlet("/SvProductos")
public class SvProductos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SvProductos() {
        super();
       
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DbProducto db = new DbProducto();
		request.setAttribute("productos", db.getProductos());
		request.getRequestDispatcher("/pages/productos.jsp").forward(request,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
