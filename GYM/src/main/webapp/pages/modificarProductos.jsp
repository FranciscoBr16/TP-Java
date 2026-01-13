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

<title>Tienda</title>

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
<link rel="stylesheet" href="/GYM/style/productosEstilos.css">
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />
<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />
<% Usuario user = (Usuario) session.getAttribute("user");
ArrayList<Producto> productos = (ArrayList<Producto>)request.getAttribute("productos");
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
        
        
        <div class="caja">
        		
        		<div class="tarjetasProducto">
       		 		<% for (Producto pro : productos){ %>
        				<div class="cajaProducto">
        					<div class="contenedorImg">
        						<img class="imagen" src="<%=pro.getImagen()%>">
        					</div>
        				<hr>
        				<div class="nombre">
        					<p><%=pro.getNombre()%></p>
        				</div>
        				<div class="precio">
        					<p>$ <%=pro.getPrecio().getPrecio()%></p>
        				</div>
        				<div class="botones">
        				<form action="/GYM/SvModificacionProducto" method="GET">
						<input type="hidden" name="id_producto" value="<%=pro.getIdProducto()%>">
						<button type="submit" class="boton">Modificar Producto</button>
						</form>
        
                   		</div>
                  
        			</div>
        
        		<%} %>
        		</div>
        		
        </div>
       			
  </div>

</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>