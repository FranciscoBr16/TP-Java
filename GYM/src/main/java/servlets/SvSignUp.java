package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbHandler;
import entities.Usuario;

/**
 * Servlet implementation class SvSignUp
 */
@WebServlet("/SvSignUp")
public class SvSignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvSignUp() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		Usuario usu = new Usuario((String)request.getParameter("username"),(String)request.getParameter("name"),(String)request.getParameter("surname"),(String)request.getParameter("password"),(String)request.getParameter("email"),(String) request.getParameter("phonenumber"));
		DbHandler db = new DbHandler();		
		if(db.newUser(usu)){
			response.sendRedirect("/GYM/pages/signUpExitoso.jsp");
		} else {
			response.sendRedirect("index.jsp");
		}
	}

}
