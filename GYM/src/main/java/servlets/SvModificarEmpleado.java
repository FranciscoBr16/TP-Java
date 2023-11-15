package servlets;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbEmpleado;
import entities.Empleado;


@WebServlet("/SvModificarEmpleado")
public class SvModificarEmpleado extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public SvModificarEmpleado() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Empleado e = new Empleado(Integer.parseInt(request.getParameter("id")));
		DbEmpleado manejador = new DbEmpleado();
		e = manejador.getEmpleado(e);
		request.setAttribute("empleado", e);
		request.getRequestDispatcher("/pages/modificarEmpleado.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String nombre = request.getParameter("nombre"); 
		String apellido = request.getParameter("apellido"); 
		String email = request.getParameter("email"); 
		String fechaDesde = request.getParameter("fechaDesde");
		LocalDate fecha = LocalDate.parse(fechaDesde);
		String rol = request.getParameter("rol"); 
		// String imagen = request.getParameter("imagen"); 
		
		Empleado emp = new Empleado(nombre, apellido, email, fecha, rol);
		
		DbEmpleado manejadorDb = new DbEmpleado();
		
		if(manejadorDb.actualizarEmpleado(emp) > 0 ) {
			response.sendRedirect("/GYM/SvConsultaEmpleado");
		} else {
			response.sendRedirect("/GYM/index.jsp");
		}
		
		
	}
	}


