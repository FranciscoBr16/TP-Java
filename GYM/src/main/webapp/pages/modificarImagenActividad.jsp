<%@page import="entities.Usuario"%>
<%@page import="java.util.ArrayList"%>
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
<link rel="stylesheet" type="text/css" href="/GYM/style/modificacionEstilos.css" />


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
		<div class="cajaModificar">
		<div class="headerForm">
			<p class="titulo">Modifica la <span class="anaranjado">Actividad</span></p>
		</div>
		<hr>
			<form action="/GYM/SvCambiarImagenActividad" method="POST" enctype="multipart/form-data">
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
<jsp:include page="/pages/components/carrito.jsp" />
</html>