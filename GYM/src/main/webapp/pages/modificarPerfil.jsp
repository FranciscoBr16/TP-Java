<%@page import="entities.Contrato"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Log In</title>

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

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.12.1/css/all.css"
	crossorigin="anonymous" />

<link rel="stylesheet" type="text/css" href="/GYM/style/modificarPerfilStyle.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/generalStyles.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/generalStyles2.css" />

<% Usuario user = (Usuario) session.getAttribute("user");
 Contrato contrato = (Contrato) request.getAttribute("contrato");
%>

</head>

<body>
	<header>
		<nav class="navbar navbar-expand-lg">
			<div class="container-fluid">
				<a class="navbar-brand" href="../index.jsp"><img
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
							id="links" aria-current="page" href="../index.jsp">Inicio</a></li>
						<li class="nav-item"><a class="nav-link text-light"
							id="links" href="/GYM/SvAbono">Planes</a></li>
						<li class="nav-item"><a class="nav-link text-light"
							id="links" href="#">Tienda</a></li>
						<li class="nav-item"><a class="nav-link text-light"
							id="links" href="#">Reservas</a></li>
						<li class="nav-item"><a class="nav-link text-light"
							id="links" href="#">Sobre Nosotros</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</header>

	<div class="contenedor">
		<div class="cajaModificar">
		<div class="titulo">
			<p>Modifica tu perfil </p>
		</div>

			<form action="/GYM/SvModificacionUsuario.java" method="POST" class="formulario-campos">
				<div class="campo">
					<label for="birthdate">Fecha de Nacimiento:</label> 
					<input class="fecha" type="date" name="birthdate" id="birthdate" value="<%=user.getFechaNac().toString()%>" />
				</div>
				<div class="campo">
					<label for="email">Correo Electrónico:</label> 
					<input type="email" name="email" id="email" value="<%=user.getEmail()%>"/>
				</div>
				<div class="campo">
					
					<label for="password">Contraseña:</label>
					<input type="password" name="password" id="password" value="<%=user.getPassword()%>"/>
				</div>
				<div class="campo">
					<label for="nombre">Nombre:</label> 
					<input type="text" name="name" id="name" value="<%=user.getNombre()%>"/> 
				</div>
				<div class="campo">
					<label for="apellido">Apellido:</label> 
					<input type="text" name="surname" id="surname" value="<%=user.getApellido()%>"/>
				</div>
				<div class="campo">
					<label for="phonenumber">Teléfono:</label> 
					<input type="text" name="phonenumber" id="phonenumber" value="<%=user.getTelefono()%>"/>
				</div>
				<div class="final">
					<button class="boton" type="submit"> Aplicar cambios </button>
				</div>
				</form>
			
		</div>

		
	</div>

</body>

</html>