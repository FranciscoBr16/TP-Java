<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entities.Usuario" %>
<%@ page import="entities.Contrato" %>
<%@ page import="entities.Abono" %>
<%@ page import="java.util.ArrayList" %>

<%
    // ── Seguridad (doble chequeo en la vista) ────────────────────────────────
    Usuario adminUser = (Usuario) session.getAttribute("user");
    if (adminUser == null || !adminUser.isAdmin()) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    ArrayList<Usuario> listaUsuarios = (ArrayList<Usuario>) request.getAttribute("listaUsuarios");
    String busquedaNombre = request.getParameter("nombre") != null ? request.getParameter("nombre") : "";
    String busquedaDni    = request.getParameter("dni")    != null ? request.getParameter("dni")    : "";
    int totalUsuarios     = (listaUsuarios != null) ? listaUsuarios.size() : 0;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Gestión de Usuarios</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="/GYM/style/estilosGenerales.css"/>
    <link rel="stylesheet" href="/GYM/style/estilosGenerales2.css"/>
    <link rel="stylesheet" type="text/css" href="/GYM/style/listaUsuarios.css" />
    
    <link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

    <style>

    </style>
</head>
<body>

    <jsp:include page="/pages/components/navbar.jsp"/>

    <div class="page-wrapper">

        

        <%-- Filtros --%>
        <div class="filtros-card">
            <form method="GET" action="/GYM/SvUsuarios">
                <div class="row g-3 align-items-end">
                    <div class="col-12 col-md-4">
                        <label for="inputNombre"><i class="bi bi-search me-1"></i>Buscar por nombre</label>
                        <input type="text" id="inputNombre" name="nombre"
                               placeholder="Ej: Santiago" value="<%= busquedaNombre %>"/>
                    </div>
                    <div class="col-12 col-md-4">
                        <label for="inputDni"><i class="bi bi-card-text me-1"></i>Buscar por DNI</label>
                        <input type="text" id="inputDni" name="dni"
                               placeholder="Ej: 42424242" value="<%= busquedaDni %>"/>
                    </div>
                    <div class="col-12 col-md-4 d-flex gap-2 align-items-center">
                        <button type="submit" class="btn-filtrar">
                            <i class="bi bi-funnel-fill me-1"></i>Filtrar
                        </button>
                        <a href="/GYM/SvUsuarios" class="btn-limpiar">
                            <i class="bi bi-x-circle me-1"></i>Limpiar
                        </a>
                    </div>
                </div>
            </form>
        </div>

        <p class="contador-resultados">
            Mostrando <span><%= totalUsuarios %></span>
            usuario<%= totalUsuarios != 1 ? "s" : "" %>
            <% if (!busquedaNombre.isEmpty() || !busquedaDni.isEmpty()) { %>
                para la búsqueda actual
            <% } %>
        </p>

        <div class="tabla-wrapper">
            <% if (listaUsuarios == null || listaUsuarios.isEmpty()) { %>
                <div class="sin-resultados">
                    <i class="bi bi-person-x"></i>
                    <p style="font-size:18px; color:#555;">No se encontraron usuarios</p>
                    <% if (!busquedaNombre.isEmpty() || !busquedaDni.isEmpty()) { %>
                        <p style="font-size:14px; color:#444;">Probá con otros términos de búsqueda</p>
                    <% } %>
                </div>
            <% } else { %>
                <table class="tabla-usuarios">
                    <thead>
                        <tr>
                            <th></th>
                            <th>DNI</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Correo</th>
                            <th>Teléfono</th>
                            <th>Rol</th>
                            <th>Abono activo</th>
                            <th>Clases restantes</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Usuario u : listaUsuarios) {

                                Contrato contratoActivo = u.getContratos().isEmpty()
                                    ? null : u.getContratos().get(0);

                                boolean tieneAbono    = (contratoActivo != null
                                                         && contratoActivo.getAbono() != null);
                                String  nombreAbono   = tieneAbono
                                                         ? contratoActivo.getAbono().getNombreAbono() : "";
                                int clasesRestantes   = tieneAbono
                                                         ? contratoActivo.getReservasRestantes() : 0;
                        %>
                        <tr>
                            <%-- Avatar --%>
                            <td>
                                <% if (u.getImagen() != null && !u.getImagen().isEmpty()) { %>
                                    <img src="<%= u.getImagen() %>"
                                         alt="<%= u.getNombre() %>"
                                         class="avatar-usuario"/>
                                <% } else { %>
                                    <div class="avatar-iniciales">
                                        <%= u.getNombre().charAt(0) %><%= u.getApellido().charAt(0) %>
                                    </div>
                                <% } %>
                            </td>

                            <td style="font-family:monospace; color:#bbb;"><%= u.getDni() %></td>
                            <td><%= u.getNombre() %></td>
                            <td><%= u.getApellido() %></td>

                            <td style="color:#aaa; font-size:14px;">
                                <i class="bi bi-envelope me-1" style="color:#d95126;"></i>
                                <%= u.getEmail() %>
                            </td>

                            <td style="color:#aaa;">
                                <i class="bi bi-telephone me-1" style="color:#d95126;"></i>
                                <%= u.getTelefono() %>
                            </td>

                            <%-- Rol --%>
                            <td>
                                <% if (u.isAdmin()) { %>
                                    <span class="badge-admin-tag">
                                        <i class="bi bi-person-fill-gear me-1"></i>Admin
                                    </span>
                                <% } else { %>
                                    <span class="badge-cliente">
                                        <i class="bi bi-person me-1"></i>Cliente
                                    </span>
                                <% } %>
                            </td>

                            <%-- Abono --%>
                            <td>
                                <% if (tieneAbono) { %>
                                    <span class="badge-activo">
                                        <i class="bi bi-check-circle me-1"></i><%= nombreAbono %>
                                    </span>
                                <% } else { %>
                                    <span class="badge-sin-abono">
                                        <i class="bi bi-dash-circle me-1"></i>Sin abono
                                    </span>
                                <% } %>
                            </td>

                            <%-- Clases restantes --%>
                            <td>
                                <% if (tieneAbono) { %>
                                    <span class="badge-clases">
                                        <i class="bi bi-calendar-check me-1"></i><%= clasesRestantes %>
                                    </span>
                                <% } else { %>
                                    <span style="color:#555;">—</span>
                                <% } %>
                            </td>

                            <%-- Editar --%>
                            <td>
                                <a href="/GYM/SvEditarUsuario?dni=<%= u.getDni() %>"
                                   class="btn-editar" title="Editar usuario">
                                    <i class="bi bi-pencil-fill"></i>
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
