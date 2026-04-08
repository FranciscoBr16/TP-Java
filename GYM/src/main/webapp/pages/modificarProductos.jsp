<%@page import="entities.Producto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Usuario"%>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>


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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />
<% Usuario user = (Usuario) session.getAttribute("user");
ArrayList<Producto> productos = (ArrayList<Producto>)request.getAttribute("productos");
String query = request.getParameter("txtBuscar") != null ? request.getParameter("txtBuscar") : "";
String orden = request.getParameter("ordenPrecio") != null ? request.getParameter("ordenPrecio") : "";
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
    
    <div class="seccion-filtros">
            <form action="/GYM/SvModificarProductos" method="GET" class="form-filtro">
                <div class="input-filtro">
                    <label><i class="bi bi-search"></i> Buscar Producto:</label>
                    <input type="text" name="txtBuscar" value="<%= query %>" placeholder="Nombre del producto...">
                </div>
                
                <div class="input-filtro" style="flex-grow: 0.5;">
                    <label><i class="bi bi-sort-down"></i> Precio:</label>
                    <select name="ordenPrecio">
                        <option value="" <%= orden.equals("") ? "selected" : "" %>>Relevancia</option>
                        <option value="asc" <%= orden.equals("asc") ? "selected" : "" %>>Menor precio</option>
                        <option value="desc" <%= orden.equals("desc") ? "selected" : "" %>>Mayor precio</option>
                    </select>
                </div>

                <button type="submit" class="boton2" style="margin:0; width: 120px;">Filtrar</button>
                <a href="/GYM/SvModificarProductos" class="boton-linea" style="margin:0; text-align:center; width: 120px;">Limpiar</a>
            </form>
        </div>
    
        
        
        <div class="caja">
        		
        		<div class="tarjetasProducto">
       		 		<% if (productos != null && !productos.isEmpty()) { %>
				
				    <% for (Producto pro : productos) { %>
				        <div class="cajaProducto">
				            <div class="contenedorImg">
				                <img class="imagen" src="<%= pro.getImagen() %>">
				            </div>
				            <hr>
				            <div class="nombre">
				                <p><%= pro.getNombre() %></p>
				            </div>
				            <div class="precio">
				                <p>$ <%= pro.getPrecio().getPrecio() %></p>
				            </div>
				            <div class="botones">
				                <form action="/GYM/SvModificacionProducto" method="GET">
				                    <input type="hidden" name="id_producto"
				                           value="<%= pro.getIdProducto() %>">
				                    <button type="submit" class="boton">
				                        Modificar Producto
				                    </button>
				                </form>
				            </div>
				        </div>
				    <% } %>
				
				<% } else { %>
				
				    <div class="text-center mt-4">
				        <h4>No hay productos para mostrar</h4>
				    </div>
				
				<% } %>

        		</div>
        		
        </div>
       			
  </div>

</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>