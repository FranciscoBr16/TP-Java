package servlets;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbProducto;
import entities.Precio;
import entities.Producto;

/**
 * Servlet implementation class SvModificarPrecioProducto
 */
@WebServlet("/SvModificarPrecioProducto")
public class SvModificarPrecioProducto extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public SvModificarPrecioProducto() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id_producto = Integer.parseInt(request.getParameter("id"));
		
		LocalDate fecha_desde = LocalDate.parse(request.getParameter("fecha"));
		Integer precio = Integer.parseInt(request.getParameter("precio")); 
		Producto p = new Producto(id_producto,fecha_desde,precio);
		DbProducto manejador = new DbProducto();
		if(manejador.actualizarPrecio(p)) {
			response.sendRedirect("/GYM/SvProductos");
		} else {
			response.sendRedirect("/GYM/index.jsp");
		}
		
	}

}
