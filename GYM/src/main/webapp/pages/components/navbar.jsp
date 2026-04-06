<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="entities.Usuario" %>

<%
    Usuario user = (Usuario) session.getAttribute("user");
    String activePage = (String) request.getAttribute("activePage");
    boolean esAdmin = (user != null && user.isAdmin());
%>

<link
    rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
/>
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">


    
        <a class="navbar-brand" href="/GYM/index.jsp">
            <img src="/GYM/img/logo.png" alt="logo del gimnasio" />
        </a>        


        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">

                <%-- Inicio: solo para clientes --%>
                    <% if (!esAdmin) { %>
                        <li class="nav-item">
                            <a class="nav-link text-light <%= "inicio".equals(activePage) ? "active" : "" %>" id="links"
                            href="/GYM/index.jsp">
                                Inicio
                            </a>
                        </li>
                    <% } %>

                <% if (esAdmin) { %>

                    <%-- NAVBAR ADMIN --%>

                    <li class="nav-item">
                        <a class="nav-link text-light <%= "usuarios".equals(activePage) ? "active" : "" %>" id="links"
                           href="/GYM/SvUsuarios">
                            Usuarios
                        </a>
                    </li>

                    <%-- TODO: crear SvReservasAdmin (listado de reservas por día, musculación + actividades) --%>
                    <li class="nav-item">
                        <a class="nav-link text-light <%= "reservas-admin".equals(activePage) ? "active" : "" %>" id="links"
                           href="/GYM/SvReservasAdmin">
                            Reservas
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-light <%= "reservas".equals(activePage) ? "active" : "" %>" id="links"
                           href="/GYM/SvActividades">
                            Actividades
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-light <%= "salon".equals(activePage) ? "active" : "" %>" id="links"
                           href="/GYM/SvMusculacion">
                            Musculación
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-light <%= "tienda".equals(activePage) ? "active" : "" %>" id="links"
                           href="/GYM/SvProductos">
                            Productos
                        </a>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link text-light <%= "nosotros".equals(activePage) ? "active" : "" %>" id="links"
                           href="/GYM/SvEmpleados">
                            Empleados
                        </a>
                    </li>
                    

                <% } else { %>

                    <%-- NAVBAR CLIENTE (logueado o no) --%>
                    <li class="nav-item">
                        <a class="nav-link text-light <%= "planes".equals(activePage) ? "active" : "" %>" id="links"
                           href="/GYM/SvAbono">
                            Planes
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-light <%= "tienda".equals(activePage) ? "active" : "" %>" id="links"
                           href="/GYM/SvProductos">
                            Tienda
                        </a>
                    </li>

                    <% if (user != null) { %>
                        <%-- Reservas solo si está logueado --%>
                        <li class="nav-item">
						    <a class="nav-link text-light <%= ("reservas".equals(activePage) || "salon".equals(activePage)) ? "active" : "" %>" id="links"
						       href="/GYM/pages/reservas.jsp">
						        Reservas
						    </a>
						</li>
                    <% } %>

                    <li class="nav-item">
                        <a class="nav-link text-light <%= "nosotros".equals(activePage) ? "active" : "" %>" id="links"
                           href="/GYM/SvEmpleados">
                            Sobre Nosotros
                        </a>
                    </li>

                <% } %>

            </ul>
        </div>

        <% if (user == null) { %>
            <div class="cajalogin">
                <a id="textoregistro" href="/GYM/pages/signUp.jsp">Registrate</a>
                <a href="/GYM/pages/logIn.jsp">
                    <button class="boton2">Iniciar Sesión</button>
                </a>
            </div>
        <% } else { %>

            <% if (!esAdmin) { %>
                <%-- Carrito solo para clientes --%>
                <jsp:include page="/pages/components/btnCarrito.jsp" />
            <% } %>

            <div class="cajaUser">
                <% if (esAdmin) { %>
                    <span class="badge-admin"><i class="bi bi-person-fill-gear"></i>Admin</span>
                <% } %>
                <a class="nombreUsuario" href="/GYM/SvUsuario">
                    <%= user.getNombre() %> <%= user.getApellido() %>
                </a>
                <img class="imglogo" src="<%= user.getImagen() %>">
            </div>

        <% } %>

    </div>
</nav>