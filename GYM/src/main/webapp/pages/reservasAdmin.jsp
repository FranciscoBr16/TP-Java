<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="entities.Clase, entities.Usuario,  entities.Inscripcion, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Reservas Admin</title>

        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@347&display=swap"
            rel="stylesheet"
        />

        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
            crossorigin="anonymous"
        />
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
            crossorigin="anonymous"
        ></script>

        <link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
        <link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />
        <link rel="stylesheet" href="/GYM/style/reservasAdmin.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />
        <link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

    </head>

    <body>
        <header>
            <% request.setAttribute("activePage", "reservas-admin"); %>
            <jsp:include page="/pages/components/navbar.jsp" />
        </header>
        
        <%
		    Usuario user = (Usuario) session.getAttribute("user");
		    
		    // Validar que el usuario esté logueado
		    if (user == null) {
		        response.sendRedirect("/GYM/pages/logIn.jsp");
		        return;
		    }
		    
		    // Validar que sea administrador
		    if (!user.isAdmin()) {
		        response.sendRedirect("/GYM/index.jsp"); // o la página que quieras
		        return;
		    }
		%>

        <div class="container py-4">

            <p class="page-title">Panel de Reservas</p>

            <%-- Filtros --%>
            <div class="filtros-card">
                <form method="get" action="/GYM/SvReservasAdmin">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-4">
                            <label class="form-label text-secondary" style="font-size:13px;">DNI</label>
                            <input type="text" name="dni" placeholder="Buscar por DNI..." />
                        </div>
                        <div class="col-md-4">
                            <label class="form-label text-secondary" style="font-size:13px;">Nombre</label>
                            <input type="text" name="nombre" placeholder="Buscar por nombre..." />
                        </div>
                        <div class="col-md-4">
                            <label class="form-label text-secondary" style="font-size:13px;">Fecha de Inscripción</label>
                            <input type="date" name="fecha" />
                        </div>
                        <div class="col-12 d-flex gap-2 mt-2">
                            <button type="submit" class="boton2">Buscar</button>
                            <a href="/GYM/SvReservasAdmin"><button type="button" class="boton4">Limpiar</button></a>
                        </div>
                    </div>
                </form>
            </div>

            <%-- Tabla de reservas --%>
            <div class="reservas-card">
                <table class="reservas-table">
                    <thead>
                        <tr>
                            <th>DNI</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Fecha</th>
                            <th>Clase</th>
                            <th>Día</th>
                            <th>Horario</th>
                            <th>Tipo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        ArrayList<Inscripcion> reservas = (ArrayList<Inscripcion>) request.getAttribute("reservas");
                        for (Inscripcion reserva : reservas) {
                            String tipo = reserva.getClase().getTipo();
                        %>
                            <tr>
                                <td><%= reserva.getUsuario().getDni() %></td>
                                <td><%= reserva.getUsuario().getNombre() %></td>
                                <td><%= reserva.getUsuario().getApellido() %></td>
                                <td><%= reserva.getFechaInscripcion() %></td>
                                <td><%= reserva.getClase().getNombre() %></td>
                                <td><%= reserva.getClase().getDia() %></td>
                                <td><%= reserva.getClase().getHorario() %></td>
                                <td>
                                    <% if ("actividad".equals(tipo)) { %>
                                        <span class="badge-act">Actividad</span>
                                    <% } else { %>
                                        <span class="badge-musc">Musculación</span>
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>
