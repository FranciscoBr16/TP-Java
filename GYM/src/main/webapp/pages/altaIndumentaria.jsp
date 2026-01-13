<%@page import="java.util.ArrayList"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Nuevo Producto</title>

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
		    request.setAttribute("activePage", "tienda");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
	</header> 

<body>


	<div class="contenedor">
		<div class="formulario">
			<div class="headerForm">
				<p class= "titulo">Crear <span class="anaranjado">Producto </span></p>
			</div>
			<hr>
			<form action="/GYM/SvAltaIndumentaria" method="POST" class="formulario-campos" enctype="multipart/form-data">
				<div class="campo">
					<label>Nombre del producto:</label> 
					<input type="text" name="nombre" required/> 
				</div>
					
				<div class="campo">
					<label>Descripcion:</label>
					<input type="text" name="descripcion" required />
				</div>
				
				<div class="campo">
					<label>Stock:</label>
					<input class="stock" type="number" name="stock" required />
				</div>
				
				
				<div class="campo">
				<label for="opciones">Talle:</label>
					<input type="text" class="" name="talle" />
				</div>
				
				<div class="campo">
				<label for="opciones">Precio:</label>
					<input type="number" class="" name="precio" />
				</div>
				
				<div class="campo">
				<label for="imagen">Selecciona una imagen:</label>
  				 <input type="file" name="imagen" id="imagenU">
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