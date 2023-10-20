package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SvCerrarSesion")
public class SvCerrarSesion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SvCerrarSesion() {
        super();
 
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().setAttribute("user",null);
		response.sendRedirect("/GYM/index.jsp");
		
	}

}
