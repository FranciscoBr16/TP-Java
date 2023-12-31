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
		<nav class="navbar navbar-expand-lg">
			<div class="container-fluid">
				<a class="navbar-brand" href="/GYM/index.jsp"><img
					src="/GYM/img/logo.png" alt="logo del gimnasio" /></a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link text-light " id="links" aria-current="page" href="/GYM/index.jsp">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-light" id="links" href="/GYM/SvAbono">Planes</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-light active" id="links" href="/GYM/SvProductos" >Tienda</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-light" id="links" href="/GYM/pages/reservas.jsp" >Reservas</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-light" id="links" href="/GYM/SvEmpleados" >Sobre Nosotros</a>
                            </li>
                        </ul>
				</div>
				<% if (user == null){ %>
                    <div class="cajalogin">
                        <a id="textoregistro" href="pages/signUp.jsp"
                            >Registrate</a
                        >
                        <a href="/GYM/pages/logIn.jsp"><button class="boton2">Iniciar Sesi�n</button></a
                        >
                    </div>
                    <% } else {%>
                    <div class="cajaUser">
                        <a class="nombreUsuario" href="/GYM/SvUsuario"><%= user.getNombre() %> <%= user.getApellido()%></a>
                        <img class ="imglogo" src="<%=user.getImagen()%>"></img>
                    </div>
                    <%} %>
			</div>
		</nav>
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

</html>