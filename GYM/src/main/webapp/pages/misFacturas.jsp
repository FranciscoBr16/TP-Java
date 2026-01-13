
<%@page import="entities.Factura"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Facturas</title>

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

	


<link rel="stylesheet" type="text/css" href="/GYM/style/listado.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% Usuario user = (Usuario) session.getAttribute("user");
ArrayList<Factura> facturas = (ArrayList<Factura>)request.getAttribute("facturas");
%>	


</head>

	<header>
		<%
		    request.setAttribute("activePage", "none");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
	</header> 


<body>
	<div class="container mt-4">
		<% if(!facturas.isEmpty()){ %>
		
			
			  <table class="table table-responsive">
			    <thead>
			      <tr>
			        <th scope="col" class="">Número de Factura</th>
			        <th scope="col" class="">Fecha</th>
			        <th scope="col" class="">Precio</th>
			        <th scope="col" class="">Estado</th>
			      </tr>
			    </thead>
			    <tbody>
			    <%for(Factura f : facturas){ %> 
			      <tr>
			        <td><%=f.getNroFactura()%> </td>
			        <td><%=f.getFecha() %> </td>
			        <td>$ <%=f.getTotal() %> </td> <%-- En el metodo de la BD asignar el valor del producto al total de la factura --%>
			        <td><% if (f.isEstado()){ %> Pagado <% } else {%> Sin pagar <%} %></td>
			      </tr>
			     	<% } %>
			  
			    </tbody>
			  </table>
			

		<%} else { %>
	<div class="fondo-sin-facturas"> <h1>No has realizado ninguna compra</h1> </div>
	<%} %> 
	</div>

</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>