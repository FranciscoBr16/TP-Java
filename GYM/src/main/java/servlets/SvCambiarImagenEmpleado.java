package servlets;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import db.DbEmpleado;
import entities.Empleado;

@WebServlet("/SvCambiarImagenEmpleado")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)
public class SvCambiarImagenEmpleado extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String PROJECT_PATH =
            "C:\\Users\\bebof\\Desktop\\Bebo\\5to Año\\Java\\TP-Java\\GYM\\src\\main\\webapp\\img\\empleados";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer id = (Integer) request.getSession().getAttribute("idempleado");

        Part filePart = request.getPart("imagen");
        String fileName = filePart.getSubmittedFileName();

        String extension = getFileExtension(fileName);
        String newFileName = "emp_" + id + extension;

        File uploadDir = new File(PROJECT_PATH);

        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String fullPath = PROJECT_PATH + File.separator + newFileName;

        filePart.write(fullPath);

        Empleado e = new Empleado(id);
        e.setImagen("/GYM/img/empleados/" + newFileName);

        DbEmpleado manejador = new DbEmpleado();
        int r = manejador.actualizarImg(e);

        if (r > 0) {
            response.sendRedirect("/GYM/SvEmpleados");
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