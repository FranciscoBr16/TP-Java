package servlets;


import java.io.File;
import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import db.DbEmpleado;
import entities.Empleado;



@WebServlet("/SvAltaEmpleado")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024*10, // 10 MB
	    maxFileSize = 1024 * 1024 * 50,  // 50 MB
	    maxRequestSize = 1024 * 1024 * 100 // 100 MB
	)
public class SvAltaEmpleado extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String UPLOAD_DIR = "img/empleado";
       

    public SvAltaEmpleado() {
        super();
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String nombre = request.getParameter("nombre");
		String apellido = request.getParameter("apellido");
		String correo = request.getParameter("correo");
		String rol = request.getParameter("rol");
		
		LocalDate fecha_desde = LocalDate.now();
		
		Empleado emp = new Empleado(nombre, apellido, correo, rol, fecha_desde);
		
		DbEmpleado dbEmpleado = new DbEmpleado();
		
		
		Part filePart = request.getPart("imagen");
		String fileName = filePart.getSubmittedFileName();
		String applicationPath = request.getServletContext().getRealPath("");

		Empleado emp2 = dbEmpleado.nuevoEmpleado(emp);
		if ( emp2 != null) {
			Integer id = emp2.getIdEmpleado();
	        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR ;
	       
	        String newfileName = "emp_" + id.toString();
	       
	        
	        filePart.write(uploadFilePath+ File.separator  + newfileName + this.getFileExtension(fileName));
	       
	    
			emp2.setImagen("/GYM/" + UPLOAD_DIR  + "/" + newfileName + this.getFileExtension(fileName));
			
			int b = dbEmpleado.actualizarImg(emp2);
			
			response.sendRedirect("/GYM/SvEmpleados");
		} else {response.sendRedirect("/GYM/pages/index.jsp");}
	
	}
	
	private String getFileExtension(String name) {
	    int lastIndexOf = name.lastIndexOf(".");
	    if (lastIndexOf == -1) {
	        return ""; // empty extension
	    }
	    return name.substring(lastIndexOf);
	}

}