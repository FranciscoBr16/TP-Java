package servlets;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import db.DbProducto;
import entities.Indumentaria;


@WebServlet("/SvAltaIndumentaria")
public class SvAltaIndumentaria extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String UPLOAD_DIR = "img";   
  
    public SvAltaIndumentaria() {
        super();
        
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DbProducto manejador = new DbProducto();
		Part filePart = request.getPart("imagen");
		String fileName = filePart.getSubmittedFileName();
		String applicationPath = request.getServletContext().getRealPath("");
        System.out.println(applicationPath);
        Indumentaria ind = new Indumentaria(request.getParameter("descripcion"),request.getParameter("nombre"), Integer.parseInt(request.getParameter("stock")), Integer.parseInt(request.getParameter("precio")), request.getParameter("talle"));
		Indumentaria ind2 = manejador.nuevaIndumentaria(ind);
		
		if (ind2 != null) {
		Integer id = ind2.getIdProducto();
	    String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR ;
	    String newfileName = "Ind_" + id.toString();
	    filePart.write(uploadFilePath+ File.separator  + newfileName + this.getFileExtension(fileName));
	    ind2.setImagen("/GYM/" + UPLOAD_DIR  + "/" + newfileName + this.getFileExtension(fileName));
	    int b = manejador.actualizarImg(ind2);
	    
	    if (b > 0) {response.sendRedirect("/GYM/SvProductos");
		} else {response.sendRedirect("/GYM/pages/index.jsp");}
		}
	}
	
	private String getFileExtension(String name) {
	    int lastIndexOf = name.lastIndexOf(".");
	    if (lastIndexOf == -1) {
	        return ""; // empty extension
	    }
	    return name.substring(lastIndexOf);
	}
	}


