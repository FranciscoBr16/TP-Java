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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />
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
            <form action="/GYM/SvProductos" method="GET" class="form-filtro">
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
                <a href="/GYM/SvProductos" class="boton-linea" style="margin:0; text-align:center; width: 120px;">Limpiar</a>
            </form>
        </div>

        <div class="caja">
        		<div class="tarjetasProducto">

                    <% if (productos != null && !productos.isEmpty()) { %>
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
        					    <p>$ <%=pro.getValorPrecio()%></p>
        				    </div>
        				    <div class="botones">
        				        <form action="/GYM/SvDetalleProducto" method="GET">
								    <input type="hidden" name="id" value="<%=pro.getIdProducto()%>">
								    <button type="submit" class="boton4">Ver Detalles</button>
							    </form>
							
        				        <% if (user != null && !user.isAdmin()) { %>
							        <form action="/GYM/SvCarrito" method="post">
							            <input type="hidden" name="accion" value="agregar">
							            <input type="hidden" name="idProducto" value="<%= pro.getIdProducto() %>">
							            <input type="hidden" name="nombre" value="<%= pro.getNombre() %>">
							            <input type="hidden" name="imagen" value="<%= pro.getImagen() %>">
							            <input type="hidden" name="precio" value="<%= pro.getPrecio().getPrecio() %>">
							            <input type="hidden" name="stock" value="<%= pro.getStock() %>">
							
							            <button class="boton5" >
							                Agregar al carrito
							            </button>
							        </form>
						        <% } %>
                   		    </div>
        			    </div>
        		        <%} %>
                    <% } else { %>
                        <div style="text-align: center; width: 100%; padding: 50px;">
                            <h3 style="color: white;">No se encontraron productos que coincidan con la b�squeda.</h3>
                        </div>
                    <% } %>
        		</div>
        </div>

       	<% if (user != null){ if(user.isAdmin()){ %>
            <div style="display: flex; justify-content: center; gap: 20px; margin-top: 20px;">
        		<a href="/GYM/pages/preAltaProducto.jsp"> <button class="boton">Nuevo Producto</button> </a>
                <form action="/GYM/SvModificarProductos" method="GET">
			        <button type="submit" class="boton">Modificar Productos</button>
		        </form>
            </div>
        <%} }%>
  </div>

</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>