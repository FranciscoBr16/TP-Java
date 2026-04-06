package servlets;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer id = (Integer) request.getSession().getAttribute("idclase");

        if (id == null) {
            response.sendRedirect("/GYM/index.jsp");
            return;
        }

        Part filePart = request.getPart("imagen");

        if (filePart == null || filePart.getSize() == 0) {
            response.sendRedirect("/GYM/SvActividades");
            return;
        }

        String originalName = filePart.getSubmittedFileName();
        String extension = getFileExtension(originalName);

        String newFileName = "act" + id + extension;

        String projectPath = "C:\\Users\\bebof\\Desktop\\Bebo\\5to Año\\Java\\TP-Java\\GYM\\src\\main\\webapp\\img\\inputs";

        File uploadDir = new File(projectPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // borrar imagen anterior
        File[] files = uploadDir.listFiles();
        if (files != null) {
            for (File f : files) {
                if (f.getName().startsWith("act" + id)) {
                    f.delete();
                }
            }
        }

        String filePath = projectPath + File.separator + newFileName;

        filePart.write(filePath);

        Clase c = new Clase(id);
        c.setImagen("/GYM/img/inputs/" + newFileName);

        DbActividades manejador = new DbActividades();
        int r = manejador.actualizarImgClase(c);

        if (r > 0) {
            response.sendRedirect("/GYM/SvActividades");
        } else {
            response.sendRedirect("/GYM/index.jsp");
        }
    }

    private String getFileExtension(String name) {
        int lastIndex = name.lastIndexOf(".");
        if (lastIndex == -1) return "";
        return name.substring(lastIndex);
    }
}