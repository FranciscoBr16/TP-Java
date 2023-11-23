<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%> <%@ page import="entities.Usuario"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Inicio</title>

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

        <link rel="shortcut icon" href="img/logo.ico" type="image/x-icon" />
        <link
            rel="stylesheet"
            href="https://use.fontawesome.com/releases/v5.12.1/css/all.css"
            crossorigin="anonymous"
        />

        <link rel="stylesheet" href="/GYM/style/indexEstilos.css" />
        <link rel="stylesheet" href="/GYM/style/estilosGenerales.css" />

        <% Usuario user = (Usuario) session.getAttribute("user");%>
    </head>

    <body>
        <header>
            <nav class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <a class="navbar-brand" href="/GYM/index.jsp"
                        ><img src="img/logo.png" alt="logo del gimnasio"
                    /></a>
                    <button
                        class="navbar-toggler"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#navbarNav"
                        aria-controls="navbarNav"
                        aria-expanded="false"
                        aria-label="Toggle navigation"
                    >
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a
                                    class="nav-link text-light active"
                                    id="links"
                                    aria-current="page"
                                    href="/GYM/index.jsp"
                                    >Inicio</a
                                >
                            </li>
                            <li class="nav-item">
                                <a
                                    class="nav-link text-light"
                                    id="links"
                                    href="/GYM/SvAbono"
                                    >Planes</a
                                >
                            </li>
                            <li class="nav-item">
                                <a
                                    class="nav-link text-light"
                                    id="links"
                                    href="#"
                                    >Tienda</a
                                >
                            </li>
                            <li class="nav-item">
                                <a
                                    class="nav-link text-light"
                                    id="links"
                                    href="/GYM/pages/reservas.jsp"
                                    >Reservas</a
                                >
                            </li>
                            <li class="nav-item">
                                <a
                                    class="nav-link text-light"
                                    id="links"
                                    href="/GYM/pages/sobreNosotros.jsp"
                                    >Sobre Nosotros</a
                                >
                            </li>
                        </ul>
                    </div>
                    <% if (user == null){ %>
                    <div class="cajalogin">
                        <a id="textoregistro" href="pages/signUp.jsp"
                            >Registrate</a
                        >
                        <a href="/GYM/pages/logIn.jsp"><button class="boton2">Iniciar Sesi�n</button></a
                        >
                    </div>
                    <% } else {%>
                    <div class="cajaUser">
                        <a class="nombreUsuario" href="/GYM/SvUsuario"><%= user.getNombre() %> <%= user.getApellido()%></a>
                        <img class ="imglogo" src="<%=user.getImagen()%>"></img>
                    </div>
                    <%} %>
                </div>
            </nav>
        </header>
        <div class="caja">
            <a class="caja1" href="#">
                <p>ENTRENA</p>
            </a>
            <a class="caja2" href="#">
                <p>COMPRA</p>
            </a>
            <a class="caja3" href="#">
                <p>CONOCENOS</p>
            </a>
        </div>
        
        <!--   <div class="papu"><p class="papu">Hola soy un footer</p></div> -->
    </body>
</html>
