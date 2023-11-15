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


@WebServlet("/SvEmpleado")
public class SvAltaEmpleado extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SvAltaEmpleado() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Integer id_empleado = Integer.parseInt(request.getParameter("id_empleado"));
		String nombre = request.getParameter("nombre");
		String apellido = request.getParameter("apellido");
		String correo = request.getParameter("correo");
		String rol = request.getParameter("rol");
		LocalDate fecha_desde = LocalDate.now();
		
		Empleado empleado = new Empleado(id_empleado, nombre, apellido, correo, rol, fecha_desde);
		
		DbEmpleado dbEmpleado = new DbEmpleado();
		
		response.sendRedirect("/GYM/SvConsultaEmpleado");
		
	}

}
