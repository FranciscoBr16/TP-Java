<%@page import="entities.Suplemento"%>
<%@page import="entities.Indumentaria"%>
<%@page import="entities.Producto"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Detalle Producto</title>

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


<link rel="stylesheet" type="text/css" href="/GYM/style/detalleProductoEstilos.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% Usuario user = (Usuario) session.getAttribute("user");
 Producto pro = (Producto) request.getAttribute("producto");
%>

</head>

<body>
	<header>
		<%
		    request.setAttribute("activePage", "tienda");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
	</header> 

	<div class="contenedor">
	
	<div class ="caja">
		<div class="caja1">
			<div class="cajaimg">
				<img src="<%=pro.getImagen()%>"></img>
			</div>
		</div>
		<div class="caja2">
			<div class="nombre">
				<span><%=pro.getNombre()%></span> 
			</div>
			<div class="precio">
				<span>$ <%=pro.getPrecio().getPrecio()%></span> 
			</div>
			
			<div class="descripcion">
				<p> Descripcion: </p>
				<p><%=pro.getDescripcion()%></p>
			</div>
			
		
			<% if (pro instanceof Suplemento){ Suplemento s = (Suplemento) pro; %>
			<div>
				<span>
					<%=s.getValor()%> <%=s.getUnidad()%>
				</span>
			</div>
			 <%} else{ Indumentaria i = (Indumentaria) pro; %>
			 <div>
				<span> Talle: <%=i.getTalle()%> </span>
			</div>
			 
			 <%} %>
			 
			 <div class="stock">
				<p>Stock: <%=pro.getStock()%></p>
			</div>

			<div>
				<form action="/GYM/SvCompra" method="POST">
				<input type="hidden" name="id" value="<%=pro.getIdProducto()%>">
					<button type="submit" class="boton">Comprar</button>
				</form>
			<% if (user != null){ if(user.isAdmin()){ %>
				<form action="/GYM/SvModificacionProducto" method="GET">
				<input type="hidden" name="id_producto" value="<%=pro.getIdProducto()%>">
				
					<button type="submit" class="boton">Modificar Producto</button>
				</form>
				<% }} %>
			</div>

		</div>
	</div>
	
	
	</div>
	
	

</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>