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


    private static final String UPLOAD_DIR = "img/empleados";

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        Integer id = (Integer) request.getSession().getAttribute("idempleado");

        if (id == null) {
            response.sendRedirect("/GYM/SvEmpleados");
            return;
        }

        Part filePart = request.getPart("imagen");
        String fileName = filePart.getSubmittedFileName();

        if (fileName != null && !fileName.isEmpty()) {
            String extension = getFileExtension(fileName);
            String newFileName = "emp_" + id + extension;

            // --- RUTA DINÁMICA (PORTABLE) ---
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }


            File[] files = uploadDir.listFiles();
            if (files != null) {
                for (File f : files) {
                    if (f.getName().startsWith("emp_" + id + ".")) {
                        f.delete();
                    }
                }
            }


            String fullPath = uploadFilePath + File.separator + newFileName;
            filePart.write(fullPath);


            Empleado e = new Empleado(id);

            e.setImagen("/GYM/" + UPLOAD_DIR + "/" + newFileName);

            DbEmpleado manejador = new DbEmpleado();
            int r = manejador.actualizarImg(e);

            if (r > 0) {
                response.sendRedirect("/GYM/SvEmpleados");
            } else {
                response.sendRedirect("/GYM/index.jsp");
            }
        } else {

            response.sendRedirect("/GYM/SvEmpleados");
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