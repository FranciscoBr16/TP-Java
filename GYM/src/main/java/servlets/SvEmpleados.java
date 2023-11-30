package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbEmpleado;


@WebServlet("/SvEmpleados")
public class SvEmpleados extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SvEmpleados() {
        super();

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DbEmpleado db = new DbEmpleado();
		request.setAttribute("empleados", db.getEmpleados());
		request.getRequestDispatcher("/pages/sobreNosotros.jsp").forward(request,response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
