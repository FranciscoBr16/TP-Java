<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Registro exitoso</title>

<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@347&display=swap"
	rel="stylesheet" />

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet" />

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/usuRegistroEstilos.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/estilosGenerales2.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/logo.ico" type="image/x-icon" />
</head>

<header>
	<%
	    request.setAttribute("activePage", "none");
	%>
	<jsp:include page="/pages/components/navbar.jsp" />
</header> 

<body>

<div class="contenedor">
	<div class="formulario">
		
		<div class="headerForm">
			<p>¡Registro exitoso!</p>
		</div>

		<div style="text-align:center; padding: 20px;">
			<i class="bi bi-check-circle-fill" style="font-size: 40px; color: green;"></i>
			<p style="margin-top: 10px;">Tu cuenta fue creada correctamente.</p>
		</div>

		<div class="finalform">
			<a href="${pageContext.request.contextPath}/index.jsp" class="boton botonregistro">
				Ir al inicio
			</a>
		</div>

	</div>
</div>

</body>

<jsp:include page="/pages/components/carrito.jsp" />
</html>