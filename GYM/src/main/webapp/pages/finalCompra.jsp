<%@page import="entities.Producto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Carrito de compras</title>

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

	


<link rel="stylesheet" type="text/css" href="/GYM/style/finalCompra.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% Usuario user = (Usuario) session.getAttribute("user");
/*ArrayList<Producto> productos = (ArrayList<Producto>)request.getAttribute("productos");*/
Producto pro = (Producto)request.getAttribute("producto");
%>	


</head>

<body>
<%if(user == null){ 
response.sendRedirect("/GYM/pages/logIn.jsp");}%>

	<header>
		<%
		    request.setAttribute("activePage", "tienda");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
	</header> 
	

	<div class="contenedor">
	
		
		<div class="cajaAlargada">
		
			<div class="caja1">
				<img class="imagenact" src="<%=pro.getImagen()%>"></img> 
			</div>
		
			<div class="caja2">
				<div class="titulo">
					<span><%=pro.getNombre()%></span>
				</div>
				<div>
					<p><%=pro.getDescripcion()%></p>
				</div>
			</div>
			
			<div class="caja3">
				
				<div>
					<p class="precio">Precio: $<%=pro.getPrecio().getPrecio()%> </p>
				</div>
				<% if(user != null){  %>
				
				<div class="pie">
					<a href=#><button class="boton3" data-bs-toggle="modal" data-bs-target="#exampleModal">Confirmar compra</button> </a>
					<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalLabel">Orden de compra</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				       Se generara una orden de compra, para pagar en la sucursal mas cercana.
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="boton4" data-bs-dismiss="modal">Cerrar</button>
				        <form action="/GYM/SvCompra" method="POST">
				        <input type="hidden" name="id" value="<%=pro.getIdProducto()%>">
				        <button type="submit" class="boton2">Confirmar</button>
				        
				        </form>
				      </div>
				    </div>
				  </div>
				</div>
				</div>
				<%}%>

			</div>
			
		</div>
		
	</div>
	
	

</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>