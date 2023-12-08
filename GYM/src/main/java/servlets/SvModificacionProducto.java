package servlets;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbEmpleado;
import db.DbProducto;
import entities.Empleado;
import entities.Indumentaria;
import entities.Producto;
import entities.Suplemento;


@WebServlet("/SvModificacionProducto")
public class SvModificacionProducto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public SvModificacionProducto() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Producto p = new Producto(Integer.parseInt(request.getParameter("id_producto")));
		DbProducto manejador = new DbProducto();
		p = manejador.getProducto(p);
		request.setAttribute("producto", p);
		request.getRequestDispatcher("/pages/modificarProducto.jsp").forward(request, response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id_producto = Integer.parseInt(request.getParameter("id_producto"));
		Integer stock = Integer.parseInt(request.getParameter("stock")); 
		String descripcion = request.getParameter("descripcion"); 
		String nombre = request.getParameter("nombre"); 
		
		
		DbProducto manejadorDb = new DbProducto();
		
		if(request.getParameter("talle") != null) {
			String talle = request.getParameter("talle"); 
			Indumentaria i = new Indumentaria(id_producto, stock, descripcion, nombre, talle);
			manejadorDb.actualizarIndumentaria(i);
		} else {
			String unidad = request.getParameter("unidad");
			Float valor = Float.parseFloat(request.getParameter("valor"));
			Suplemento s = new Suplemento(id_producto, stock, descripcion, nombre, unidad, valor);
			manejadorDb.actualizarSuplemento(s);
		}
		
		response.sendRedirect("/GYM/SvProductos");
		
		
		
	}


}
