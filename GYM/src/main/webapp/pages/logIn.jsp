<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Log In</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@347&display=swap"
	rel="stylesheet">

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

<link rel="stylesheet" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" href="/GYM/style/estilosGenerales2.css" />
<link rel="stylesheet" href="/GYM/style/usuLogInEstilos.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />
</head>

<body>
	<header>
		<%
		    request.setAttribute("activePage", "none");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
	</header> 

	<div class="contenedor">
		<div class="tarjetaLogin">
			<div class="inicia">
				<p>Iniciar Sesión</p>
			</div>
			
			
			<form action="/GYM/SvLogIn" method="POST">
				<div class="inputs">
					<label for="username">DNI</label> <input type="text" id="username"
						name="dni" required class="form-control">
				</div>
				<div class="inputs">
					<label for="password">Contraseña</label> <input type="password"
						id="password" name="password" required class="form-control">
				</div>
				
				<div class="final">
				<% if (request.getAttribute("errorLogin") != null) { %>
				    <p class="text-danger text-center mt-2">
				        <%= request.getAttribute("errorLogin") %>
				    </p>
				<% } %>
				
					<a><button  type="submit" class="boton">Iniciar Sesión</button> </a>
				</div>

			</form>

		</div>
	</div>

</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>