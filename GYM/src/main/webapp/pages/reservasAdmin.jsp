<%@page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="entities.Clase, entities.Inscripcion, java.util.ArrayList" %>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />
        <link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

        <style>
            body { background-color: #191617; color: white; }

            .page-title {
                font-size: 26px;
                font-weight: bold;
                color: white;
                margin-bottom: 1.5rem;
            }

            .filtros-card {
                background-color: #2a2528;
                border-radius: 12px;
                padding: 1.25rem;
                margin-bottom: 2rem;
            }
            .filtros-card input {
                background-color: #191617;
                border: 1px solid #444;
                color: white;
                border-radius: 8px;
                padding: 8px 12px;
                width: 100%;
            }
            .filtros-card input::placeholder { color: #888; }
            .filtros-card input:focus { outline: 2px solid #d95126; border-color: #d95126; }

            .reservas-card {
                background-color: #2a2528;
                border-radius: 12px;
                overflow: hidden;
                margin-bottom: 1.5rem;
            }

            .reservas-table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
            }

            .reservas-table th {
                text-align: left;
                font-size: 12px;
                color: #aaa;
                padding: 10px 16px;
                border-bottom: 1px solid #444;
                font-weight: normal;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .reservas-table td {
                padding: 12px 16px;
                border-bottom: 1px solid #333;
                color: white;
            }

            .reservas-table tr:last-child td { border-bottom: none; }
            .reservas-table tbody tr:hover td { background-color: #333; }

            .badge-act {
                background-color: #0f6e5620;
                color: #5dcaa5;
                border: 1px solid #0f6e56;
                font-size: 11px;
                padding: 3px 10px;
                border-radius: 999px;
            }

            .badge-musc {
                background-color: #185fa520;
                color: #85b7eb;
                border: 1px solid #185fa5;
                font-size: 11px;
                padding: 3px 10px;
                border-radius: 999px;
            }
        </style>
    </head>

    <body>
        <header>
            <% request.setAttribute("activePage", "reservas-admin"); %>
            <jsp:include page="/pages/components/navbar.jsp" />
        </header>

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
                            <label class="form-label text-secondary" style="font-size:13px;">Fecha de Inscripci�n</label>
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
