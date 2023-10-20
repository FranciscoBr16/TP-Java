<%@page import="entities.Clase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Contrato"%>
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

<link rel="stylesheet" type="text/css" href="/GYM/style/actividades.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/generalStyles.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/generalStyles2.css" />

<% Usuario user = (Usuario) session.getAttribute("user");%>
<%  ArrayList<Clase> actividades = (ArrayList<Clase>)request.getAttribute("actividades");%>	


</head>

<body>
	<header>
		<nav class="navbar navbar-expand-lg">
			<div class="container-fluid">
				<a class="navbar-brand" href="/GYM/index.jsp"><img
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
							id="links" aria-current="page" href="/GYM/index.jsp">Inicio</a></li>
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
			</div>
		</nav>
	</header>
	
	<!--  Usar para la barra de busqueda y filtrado 
	<div>
	
	</div>
	-->

	<div class="contenedor">
	
		<%for(Clase act : actividades){ %>
		<div class="cajaAlargada">
		
			<div class="caja1">
				<img class="imagenact" src="<%=act.getImagen()%>"></img>
			</div>
		
			<div class="caja2">
				<div class="">
					<span><%=act.getNombre()%></span>
				</div>
				<div>
					<p><%=act.getDescripcion()%></p>
				</div>
				<div> <p>Profesor: <%=act.getEmpleado().getNombre()%> <%=act.getEmpleado().getApellido() %> </p> </div>
			</div>
			
			<div class="caja3">
				<div>
					<span><%=act.getDia() %></span> <span><%=act.getHorario() %></span>
				</div>
				<div>
					<p>Cupo: <%=act.getCupo()%> </p>
				</div>
				<div>
					<a href="#"><button class="boton">Reservar</button> </a>
			</div>

			<!--  En caso de que queramos modificar. Solo para admin
			<div>
				<a href=""><button class="boton">Modificar Actividad</button> </a>
			</div>
			-->

			</div>
		</div>
		  <%} %>
		
		
		
	</div>
	
	

</body>

</html>