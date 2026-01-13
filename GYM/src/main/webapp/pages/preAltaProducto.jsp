<%@page import="entities.Contrato"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Alta Producto</title>

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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />
<% Usuario user = (Usuario) session.getAttribute("user");%>

</head>

<body>
	<header>
		<%
		    request.setAttribute("activePage", "tienda");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
	</header> 

	<div class="contenedor">
		<div class="caja">
			<div class="titulo">
				<p>Indumentaria</p>
			</div>
			<div class="imagen">
				<img src="/GYM/img/indumentaria.jpeg"></img>
			</div>
			
			<hr>
			<div>
			<ul>
				<li>Da de alta prendas cómodas y adecuadas para facilitar la movilidad, junto con zapatillas deportivas que brindan soporte y amortiguación.</li>
				
			</ul>
			</div>
			
			<div class="final">
				<a href="/GYM/pages/altaIndumentaria.jsp"><button class="boton">Cargar Indumentaria</button> </a>
			</div>

	
		</div>
		<div class="caja">
				<div class="titulo">
					<p>Suplementos</p>
				</div>
			<div class="imagen">
				<img src="/GYM/img/suplementos.jpg"></img>
			</div>
			
			<hr>
			<div>
			<ul>
				<li>Da de alta productos diseñados para apoyar el rendimiento físico y la recuperación muscular. Estos productos pueden incluir proteínas aminoácidos, vitaminas y minerales</li>
			</ul>
			</div>
			
			<div class="final">
				<a href="/GYM/pages/altaSuplementos.jsp"><button class="boton">Cargar Suplemento</button> </a>
			</div>

			

		</div>
		
	</div>

	
	

</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>