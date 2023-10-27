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
		
		
		Clase c = new Clase(request.getParameter("nombre"), request.getParameter("descripcion"), Integer.parseInt(request.getParameter("cupo")),request.getParameter("dia"), Integer.parseInt(request.getParameter("horario")),request.getParameter("tipo"),Integer.parseInt(request.getParameter("idEmp")));
		
		Part filePart = request.getPart("imagen");
		String fileName = filePart.getSubmittedFileName();
		
		DbActividades manejador = new DbActividades();
		
		Clase c2 = manejador.nuevaClase(c);
		
		if ( c2 != null) {
			Integer id = c2.getIdClase();
			//extraer extension 
			// int dotIndex = fileName.lastIndexOf('.');
			
			 //applicationPath gets absolute path of the web application
	        String applicationPath = request.getServletContext().getRealPath("");
	        System.out.println(applicationPath);
	      
	        // constructs path of the directory to save uploaded file
	        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR ;
	       
	        String newfileName = id.toString();
	       
	        
	        filePart.write(uploadFilePath+ File.separator  + newfileName +".png");
	       
	      
	        System.out.println("Upload File Directory=" + uploadFilePath  + newfileName);
	        
			request.setAttribute("message", newfileName + " File uploaded successfully!");
			
			c.setImagen(uploadFilePath  + File.separator + "imgClase"+ newfileName + ".png");
			
			int b = manejador.actualizarImgClase(c);
			
			response.sendRedirect("/GYM/pages/reservas.jsp");
		} else {response.sendRedirect("/GYM/pages/index.jsp");}
	

}
	
}


