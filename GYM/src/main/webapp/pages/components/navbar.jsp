<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="entities.Usuario" %>

<%
    Usuario user = (Usuario) session.getAttribute("user");
    String activePage = (String) request.getAttribute("activePage");
%>

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

                <li class="nav-item">
                    <a class="nav-link text-light <%= "inicio".equals(activePage) ? "active" : "" %>" id="links"
                       href="/GYM/index.jsp">
                        Inicio
                    </a>
                </li>

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

                <li class="nav-item">
                    <a class="nav-link text-light <%= "reservas".equals(activePage) ? "active" : "" %>" id="links"
                       href="/GYM/pages/reservas.jsp">
                        Reservas
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-light <%= "nosotros".equals(activePage) ? "active" : "" %>" id="links"
                       href="/GYM/SvEmpleados">
                        Sobre Nosotros
                    </a>
                </li>

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

            <jsp:include page="/pages/components/btnCarrito.jsp" />

            <div class="cajaUser">
                <a class="nombreUsuario" href="/GYM/SvUsuario">
                    <%= user.getNombre() %> <%= user.getApellido() %>
                </a>
                <img class="imglogo" src="<%= user.getImagen() %>">
            </div>

        <% } %>

    </div>
</nav>
