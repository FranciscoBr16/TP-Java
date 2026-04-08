package servlets;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import db.DbProducto;
import entities.Producto;

@WebServlet("/SvCambiarImagenProducto")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 10,  // 10 MB
    maxFileSize = 1024 * 1024 * 50,        // 50 MB
    maxRequestSize = 1024 * 1024 * 100     // 100 MB
)
public class SvCambiarImagenProducto extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    private static final String UPLOAD_DIR = "img/productos";

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer id = (Integer) request.getSession().getAttribute("idproducto");

        if (id == null) {
            response.sendRedirect("/GYM/SvProductos");
            return;
        }

        Part filePart = request.getPart("imagen");
        String fileName = filePart.getSubmittedFileName();

        if (fileName != null && !fileName.isEmpty()) {
            String extension = getFileExtension(fileName);
            String newFileName = "prod_" + id + extension;

            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String fullPath = uploadFilePath + File.separator + newFileName;
            filePart.write(fullPath);

            Producto p = new Producto();
            p.setIdProducto(id);
            p.setImagen("/GYM/" + UPLOAD_DIR + "/" + newFileName);

            DbProducto manejador = new DbProducto();
            int r = manejador.actualizarImg(p);

            if (r > 0) {
                response.sendRedirect("/GYM/SvProductos");
            } else {
                response.sendRedirect("/GYM/index.jsp");
            }
        } else {
            response.sendRedirect("/GYM/SvProductos");
        }
    }

    private String getFileExtension(String name) {
        int lastIndex = name.lastIndexOf(".");
        if (lastIndex == -1) return "";
        return name.substring(lastIndex);
    }
}