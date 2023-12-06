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

import db.DbProducto;
import entities.Suplemento;


@WebServlet("/SvAltaSuplemento")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024*10, // 10 MB
	    maxFileSize = 1024 * 1024 * 50,  // 50 MB
	    maxRequestSize = 1024 * 1024 * 100 // 100 MB
	)
public class SvAltaSuplemento extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String UPLOAD_DIR = "img/productos";
       
 
    public SvAltaSuplemento() {
        super();
      
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DbProducto manejador = new DbProducto();
		Part filePart = request.getPart("imagen");
		String fileName = filePart.getSubmittedFileName();
		String applicationPath = request.getServletContext().getRealPath("");
       
		Suplemento sup = new Suplemento(request.getParameter("descripcion"),request.getParameter("nombre"), Integer.parseInt(request.getParameter("stock")), Integer.parseInt(request.getParameter("precio")), request.getParameter("unidad"), Float.parseFloat(request.getParameter("valor")));
		Suplemento sup2 = manejador.nuevoSuplemento(sup);
		if ( sup2 != null) {
			Integer id = sup2.getIdProducto();
	        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR ;
	       
	        String newfileName = "Sup_" + id.toString();
	       
	        
	        filePart.write(uploadFilePath+ File.separator  + newfileName + this.getFileExtension(fileName));
	       
	    
			sup2.setImagen("/GYM/" + UPLOAD_DIR  + "/" + newfileName + this.getFileExtension(fileName));
			
			int b = manejador.actualizarImg(sup2);
			
			response.sendRedirect("/GYM/SvProductos");
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
