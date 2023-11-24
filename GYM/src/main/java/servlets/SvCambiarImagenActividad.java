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
import entities.Clase;


@WebServlet("/SvCambiarImagenActividad")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024*10, // 10 MB
	    maxFileSize = 1024 * 1024 * 50,  // 50 MB
	    maxRequestSize = 1024 * 1024 * 100 // 100 MB
	)
public class SvCambiarImagenActividad extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String UPLOAD_DIR = "img/inputs";
	
	public SvCambiarImagenActividad() {
        super();

    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = (Integer)request.getSession().getAttribute("idclase");
		Clase c = new Clase(id);
		Part filePart = request.getPart("imagen");
		String fileName = filePart.getSubmittedFileName();
		DbActividades manejador = new DbActividades();
		
		String applicationPath = request.getServletContext().getRealPath("");
		String newfileName = "act"+ id.toString();
		
		String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR ;
		String aux = uploadFilePath + File.separator + newfileName + this.getFileExtension(fileName);
		File fileSaveDir = new File(aux);
        if (fileSaveDir.exists()) {
        	fileSaveDir.delete();
        }
		
        filePart.write(uploadFilePath+ File.separator  + newfileName + this.getFileExtension(fileName));
        c.setImagen("/GYM/" + UPLOAD_DIR  + "/" + newfileName + this.getFileExtension(fileName));
	
		int b = manejador.actualizarImgClase(c);;
		if (b > 0) {response.sendRedirect("/GYM/SvActividades");}
		else {response.sendRedirect("/GYM/index.jsp");}
		
	}

private String getFileExtension(String name) {
    int lastIndexOf = name.lastIndexOf(".");
    if (lastIndexOf == -1) {
        return ""; // empty extension
    }
    return name.substring(lastIndexOf);
}

}
