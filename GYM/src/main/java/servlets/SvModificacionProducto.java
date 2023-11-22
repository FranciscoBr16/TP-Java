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
import entities.Producto;


@WebServlet("/SvModificacionProducto")
public class SvModificacionProducto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public SvModificacionProducto() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Producto p = new Producto(Integer.parseInt(request.getParameter("id")));
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
		LocalDate fecha_desde = LocalDate.parse(request.getParameter("nombre"));
		Integer precio = Integer.parseInt(request.getParameter("precio")); 
		// String imagen = request.getParameter("imagen"); 
		
		Producto p = new Producto(id_producto, stock,descripcion, nombre, fecha_desde, precio);
		
		DbProducto manejadorDb = new DbProducto();
		
		if(manejadorDb.actualizarProducto(p) > 0 ) {
			response.sendRedirect("/GYM/SvConsultaProducto");
		} else {
			response.sendRedirect("/GYM/index.jsp");
		}
		
		
	}


}
