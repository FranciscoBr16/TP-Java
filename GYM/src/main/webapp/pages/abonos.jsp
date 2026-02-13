<%@page import="entities.Usuario"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<% 
ArrayList<Abono> listaAbonos = (ArrayList<Abono>)request.getAttribute("listaAbonos");
Usuario user = (Usuario) session.getAttribute("user");

// Obtener mensajes de la sesión
String mensaje = (String) session.getAttribute("mensaje");
String tipoMensaje = (String) session.getAttribute("tipoMensaje");
session.removeAttribute("mensaje");
session.removeAttribute("tipoMensaje");
%>
</head>


<body>
	 <header>
		<%
		    request.setAttribute("activePage", "planes");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
	</header> 

	<!-- Mensaje de error/éxito -->
	<% if (mensaje != null) { %>
	    <div class="mensaje-alerta <%= tipoMensaje != null && tipoMensaje.equals("success") ? "mensaje-exito" : "mensaje-error" %>" id="mensajeAlerta">
	        <button class="btn-cerrar-mensaje" onclick="cerrarMensaje()">&times;</button>
	        <strong><%= tipoMensaje != null && tipoMensaje.equals("success") ? "✓" : "✗" %></strong>
	        <%= mensaje %>
	    </div>
	<% } %>

	<div class="principal-box">
		<!-- SECCIÓN ABONOS MENSUALES -->
		<div class="contenido-box">
			<h2 class="bold">Elegí tu <span class="naranja">plan mensual</span></h2>
			<p>Entrená con nosotros eligiendo un plan. Todos incluyen las áreas de cardio, peso integrado, peso libre, funcional, profesores de piso para evaluaciones y creación de rutinas, vestidores y más.</p>
		</div>

		<div class="planes-box">
			<% 
			boolean hayMensuales = false;
			for (Abono i : listaAbonos) { 
				if (i.es_mensual()) {
					hayMensuales = true;
			%>
					<div class="tarjeta-plan">
						<img src="<%=i.getImagen()%>" alt="<%=i.getNombreAbono()%>">
						<div class="descripcion-plan">
							<h2><span class="naranja">Plan</span> <%=i.getNombreAbono()%></h2>
							<p><strong>$<%=i.getPrecio()%></strong>/mes</p>
							<p><i class="bi bi-calendar-check"></i> <%=i.getCantReservas()%> clases mensuales</p>
							<button class="boton-linea" onclick="confirmarAbono(<%=i.getIdAbono()%>, '<%=i.getNombreAbono()%>')">Inscribirse</button>
							
							<% if(user != null && user.isAdmin()){ %>
								<form action="/GYM/SvBajaAbono" method="POST">
									<input type="hidden" name="id" value="<%=i.getIdAbono()%>">
									<button type="submit" class="boton-borrar">Eliminar Abono</button>
								</form>
								<form action="/GYM/SvModificarAbono" method="GET">
									<input type="hidden" name="id" value="<%=i.getIdAbono()%>">
									<button type="submit" class="boton-modificar">Modificar Abono</button>
								</form>
							<% } %>
						</div>
					</div>	
			<% 
				}
			} 
			
			if (!hayMensuales) { %>
				<p class="text-muted">No hay planes mensuales disponibles en este momento.</p>
			<% } %>
		</div>

		<!-- SECCIÓN CLASES ADICIONALES -->
		<% 
		boolean hayClasesAdicionales = false;
		for (Abono i : listaAbonos) { 
			if (!i.es_mensual()) {
				hayClasesAdicionales = true;
				break;
			}
		}
		
		if (hayClasesAdicionales) { %>
			<div class="separador"></div>
			
			<div class="contenido-box clases-adicionales-header">
				<h2 class="bold">Comprá <span class="naranja">clases adicionales</span></h2>
				<p>¿Ya tenés un plan activo y necesitás más clases? Comprá clases adicionales en packs flexibles.</p>
			</div>

			<div class="clases-box">
				<% for (Abono i : listaAbonos) { 
					if (!i.es_mensual()) {
				%>
						<div class="tarjeta-clase">
							<div class="icono-clase">
								<i class="bi bi-bookmark-star-fill"></i>
							</div>
							<div class="info-clase">
								<h3><%=i.getNombreAbono()%></h3>
								<p class="descripcion-clase"><%=i.getDescripcion()%></p>
								<div class="detalles-clase">
									<span class="cantidad-clases">
										<i class="bi bi-calendar-plus"></i> 
										<strong><%=i.getCantReservas()%></strong> <%= i.getCantReservas() == 1 ? "clase" : "clases" %>
									</span>
									<span class="precio-clase">
										<strong>$<%=i.getPrecio()%></strong>
									</span>
								</div>
								<button class="boton-comprar-clase" onclick="confirmarAbono(<%=i.getIdAbono()%>, '<%=i.getNombreAbono()%>')">
									<i class="bi bi-cart-plus"></i> Comprar
								</button>
								
								<% if(user != null && user.isAdmin()){ %>
									<div class="admin-actions">
										<form action="/GYM/SvBajaAbono" method="POST" style="display:inline;">
											<input type="hidden" name="id" value="<%=i.getIdAbono()%>">
											<button type="submit" class="boton-borrar-small">Eliminar</button>
										</form>
										<form action="/GYM/SvModificarAbono" method="GET" style="display:inline;">
											<input type="hidden" name="id" value="<%=i.getIdAbono()%>">
											<button type="submit" class="boton-modificar-small">Modificar</button>
										</form>
									</div>
								<% } %>
							</div>
						</div>	
				<% 
					}
				} %>
			</div>
		<% } %>

		<!-- Botón Admin: Agregar nuevo plan -->
		<% if(user != null && user.isAdmin()){ %>
			<div style="margin-top: 40px;">
				<a href="/GYM/pages/altaAbono.jsp"><button class="boton">Agregar nuevo plan</button></a>
			</div>
		<% } %>
	</div>

<script>
function confirmarAbono(idAbono, nombre) {
    if (confirm("¿Estás seguro de que querés adquirir: " + nombre + "?")) {
        window.location.href = "/GYM/SvComprarAbono?id_abono=" + idAbono;
    }
}

function cerrarMensaje() {
    var mensaje = document.getElementById('mensajeAlerta');
    if (mensaje) {
        mensaje.style.display = 'none';
    }
}

// Auto-cerrar mensaje después de 5 segundos
setTimeout(function() {
    var mensaje = document.getElementById('mensajeAlerta');
    if (mensaje) {
        mensaje.style.animation = 'slideIn 0.3s ease-out reverse';
        setTimeout(function() {
            mensaje.style.display = 'none';
        }, 300);
    }
}, 5000);
</script>

</body>
<jsp:include page="/pages/components/carrito.jsp" />

</html>
