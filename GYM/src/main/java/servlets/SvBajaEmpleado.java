package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbEmpleado;
import db.DbUsuario;
import entities.Empleado;
import entities.Usuario;


@WebServlet("/SvBajaEmpleado")
public class SvBajaEmpleado extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SvBajaEmpleado() {
        super();
    
    }



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Empleado emp = new Empleado(Integer.parseInt(request.getParameter("id_empleado")));
		DbEmpleado dbemp = new DbEmpleado();
		if (dbemp.deleteEmpleado(emp) == 1) {
			response.sendRedirect("/GYM/index.jsp");
			
		} else {
			
		}
	}

}
