<%@page import="entities.Contrato"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Reservas</title>

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

<link rel="stylesheet" type="text/css" href="/GYM/style/reservasStyles.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />
<% Usuario user = (Usuario) session.getAttribute("user");
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
						<li class="nav-item"><a class="nav-link text-light active"
							id="links" href="/GYM/pages/reservas.jsp">Reservas</a></li>
						<li class="nav-item"><a class="nav-link text-light"
							id="links" href="#">Sobre Nosotros</a></li>
					</ul>
				</div>
				<% if (user == null){ %>
                    <div class="cajalogin">
                        <a id="textoregistro" href="pages/signUp.jsp"
                            >Registrate</a
                        >
                        <a href="/GYM/pages/logIn.jsp"><button class="boton2">Iniciar Sesiï¿½n</button></a
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

	<div class="contenedor">
		<div class="caja">
			<div class="titulo">
				<p>Salón de Musculación</p>
			</div>
			<div class="imagen">
				<img src="/GYM/img/salondemusculacion.jpg"></img>
			</div>
			
			<hr>
			<div>
			<ul>
				<li>Máquina de pesas y barras</li>
				<li>Bancos de entrenamiento ajustables</li>
				<li>Cintas de correr y elípticas</li>
				<li>Máquinas de poleas y cables</li>
				<li>Mancuernas y kettlebells variados</li>
				<li>y mucho más...</li>
			</ul>
			</div>
			
			<div class="final">
				<a href="/GYM/SvMusculacion"><button class="boton">Reservar</button> </a>
			</div>

	
		</div>
		<div class="caja">
				<div class="titulo">
					<p>Actividades</p>
				</div>
			<div class="imagen">
				<img src="/GYM/img/actividades.png"></img>
			</div>
			
			<hr>
			<div>
			<ul>
				<li>Clases de Yoga y meditación</li>
				<li>Crossfit</li>
				<li>Clases de Zumba y baile</li>
				<li>Clases de artes marciales</li>
				<li>Entrenamiento de alta intensidad en grupo</li>
				<li>y mucho más...</li>
			</ul>
			</div>
			
			<div class="final">
				<a href="/GYM/SvActividades"><button class="boton">Reservar</button> </a>
			</div>

			

		</div>
		
	</div>

	
	

</body>

</html>