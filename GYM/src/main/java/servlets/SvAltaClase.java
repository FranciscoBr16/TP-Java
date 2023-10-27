package servlets;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import db.DbActividades;
import db.DbEmpleado;
import entities.Clase;

@WebServlet("/SvAltaClase")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024*10, // 10 MB
	    maxFileSize = 1024 * 1024 * 50,  // 50 MB
	    maxRequestSize = 1024 * 1024 * 100 // 100 MB
	)
public class SvAltaClase extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String UPLOAD_DIR = "img";

    public SvAltaClase() {
        super();

    }
    
   

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
		
		Clase c = new Clase(request.getParameter("nombre"), request.getParameter("descripcion"), Integer.parseInt(request.getParameter("cupo")),request.getParameter("dia"), Integer.parseInt(request.getParameter("horario")),request.getParameter("tipo"),Integer.parseInt(request.getParameter("idEmp")));
		
		Part filePart = request.getPart("imagen");
		
		DbActividades manejador = new DbActividades();
		
		Clase c2 = manejador.nuevaClase(c);
		
		if ( c2 != null) {
			Integer id = c2.getIdClase();
			
			 // gets absolute path of the web application
	        String applicationPath = request.getServletContext().getRealPath("");
	      
	        // constructs path of the directory to save uploaded file
	        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR ;
	       
	        String fileName = id.toString();
	       
	        
	        filePart.write(uploadFilePath  + fileName);
	       
	      
	        System.out.println("Upload File Directory=" + uploadFilePath  + fileName);
	        
			request.setAttribute("message", fileName + " File uploaded successfully!");
			
			c.setImagen(uploadFilePath  + fileName);
			
			int b = manejador.actualizarImgClase(c);
			
			response.sendRedirect("/GYM/pages/actividades.jsp");
		} else {response.sendRedirect("/GYM/pages/index.jsp");}
	
	} catch (Exception e) {
        response.getWriter().println("Error al cargar la imagen: " + e.getMessage());
    }
}
	
}


