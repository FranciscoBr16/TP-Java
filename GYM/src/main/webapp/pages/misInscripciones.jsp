
<%@page import="entities.Inscripcion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Mis Reservas</title>

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

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% Usuario user = (Usuario) session.getAttribute("user");
ArrayList<Inscripcion> ins = (ArrayList<Inscripcion>)request.getAttribute("reservas");
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
		<% if(!ins.isEmpty()){ %>
		
			
			  <table class="table table-responsive">
			    <thead>
			      <tr>
			        <th scope="col" class="">Fecha de la Reserva</th>
			        <th scope="col" class="">Nombre de la Clase</th>
			        <th scope="col" class="">Dia de la clase</th>
			        <th scope="col" class="">Horario de la clase</th>
			      </tr>
			    </thead>
			    <tbody>
			    <%for(Inscripcion i : ins){ %> 
			      <tr>
			        <td><%=i.getFechaInscripcion() %> </td>
			        <td><%=i.getClase().getNombre() %> </td>
			        <td><%=i.getClase().getDia() %> </td>
			        <td><%=i.getClase().getHorario()%> </td>
			      </tr>
			     	<% } %>
			  
			    </tbody>
			  </table>
			

		<%} else { %>
	<div class="fondo-sin-facturas"> <h1>No has realizado ninguna reserva en estos días</h1> </div>
	<%} %> 
	</div>

</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>