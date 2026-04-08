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
    fileSizeThreshold = 1024 * 1024 * 10,
    maxFileSize = 1024 * 1024 * 50,
    maxRequestSize = 1024 * 1024 * 100
)
public class SvCambiarImagenActividad extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Definimos la carpeta relativa dentro de webapp
    private static final String UPLOAD_DIR = "img/inputs";

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer id = (Integer) request.getSession().getAttribute("idclase");

        if (id == null) {
            response.sendRedirect("/GYM/index.jsp");
            return;
        }

        Part filePart = request.getPart("imagen");

        if (filePart != null && filePart.getSize() > 0) {
            String originalName = filePart.getSubmittedFileName();
            String extension = getFileExtension(originalName);
            String newFileName = "act" + id + extension;

            // --- LÓGICA DE RUTA RELATIVA ---
            // Obtiene la ruta real en el servidor (funciona en cualquier PC)
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // --- BORRAR IMAGEN ANTERIOR ---
            // Buscamos cualquier archivo que empiece con "actID" para que no queden duplicados
            File[] files = uploadDir.listFiles();
            if (files != null) {
                for (File f : files) {
                    if (f.getName().startsWith("act" + id + ".")) { // Agregué el "." para ser más preciso
                        f.delete();
                    }
                }
            }

            // Guardar el nuevo archivo
            String fullPath = uploadFilePath + File.separator + newFileName;
            filePart.write(fullPath);

            // --- ACTUALIZAR BASE DE DATOS ---
            Clase c = new Clase(id);
            // La ruta que guardamos en la DB es la que entiende el navegador
            c.setImagen("/GYM/" + UPLOAD_DIR + "/" + newFileName);

            DbActividades manejador = new DbActividades();
            int r = manejador.actualizarImgClase(c);

            if (r > 0) {
                response.sendRedirect("/GYM/SvActividades");
            } else {
                response.sendRedirect("/GYM/index.jsp");
            }
        } else {
            // Si no enviaron archivo, volvemos a la lista
            response.sendRedirect("/GYM/SvActividades");
        }
    }

    private String getFileExtension(String name) {
        int lastIndex = name.lastIndexOf(".");
        if (lastIndex == -1) {
			return "";
		}
        return name.substring(lastIndex);
    }
}