<%@page import="entities.Clase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Actividades</title>

<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@347&display=swap" rel="stylesheet" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" href="/GYM/style/estilosGenerales2.css" />
<link rel="stylesheet" href="/GYM/style/musculacion.css" />

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<%
    Usuario user = (Usuario) session.getAttribute("user");
    ArrayList<Clase> clases = (ArrayList<Clase>) request.getAttribute("clases");
%>
</head>

<body>

<header>
    <%
        request.setAttribute("activePage", "reservas");
    %>
    <jsp:include page="/pages/components/navbar.jsp" />
</header>

<%
    ArrayList<Clase> lunes = new ArrayList<>();
    ArrayList<Clase> martes = new ArrayList<>();
    ArrayList<Clase> miercoles = new ArrayList<>();
    ArrayList<Clase> jueves = new ArrayList<>();
    ArrayList<Clase> viernes = new ArrayList<>();

    for (Clase c : clases) {
        switch (c.getDia()) {
            case "Lunes": lunes.add(c); break;
            case "Martes": martes.add(c); break;
            case "Miercoles": miercoles.add(c); break;
            case "Jueves": jueves.add(c); break;
            case "Viernes": viernes.add(c); break;
        }
    }
%>

<div class="agenda-container">

	<%
    String mensaje = (String) session.getAttribute("mensaje");
    String tipoMensaje = (String) session.getAttribute("tipoMensaje");

	    if (mensaje != null) {
	%>
	    <div class="alert alert-<%= tipoMensaje %> text-center">
	        <%= mensaje %>
	    </div>
	<%
	        session.removeAttribute("mensaje");
	        session.removeAttribute("tipoMensaje");
	    }
	%>
	
    <!-- LUNES -->
    <div class="dia-card">
        <h2 class="dia-titulo">Lunes</h2>
        <div class="dia-contenido">
            <% for (Clase c : lunes) { %>
                <div class="clase-item">
                    <div class="clase-horario"><%= c.getHorario() %></div>
                    <div class="clase-info">
                        <span class="clase-cupo">Cupo: <%= c.getCupo() %></span>

                        <% if (user != null) { %>
                            <form action="/GYM/SvInscripcion" method="post">
                                <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                <button class="btn boton2">Reservar</button>
                            </form>

                            <% if (user.isAdmin()) { %>
                                <div class="clase-admin">
                                    <form action="/GYM/SvModificarSalon" method="get">
                                        <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                        <button class="btn btn-warning btn-sm">Modificar</button>
                                    </form>
                                    <form action="/GYM/SvBajaClase" method="post">
                                        <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                        <button class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            <% } %>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <!-- MARTES -->
    <div class="dia-card">
        <h2 class="dia-titulo">Martes</h2>
        <div class="dia-contenido">
            <% for (Clase c : martes) { %>
                <div class="clase-item">
                    <div class="clase-horario"><%= c.getHorario() %></div>
                    <div class="clase-info">
                        <span class="clase-cupo">Cupo: <%= c.getCupo() %></span>

                        <% if (user != null) { %>
                            <form action="/GYM/SvInscripcion" method="post">
                                <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                <button class="btn boton2">Reservar</button>
                            </form>

                            <% if (user.isAdmin()) { %>
                                <div class="clase-admin">
                                    <form action="/GYM/SvModificarSalon" method="get">
                                        <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                        <button class="btn btn-warning btn-sm">Modificar</button>
                                    </form>
                                    <form action="/GYM/SvBajaClase" method="post">
                                        <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                        <button class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            <% } %>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
    
    <div class="dia-card">
        <h2 class="dia-titulo">Miercoles</h2>
        <div class="dia-contenido">
            <% for (Clase c : miercoles) { %>
                <div class="clase-item">
                    <div class="clase-horario"><%= c.getHorario() %></div>
                    <div class="clase-info">
                        <span class="clase-cupo">Cupo: <%= c.getCupo() %></span>

                        <% if (user != null) { %>
                            <form action="/GYM/SvInscripcion" method="post">
                                <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                <button class="btn boton2">Reservar</button>
                            </form>

                            <% if (user.isAdmin()) { %>
                                <div class="clase-admin">
                                    <form action="/GYM/SvModificarSalon" method="get">
                                        <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                        <button class="btn btn-warning btn-sm">Modificar</button>
                                    </form>
                                    <form action="/GYM/SvBajaClase" method="post">
                                        <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                        <button class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            <% } %>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
    
    <div class="dia-card">
        <h2 class="dia-titulo">Jueves</h2>
        <div class="dia-contenido">
            <% for (Clase c : jueves) { %>
                <div class="clase-item">
                    <div class="clase-horario"><%= c.getHorario() %></div>
                    <div class="clase-info">
                        <span class="clase-cupo">Cupo: <%= c.getCupo() %></span>

                        <% if (user != null) { %>
                            <form action="/GYM/SvInscripcion" method="post">
                                <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                <button class="btn boton2">Reservar</button>
                            </form>

                            <% if (user.isAdmin()) { %>
                                <div class="clase-admin">
                                    <form action="/GYM/SvModificarSalon" method="get">
                                        <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                        <button class="btn btn-warning btn-sm">Modificar</button>
                                    </form>
                                    <form action="/GYM/SvBajaClase" method="post">
                                        <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                        <button class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            <% } %>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
    
    <div class="dia-card">
        <h2 class="dia-titulo">Viernes</h2>
        <div class="dia-contenido">
            <% for (Clase c : viernes) { %>
                <div class="clase-item">
                    <div class="clase-horario"><%= c.getHorario() %></div>
                    <div class="clase-info">
                        <span class="clase-cupo">Cupo: <%= c.getCupo() %></span>

                        <% if (user != null) { %>
                            <form action="/GYM/SvInscripcion" method="post">
                                <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                <button class="btn boton2">Reservar</button>
                            </form>

                            <% if (user.isAdmin()) { %>
                                <div class="clase-admin">
                                    <form action="/GYM/SvModificarSalon" method="get">
                                        <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                        <button class="btn btn-warning btn-sm">Modificar</button>
                                    </form>
                                    <form action="/GYM/SvBajaClase" method="post">
                                        <input type="hidden" name="id" value="<%= c.getIdClase() %>">
                                        <button class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            <% } %>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>
    </div>


    <% if (user != null && user.isAdmin()) { %>
        <div class="admin-acciones">
            <a href="/GYM/pages/altaSalon.jsp" class="btn btn-primary">
                Nueva Clase
            </a>
        </div>
    <% } %>

</div>

<jsp:include page="/pages/components/carrito.jsp" />

</body>
</html>
