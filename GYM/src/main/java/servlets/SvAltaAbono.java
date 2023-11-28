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

import db.DbAbono;
import db.DbActividades;
import entities.Abono;


@WebServlet("/SvAltaAbono")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024*10, // 10 MB
	    maxFileSize = 1024 * 1024 * 50,  // 50 MB
	    maxRequestSize = 1024 * 1024 * 100 // 100 MB
	)
public class SvAltaAbono extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String UPLOAD_DIR = "img/inputs";      
   
    public SvAltaAbono() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Part filePart = request.getPart("imagen");
		String fileName = filePart.getSubmittedFileName();
		
		Integer cantReservas = (Integer.parseInt(request.getParameter("cantReservas")));
		Integer precio = (Integer.parseInt(request.getParameter("precio")));
		String nombreAbono = request.getParameter("nombreAbono");
		String descripcion = request.getParameter("descripcion");
		
		
		DbAbono manejador = new DbAbono();
		Abono abono = new Abono( cantReservas, precio, nombreAbono, descripcion);
		
		
		DbAbono dbAbono = new DbAbono();
		
		Abono a2 = dbAbono.nuevoAbono(abono);
		
		if ( a2 != null) {
			if (filePart != null ){
			Integer id = a2.getIdAbono();
			
			
	        String applicationPath = request.getServletContext().getRealPath("");
	        System.out.println(applicationPath);
	      
	   
	        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR ;
	       
	        String newfileName = "abon"+ id.toString();
	       
	        
	        filePart.write(uploadFilePath+ File.separator  + newfileName + this.getFileExtension(fileName));
	       
	      
	        /* System.out.println("Upload File Directory=" + uploadFilePath  + newfileName);
	        
			request.setAttribute("message", newfileName + " File uploaded successfully!"); */

			a2.setImagen("/GYM/" + UPLOAD_DIR  + "/" + newfileName + this.getFileExtension(fileName));
			
			int b = manejador.actualizarImgAbono(a2);
			}
			
			response.sendRedirect("/GYM/SvAbono");
		} else {response.sendRedirect("/GYM/index.jsp");}
	
}
	
	private String getFileExtension(String name) {
	    int lastIndexOf = name.lastIndexOf(".");
	    if (lastIndexOf == -1) {
	        return ""; // empty extension
	    }
	    return name.substring(lastIndexOf);
	}
		
		
		
}

