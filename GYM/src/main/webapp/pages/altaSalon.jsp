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
<title>Nueva Clase</title>

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
<link rel="stylesheet" type="text/css" href="/GYM/style/formularioEstilos.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">


<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% Usuario user = (Usuario) session.getAttribute("user");%>

</head>
		<header>
			<%
			    request.setAttribute("activePage", "reservas");
			%>
			<jsp:include page="/pages/components/navbar.jsp" />
			
		</header> 

<body>


	<div class="contenedor">
		<div class="formulario">
			<div class="headerForm">
				<p class= "titulo">Crear una nueva <span class="anaranjado">Clase </span></p>
			</div>
			<hr>
			<form action="/GYM/SvAltaSalon" method="POST" class="formulario-campos" >
				<div class="campo">
					<label>Nombre de la Clase:</label> 
					<input type="text" name="nombre" required/> 
				</div>
				
				
					
				<div class="campo">
					<label>Cupo:</label>
					<input class="cupo" type="number" name="cupo" required />
				</div>
				
				<div class="campo">
					<label for="opciones">Día:</label>
					<select name="dia" id="opciones">
        				<option value="Lunes">Lunes</option>
        				<option value="Martes">Martes</option>
        				<option value="Miercoles">Miercoles</option>
        				<option value="Jueves">Jueves</option>
        				<option value="Viernes">Viernes</option>
    				</select>
					<label for="opciones">Horario:</label>
					<select name="horario" id="opciones">
        				<option value="8:00">8:00</option>
        				<option value="9:00">9:00</option>
        				<option value="10:00">10:00</option>
        				<option value="11:00">11:00</option>
        				<option value="12:00">12:00</option>
        				<option value="13:00">13:00</option>
        				<option value="14:00">14:00</option>
        				<option value="15:00">15:00</option>
        				<option value="16:00">16:00</option>
        				<option value="17:00">17:00</option>
        				<option value="18:00">18:00</option>
        				<option value="19:00">19:00</option>
    				</select>
					
				</div>
				<div class="campo">
				<label for="opciones">Tipo:</label>
					<input type="text" class="tipoACT" name="tipo" value="musculacion" readonly/>
				</div>
				<div class="final">
					<button class="boton" type="submit">Crear</button>

				</div>
			</form>
		</div>
	</div>
</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>