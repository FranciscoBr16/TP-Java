<%@page import="entities.Clase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Contrato"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Actividades</title>

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

<link rel="stylesheet" type="text/css" href="/GYM/style/actListadoEstilos.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% Usuario user = (Usuario) session.getAttribute("user");
ArrayList<Clase> actividades = (ArrayList<Clase>)request.getAttribute("actividades");
%>	

</head>

<body>

	<header>
		<%
		    request.setAttribute("activePage", "reservas");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
	</header> 
	
	<% 
		String mensaje = (String) session.getAttribute("mensaje");
		String tipoMensaje = (String) session.getAttribute("tipoMensaje");
		if (mensaje != null) { 
			// Definimos el color según el tipo de mensaje (verde éxito, rojo error o amarillo advertencia)
			String colorFondo = "#dc3545"; // Rojo por defecto (error/danger)
			if ("success".equals(tipoMensaje)) colorFondo = "#28a745"; // Verde
			else if ("warning".equals(tipoMensaje)) colorFondo = "#ffc107"; // Amarillo
	%>
		<div id="mensajeAlerta" style="position: fixed; top: 80px; right: 20px; z-index: 1000; min-width: 300px; padding: 15px 20px; border-radius: 8px; background-color: <%= colorFondo %>; color: <%= "warning".equals(tipoMensaje) ? "#191617" : "white" %>; font-weight: bold; border: 2px solid #191617; box-shadow: 0 4px 12px rgba(0,0,0,0.2);">
			<button onclick="document.getElementById('mensajeAlerta').style.display='none'" style="background: transparent; border: none; color: inherit; font-size: 20px; cursor: pointer; float: right; margin-left: 15px; margin-top: -5px;">&times;</button>
			<%= mensaje %>
		</div>
		<script>
			// Ocultar automáticamente después de 5 segundos
			setTimeout(function() {
				var msj = document.getElementById('mensajeAlerta');
				if (msj) { msj.style.display = 'none'; }
			}, 5000);
		</script>
	<% 
			// Limpiamos la sesión para que el mensaje no vuelva a aparecer
			session.removeAttribute("mensaje");
			session.removeAttribute("tipoMensaje");
		} 
	%>
	
	<div class="contenedor">
	
		<%for(Clase act : actividades){ %>
		<div class="cajaAlargada">
		
			<div class="caja1">
				<img class="imagenact" src="<%=act.getImagen()%>"></img> 
			</div>
		
			<div class="caja2">
				<div class="titulo">
					<span><%=act.getNombre()%></span>
				</div>
				<div>
					<p><%=act.getDescripcion()%></p>
				</div>
				<div> <p>Profesor: <%=act.getEmpleado().getNombre()%> <%=act.getEmpleado().getApellido() %> </p> </div>
			</div>
			

			<div class="caja3">
				<div class="diayhorario">
					<span><%=act.getDia() %></span> <span><%=act.getHorario() %></span>
				</div>
				<div>
					<p class="cupo">Cupo: <%=act.getCupo()%> </p>
				</div>
				<% if(user != null){  %>
					<% if(!user.isAdmin()){ %>
				<div class="pie">
					<form action="/GYM/SvInscripcion" method ="POST">
						<input type="hidden" name="id" value="<%=act.getIdClase()%>">
						<button type="submit" class="boton3">Reservar</button>
					</form>
				</div>
				
				<% } }%>
				
				<div class="pie">
					
					<% if(user != null){  %>
					<% if(user.isAdmin()){ %>
					<form action="/GYM/SvModificarActividad" method="GET">
								<input type="hidden" name="id" value="<%=act.getIdClase()%>">
								<button type="submit" class="boton4">Modificar Clase</button>
							</form>
							<form action="/GYM/SvBajaClase" method ="POST">
								<input type="hidden" name="id" value="<%=act.getIdClase()%>">
								<button type="submit" class="boton3">Eliminar</button>
							</form>
							<% } }%>
				</div>

			</div>
			
		</div>
		  <%} %>
		<% if(user != null){  %>
		<% if(user.isAdmin()){ %>
		<div style="margin-bottom: 40px;"> <a href="/GYM/SvPreAltaActividad"><button class="boton">Nueva Actividad</button></a> </div>
		
		<% } }%>
		
	</div>
	
</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>