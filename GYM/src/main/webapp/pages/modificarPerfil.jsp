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


<link rel="stylesheet" type="text/css" href="/GYM/style/formularioEstilos.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% Usuario user = (Usuario) session.getAttribute("user");%>

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
                                <a class="nav-link text-light" id="links" href="/GYM/SvEmpleados" >Sobre Nosotros</a>
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
			<p class="titulo" >Modifica tu <span class="anaranjado"> perfil </span> </p>
		</div>
		
		<hr>

			<form action="/GYM/SvModificacionUsuario" method="POST" class="formulario-campos">
				<div class="campo">
					<label for="birthdate">Fecha de Nacimiento:</label> 
					<input class="inputFecha" type="date" name="birthdate" id="birthdate" value="<%=user.getFechaNac().toString()%>" />
				</div>
				<div class="campo">
					<label for="email">Correo Electrónico:</label> 
					<input class="inputLargo" type="email" name="email" id="email" value="<%=user.getEmail()%>"/>
				</div>
				<div class="campo">
					
					<label for="password">Contraseña:</label>
					<input class="inputMediano" type="password" name="password" id="password" value="<%=user.getPassword()%>"/>
				</div>
				<div class="campo">
					<label for="nombre">Nombre:</label> 
					<input class="inputMediano" type="text" name="name" id="name" value="<%=user.getNombre()%>"/> 
				</div>
				<div class="campo">
					<label for="apellido">Apellido:</label> 
					<input class="inputMediano" type="text" name="surname" id="surname" value="<%=user.getApellido()%>"/>
				</div>
				<div class="campo">
					<label for="phonenumber">Teléfono:</label> 
					<input class="inputMediano" type="text" name="phonenumber" id="phonenumber" value="<%=user.getTelefono()%>"/>
				</div>
				<div class="campo">
				<label>Imágen de perfil:</label>
        			<div class="opcionesimg">
        				<div class="opcion">
        					<label for="imagen1"><img class="opcionimg" src="/GYM/img/perfil/imgperfil1.jpg" alt="Imagen Fitness"></label>
				            <input type="radio" name="imagenesPerfil" value="imgperfil1.jpg" <% if (user.getImagen().equals("/GYM/img/perfil/imgperfil1.jpg")){%>checked <%} %> required>
				            
						</div>
						<div class="opcion">
							<label for="imagen2"><img class="opcionimg" src="/GYM/img/perfil/imgperfil2.jpg" alt="Imagen Mujer"></label>
				            <input type="radio" name="imagenesPerfil" value="imgperfil2.jpg" <% if (user.getImagen().equals("/GYM/img/perfil/imgperfil2.jpg")){%>checked <%} %> required>
				            
						</div>
						<div class="opcion">
							<label for="imagen3"><img class="opcionimg" src="/GYM/img/perfil/imgperfil3.jpg" alt="Imagen Bebida"></label>
				            <input type="radio" name="imagenesPerfil" value="imgperfil3.jpg" <% if (user.getImagen().equals("/GYM/img/perfil/imgperfil3.jpg")){%>checked <%} %> required>
				            
						</div>
						<div class="opcion">
							<label for="imagen4"><img class="opcionimg" src="/GYM/img/perfil/imgperfil4.jpg" alt="Imagen Hombre"></label>
				            <input type="radio" name="imagenesPerfil" value="imgperfil4.jpg" <% if (user.getImagen().equals("/GYM/img/perfil/imgperfil4.jpg")){%>checked <%} %> required>
				            
						</div>
						<div class="opcion">
							<label for="imagen5"><img class="opcionimg" src="/GYM/img/perfil/imgperfil5.jpg" alt="Imagen Puño"></label>
				            <input type="radio"  name="imagenesPerfil" value="imgperfil5.jpg" <% if (user.getImagen().equals("/GYM/img/perfil/imgperfil5.jpg")){%>checked <%} %> required>
				            
				        </div>
						
				     </div>
				  </div>
				
				<div class="bottomForm">
					<button class="boton" type="submit"> Aplicar cambios </button>
				</div>
				</form>
			
		</div>

		
	</div>

</body>

</html>