<%@page import="entities.Clase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Empleado"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Modificar Salon</title>

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
<link rel="stylesheet" type="text/css" href="/GYM/style/actAltaEstilos.css" />


<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% Usuario user = (Usuario) session.getAttribute("user");%>
<% Clase cla = (Clase) request.getAttribute("clase");%>



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
                            <li class="nav-item">
                                <a class="nav-link text-light active" id="links" aria-current="page" href="/GYM/index.jsp">Inicio</a>
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
		<div class="formulario">
			<div class="headerForm">
				<p class= "titulo">Modificar <span class="anaranjado">Salon </span></p>
			</div>
			<form action="/GYM/SvModificarSalon" method="POST" class="formulario-campos" >
				
				<div class="campo">
					<label>Id del salon:</label> 
					<input value="<%=cla.getIdClase() %>" type="number" name="id" readonly/> 
				</div>
				
				<div class="campo">
					<label>Nombre de la Clase:</label> 
					<input value="<%=cla.getNombre() %>" type="text" name="nombre" required/> 
				</div>
					
				<div class="campo">
					<label>Cupo:</label>
					<input value="<%=cla.getCupo() %>" class="cupo" type="number" name="cupo" required />
				</div>
				
				<div class="campo">
					<label for="opciones">Día:</label>
					<select name="dia" id="opciones">
        				<option <%if(cla.getDia().equals("Lunes")){ %> selected<% }%>value="Lunes">Lunes</option>
        				<option <%if(cla.getDia().equals("Martes")){ %> selected<% }%> value="Martes">Martes</option>
        				<option <%if(cla.getDia().equals("Miercoles")){ %> selected<% }%> value="Miercoles">Miercoles</option>
        				<option <%if(cla.getDia().equals("Jueves")){ %> selected<% }%> value="Jueves">Jueves</option>
        				<option <%if(cla.getDia().equals("Viernes")){ %> selected<% }%> value="Viernes">Viernes</option>
    				
    				</select>
					<label for="opciones">Horario:</label>
					<select name="horario" id="opciones">
        				<option <%if(cla.getHorario().equals("8:00")){ %> selected<% }%> value="8:00">8:00</option>
        				<option <%if(cla.getHorario().equals("9:00")){ %> selected<% }%> value="9:00">9:00</option>
        				<option <%if(cla.getHorario().equals("10:00")){ %> selected<% }%> value="10:00">10:00</option>
        				<option <%if(cla.getHorario().equals("11:00")){ %> selected<% }%> value="11:00">11:00</option>
        				<option <%if(cla.getHorario().equals("12:00")){ %> selected<% }%> value="12:00">12:00</option>
        				<option <%if(cla.getHorario().equals("13:00")){ %> selected<% }%> value="13:00">13:00</option>
        				<option <%if(cla.getHorario().equals("14:00")){ %> selected<% }%> value="14:00">14:00</option>
        				<option <%if(cla.getHorario().equals("15:00")){ %> selected<% }%> value="15:00">15:00</option>
        				<option <%if(cla.getHorario().equals("16:00")){ %> selected<% }%> value="16:00">16:00</option>
        				<option <%if(cla.getHorario().equals("17:00")){ %> selected<% }%> value="17:00">17:00</option>
        				<option <%if(cla.getHorario().equals("18:00")){ %> selected<% }%> value="18:00">18:00</option>
        				<option <%if(cla.getHorario().equals("19:00")){ %> selected<% }%> value="19:00">19:00</option>
    				</select>
					
				</div>
				<div class="campo">
				<label for="opciones">Tipo:</label>
					<input type="text" class="tipoACT" name="tipo" value="musculacion" readonly/>
				</div>
				<div class="final">
					<button class="boton" type="submit">Modificar</button>

				</div>
			</form>
		</div>
	</div>
</body>
</html>