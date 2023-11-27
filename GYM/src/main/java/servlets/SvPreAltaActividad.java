package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbEmpleado;
import entities.Empleado;


@WebServlet("/SvActividadesEmpleado")
public class SvActividadesEmpleado extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	DbEmpleado dbemp = new DbEmpleado();
    	ArrayList<Empleado> empleados = new ArrayList<>();
    	empleados.addAll(dbemp.getEmpleados());
    	request.setAttribute("empleados", empleados);
    	request.getRequestDispatcher("/pages/nuevaActividad.jsp").forward(request,response);
    	
	}


}
