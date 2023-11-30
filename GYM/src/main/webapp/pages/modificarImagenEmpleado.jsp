<%@page import="entities.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Modificar Empleado</title>

<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@347&display=swap"
	rel="stylesheet" />

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous">
  </script>


<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/modificacionEstilos.css" />


<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% Usuario user = (Usuario) session.getAttribute("user");%>

</head>

<header>
	<nav class="navbar navbar-expand-lg">
		<div class="container-fluid">
			<a class="navbar-brand" href="index.jsp"><img
				src="/GYM/img/logo.png" alt="logo del gimnasio" /></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link text-light"
						id="links" aria-current="page" href="index.jsp">Inicio</a></li>
					<li class="nav-item"><a class="nav-link text-light" id="links"
						href="/GYM/SvAbono">Planes</a></li>
					<li class="nav-item"><a class="nav-link text-light" id="links"
						href="#">Tienda</a></li>
					<li class="nav-item"><a class="nav-link text-light" id="links"
						href="/GYM/pages/reservas.jsp">Reservas</a></li>
					<li class="nav-item"><a class="nav-link text-light" id="links"
						href="#">Sobre Nosotros</a></li>
				</ul>
			</div>

			 <% if (user == null){ %>
                    <div class="cajalogin">
                        <a id="textoregistro" href="pages/signUp.jsp">Registrate</a>
                        <a href="/GYM/pages/logIn.jsp"><button class="boton2">Iniciar Sesión</button></a>
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

<body>

	<div class="contenedor">
		<div class="cajaModificar">
		<div class="headerForm">
			<p class="titulo">Modifica al <span class="anaranjado">Empleado</span></p>
		</div>
		<hr>
			<form action="/GYM/SvCambiarImagenEmpleado" method="POST" enctype="multipart/form-data">
				<div class="campoCentrado">
					<label for="imagen">Selecciona una imagen:</label>
  				 	<input type="file" name="imagen">
    			</div>
				<div class="bottomForm">
					<button class="boton" type="submit">Cambiar Imágen</button>
				</div>

			</form>
		</div>

	</div>

</body>