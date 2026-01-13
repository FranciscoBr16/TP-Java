<%@page import="entities.Usuario"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="entities.Abono"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>Abonos</title>

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
<link rel="stylesheet" type="text/css" href="/GYM/style/abonos.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% ArrayList<Abono> listaAbonos = (ArrayList<Abono>)request.getAttribute("listaAbonos");%>
<% Usuario user = (Usuario) session.getAttribute("user");%>
</head>


<body>
	 <header>
		<%
		    request.setAttribute("activePage", "planes");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
	</header> 

	<div class="principal-box">

	
		<div class="contenido-box">
			<h2 class="bold">Elegi tu <span class="naranja">plan ideal</span></h2>
			<p>Entrena con nosotros eligiendo un plan. Todos incluyen las areas de cardio, peso integrado, peso libre, funcional, profesores de piso para evaluaciones y creacion de rutinas, vestidores y mas.</p>
		</div>

		<div class="planes-box">
			<% for (Abono i : listaAbonos) { %>
				
					<div class="tarjeta-plan">
						<img src="<%=i.getImagen()%>" alt="">
						<div class="descripcion-plan">
							<h2><span class="naranja">Plan</span><%=i.getNombreAbono()%></h2>
							<p>Desde $<%=i.getPrecio()%>/mes</p>
							<p><%=i.getCantReservas()%> clases mensuales</p>
							<button class="boton-linea">Incribirse</button>
							<% if(user != null){  %>
							<% if(user.isAdmin()){ %>
							<form action="/GYM/SvBajaAbono" method="POST">
								<input type="hidden" name="id" value="<%=i.getIdAbono()%>">
								<button type="submit" class="boton-borrar">Eliminar Abono</button>
							</form>
							<form action="/GYM/SvModificarAbono" method="GET">
								<input type="hidden" name="id" value="<%=i.getIdAbono()%>">
								<button type="submit" class="boton-modificar">Modificar Abono</button>
							</form>
							<% } }%>
						</div>
					</div>	
			<% 
			}  %>
			<% if(user != null){  %>
			<% if(user.isAdmin()){ %>
		</div>
			<a href="/GYM/pages/altaAbono.jsp"><button class="boton">Agregar nuevo plan</button></a>
		</div>
		<% } }%>


</body>
<jsp:include page="/pages/components/carrito.jsp" />

</html>