<%@page import="entities.Empleado"%>
<%@page import="entities.Abono"%>
<%@page import="entities.Contrato"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">

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


<link rel="stylesheet" type="text/css" href="/GYM/style/formularioEstilos.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% Usuario user = (Usuario) session.getAttribute("user");
 Empleado emp = (Empleado) request.getAttribute("empleado");
 session.setAttribute("idempleado", emp.getIdEmpleado());
 
%>

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
                            <li class="nav-item">
                                <a class="nav-link text-light" id="links" aria-current="page" href="/GYM/index.jsp">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-light" id="links" href="/GYM/SvAbono">Planes</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-light" id="links" href="/GYM/SvProductos" >Tienda</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-light" id="links" href="/GYM/pages/reservas.jsp" >Reservas</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-light active" id="links" href="/GYM/SvEmpleados" >Sobre Nosotros</a>
                            </li>
                        </ul>
				</div>
				<% if (user == null){ %>
                    <div class="cajalogin">
                        <a id="textoregistro" href="pages/signUp.jsp"
                            >Registrate</a
                        >
                        <a href="/GYM/pages/logIn.jsp"><button class="boton2">Iniciar Sesión</button></a
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
		<div class="formulario">
		<div class="headerForm">
			<p class="titulo">Modifica al <span class="anaranjado"> Empleado </span></p>
		</div>
		<hr>
		
				<div class="campoCentrado">
					<img class="imgMuestra" src="<%=emp.getImagen()%>">
					<a href="/GYM/pages/modificarImagenEmpleado.jsp"><button class="boton4">Cambiar Imágen</button></a>		
				</div>

			<form action="/GYM/SvModificarEmpleado" method="POST" class="formulario-campos">
				<div class="campo">
					<label for="id">Id Empleado:</label> 
					<input class="inputMediano" type="number" name="idEmpleado" id="idEmpleado" value="<%=emp.getIdEmpleado()%>" readonly/>
				</div>
				
				<div class="campo">
					<label for="nombre">Nombre Empleado:</label> 
					<input  type="text" name="nombre" id="nombre" value="<%=emp.getNombre()%>" />
				</div>
				<div class="campo">
					<label for="apellido">Apellido Empleado:</label> 
					<input  type="text" name="apellido" id="apellido" value="<%=emp.getApellido()%>" />
				</div>
				<div class="campo">
					<label for="email">Mail Empleado:</label> 
					<input type="text" name="email" id="email" value="<%=emp.getCorreo()%>" />
				</div>
				<div class="campo">
					<label for="fechaDesde">Fecha de ingreso:</label> 
					<input type="date" name="fechaDesde" id="fechaDesde" value="<%=emp.getFechaDesde()%>"/>
				</div>
				<div class="campo">
					<label for="rol">Rol:</label> 
					<input class="inputMediano" type="text" name="rol" id="rol" value="<%=emp.getRol()%>"/> 
				</div>
				
				<div class="bottomForm">
					<button class="boton" type="submit"> Aplicar cambios </button>
				</div>
				</form>
			
		</div>

		
	</div>

</body>

</html>