package servlets;

import java.io.IOException;
import java.time.LocalDate;
import java.time.Period;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.DbUsuario;
import entities.Usuario;

@WebServlet("/SvSignUp")
public class SvSignUp extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirige al formulario de registro directamente para mantener URL limpia
        response.sendRedirect(request.getContextPath() + "/pages/signUp.jsp");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Obtener parámetros
        String dni = request.getParameter("dni");
        String nombre = request.getParameter("name");
        String apellido = request.getParameter("surname");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String telefono = request.getParameter("phonenumber");
        String fechaStr = request.getParameter("fecha");
        String imagen = request.getParameter("imagenesPerfil");
        
        // 1. Validar campos vacíos
        if (dni == null || dni.trim().isEmpty() ||
            nombre == null || nombre.trim().isEmpty() ||
            apellido == null || apellido.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            telefono == null || telefono.trim().isEmpty() ||
            fechaStr == null || fechaStr.trim().isEmpty()) {
            
            session.setAttribute("mensajeError", "Todos los campos son obligatorios");
            response.sendRedirect(request.getContextPath() + "/pages/signUp.jsp");
            return;
        }
        
        // 2. Validar formato DNI
        if (!dni.matches("^[0-9]{7,8}$")) {
            session.setAttribute("mensajeError", "El DNI debe contener entre 7 y 8 dígitos numéricos");
            response.sendRedirect(request.getContextPath() + "/pages/signUp.jsp");
            return;
        }
        
        // 3. Validar formato email
        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
            session.setAttribute("mensajeError", "El formato del email no es válido");
            response.sendRedirect(request.getContextPath() + "/pages/signUp.jsp");
            return;
        }
        
        // 4. Validar longitud de contraseña
        if (password.length() < 6) {
            session.setAttribute("mensajeError", "La contraseña debe tener al menos 6 caracteres");
            response.sendRedirect(request.getContextPath() + "/pages/signUp.jsp");
            return;
        }
        
        // 5. Validar fecha y edad mínima (16 años)
        LocalDate fecha;
        try {
            fecha = LocalDate.parse(fechaStr);
            int edad = Period.between(fecha, LocalDate.now()).getYears();
            if (edad < 16) {
                session.setAttribute("mensajeError", "Debes tener al menos 16 años para registrarte");
                response.sendRedirect(request.getContextPath() + "/pages/signUp.jsp");
                return;
            }
        } catch (Exception e) {
            session.setAttribute("mensajeError", "El formato de la fecha no es válido");
            response.sendRedirect(request.getContextPath() + "/pages/signUp.jsp");
            return;
        }
        
        DbUsuario db = new DbUsuario();
        
        // 6. Validar DNI duplicado
        if (db.existeDni(dni)) {
            session.setAttribute("mensajeError", "El DNI ya está registrado en el sistema");
            response.sendRedirect(request.getContextPath() + "/pages/signUp.jsp");
            return;
        }
        
        // 7. Validar email duplicado
        if (db.existeEmail(email)) {
            session.setAttribute("mensajeError", "El correo electrónico ya está registrado");
            response.sendRedirect(request.getContextPath() + "/pages/signUp.jsp");
            return;
        }
        
        // Registro del usuario
        Usuario usu = new Usuario(dni, nombre, apellido, password, email, telefono, fecha, imagen);
        
        if (db.newUser(usu)) {
            response.sendRedirect(request.getContextPath() + "/pages/signUpExitoso.jsp");
        } else {
            session.setAttribute("mensajeError", "Error técnico al registrar. Intente nuevamente");
            response.sendRedirect(request.getContextPath() + "/pages/signUp.jsp");
        }
    }
}