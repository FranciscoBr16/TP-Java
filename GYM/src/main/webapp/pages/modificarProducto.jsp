<%@page import="entities.Indumentaria"%>
<%@page import="entities.Suplemento"%>
<%@page import="entities.Producto"%>
<%@page import="entities.Abono"%>
<%@page import="entities.Contrato"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Modificar Producto</title>

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


<link rel="stylesheet" type="text/css" href="/GYM/style/formularioEstilos.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% 
    Usuario user = (Usuario) session.getAttribute("user");
    Producto producto = (Producto) request.getAttribute("producto");
    
    // IMPORTANTE: Guardamos el ID en sesión para que el Servlet de imagen lo encuentre
    session.setAttribute("idproducto", producto.getIdProducto());
    
    if (user == null || !user.isAdmin()) {
        response.sendRedirect("/GYM/pages/logIn.jsp");
        return; 
    }
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
		<div class="formulario">
		<div class="headerForm">
			<p class="titulo">Modifica el <span class="anaranjado"> Producto </span></p>
		</div>
		<hr>
		
            <div class="campoCentrado mb-4 text-center">
                <img class="imgMuestra mb-3" src="<%=producto.getImagen()%>" 
                     style="max-width: 200px; border-radius: 10px; border: 2px solid #d95126;">
                <div class="d-block">
                    <a href="/GYM/pages/modificarImagenProducto.jsp">
                        <button class="boton4">Cambiar Imágen</button>
                    </a>
                </div>
            </div>
            <hr>
					
					
			<form action="/GYM/SvModificarPrecioProducto" method= "POST" class="formulario-campos" >
			<input type="hidden" name="id" value="<%=producto.getIdProducto()%>">
			
			<div class="campo">
			<label for="precio">Precio:</label>
					<input class="inputMediano" type="number" name="precio" id="precio" value="<%=producto.getPrecio().getPrecio()%>"/>
					
				</div>
				<div class="campo">
					<label for="fecha">Fecha:</label> 
					<input class="inputLargo" type="date" name="fecha" id="fecha" value="<%=producto.getPrecio().getFechaDesde()%>"/>
				</div>
			<button class="botonPrecio" type="submit"> Modificar Precio</button>
			</form>
            
            <hr>

			<form action="/GYM/SvModificacionProducto" method="POST" class="formulario-campos">
				<div class="campo">
					<label for="idproducto">Id producto:</label> 
					<input class="inputCorto" type="number" name="id_producto"  value="<%=producto.getIdProducto()%>" readonly/>
				</div>
				
				<div class="campo">
					<label for="nombre">Nombre Producto:</label> 
					<input class="inputMediano" type="text" name="nombre" id="nombre" value="<%=producto.getNombre()%>" />
				</div>
				<div class="campo">
					<label for="stock">Stock:</label> 
					<input class="inputCorto" type="number" name="stock" id="stock" value="<%=producto.getStock()%>"/>
				</div>
				
				<div class="campo">
					<label for="descripcion">Descripcion:</label> 
					<input class="inputLargo" type="text" name="descripcion" id="descripcion" value="<%=producto.getDescripcion()%>"/>
				</div>
				
				
				<% if(producto instanceof Suplemento) { Suplemento s = (Suplemento) producto; %>
				<div class="campo">
					<label for="unidad">Unidad:</label> 
					<input class="inputLargo" type="text" name="unidad" id="unidad" value="<%=s.getUnidad()%>"/>
				</div>
				<div class="campo">
					<label for="valor">Valor:</label> 
					<input class="inputLargo" type="number" name="valor" id="valor" value="<%=s.getValor()%>"/>
				</div>
				<%} else { Indumentaria i = (Indumentaria) producto;%>
				<div class="campo">
					<label for="talle">Talle:</label> 
					<input class="inputLargo" type="text" name="talle" id=talle value="<%=i.getTalle()%>"/>
				</div>
					
				<%} %>
				
				<div class="bottomForm">
					<button class="boton" type="submit"> Aplicar cambios</button>
				</div>
				</form>
			
		</div>

		
	</div>

</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>