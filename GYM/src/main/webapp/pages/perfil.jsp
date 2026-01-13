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


<link rel="stylesheet" type="text/css" href="/GYM/style/usuPerfilEstilos.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% Usuario user = (Usuario) session.getAttribute("user");
 Contrato contrato = (Contrato) request.getAttribute("contrato");
%>

</head>

<body>
	<header>
		<%
		    request.setAttribute("activePage", "none");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
	</header> 

	<div class="contenedor">
		<div class="cajaPerfil">
			<div class="img-perfil">
				<img src="<%=user.getImagen()%>"></img>
			</div>
			<div class="nombres">
				<span><%=user.getNombre()%></span> <span><%=user.getApellido()%></span>
			</div>
			<hr>
			<div>
				<p>
					Fecha Nacimiento:
					<%=user.getFechaNac()%>
				</p>
			</div>
			<div>
				<p>
					Email:
					<%=user.getEmail()%>
				</p>
			</div>
			<div>
				<p>
					DNI:
					<%=user.getDni()%>
				</p>
			</div>
			<div>
				<p>
					Telefono:
					<%=user.getTelefono() %>
				</p>
			</div>
			<div>
			<% if (contrato != null){ %>
				<p>Abono Activo: <%=contrato.getAbono().getDescripcion()%> </p>
			<%} else { %>
				<p>Abono Activo: Ninguno </p>
				<% } %>
			</div>
			<div>
				<a href="/GYM/SvMisReservas"><button class="boton">Ver reservas</button> </a>
			</div>
			<div>
				<a href="/GYM/SvMisFacturas"><button class="boton">Ver facturas</button> </a>
			</div>

			<div>
				<a href="/GYM/pages/modificarPerfil.jsp"><button class="boton">Modificar perfil</button> </a>
			</div>

		</div>
	
		<div class="botonesAbajo">
			<a href="/GYM/SvCerrarSesion"> <button class="boton">Cerrar Sesion</button></a> 
			<a href="/GYM/SvBajaUsuario"><button class="boton eliminar" style="background-color: rgb(187, 5, 5);">Eliminar Cuenta</button></a>
		</div>
	</div>
	
	

</body>
<jsp:include page="/pages/components/carrito.jsp" />

</html>