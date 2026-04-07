package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbProducto;
import entities.Usuario;


@WebServlet("/SvModificarProductos")
public class SvModificarProductos extends HttpServlet {
	private static final long serialVersionUID = 1L;


    public SvModificarProductos() {
        super();

    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	
    	Usuario usuario = (Usuario) request.getSession().getAttribute("user");
        if (usuario == null || !usuario.isAdmin()) {
            response.sendRedirect("/GYM/index.jsp");
            return;
        }

        String nombre      = request.getParameter("txtBuscar");
        String ordenPrecio = request.getParameter("ordenPrecio");

        DbProducto db = new DbProducto();
        request.setAttribute("productos", db.getAllProductos(nombre, ordenPrecio));
        request.getRequestDispatcher("/pages/modificarProductos.jsp").forward(request, response);
    }


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}

