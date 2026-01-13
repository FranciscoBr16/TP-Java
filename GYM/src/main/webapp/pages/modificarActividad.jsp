<%@page import="entities.Empleado"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Clase"%>
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
<title>Modificar Actividad</title>

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

<% Usuario user = (Usuario) session.getAttribute("user");
 Clase clase = (Clase) request.getAttribute("clase");
 ArrayList<Empleado> empleados = (ArrayList<Empleado>) request.getAttribute("empleados");
 session.setAttribute("idclase", clase.getIdClase());
%>

</head>

<body>
	<header>
		<%
		    request.setAttribute("activePage", "reservas");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
	</header> 

	<div class="contenedor">
	
		<div class="formulario">
		<div class="headerForm">
			<p class="titulo">Modifica la <span class="anaranjado">Actividad</span></p>
		</div>
		<hr>
		
				<div class="campoCentrado">
					<img class="imgMuestra" src="<%=clase.getImagen()%>">
					<a href="/GYM/pages/modificarImagenActividad.jsp"><button class="boton4">Cambiar Imágen</button></a>		
				</div>

			<form action="/GYM/SvModificarActividad" method="POST" class="formulario-campos">
				<div class="campo">
					<label for="idClase">Id Clase:</label> 
					<input type="number" name="idClase" id="idAbono" value="<%=clase.getIdClase()%>" readonly/>
				</div>
				
				<div class="campo">
					<label for="nombreClase">Nombre Actividad:</label> 
					<input  type="text" name="nombreClase" id="nombreClase" value="<%=clase.getNombre()%>" required/>
				</div>
				<div class="campo">
					<label for="descripcion">Descripcion:</label> 
					<input type="text" name="descripcion" id="descripcion" value="<%=clase.getDescripcion()%>" required/>
				</div>
				<div class="campo">
					<label for="cupo">Cupo:</label>
					<input  type="number" name="cupo" id="cupo" value="<%=clase.getCupo()%>" required/>
				</div>
				<div class="campo">
				<label for="opciones">Día:</label>
					<select name="dia" id="opciones">
        				<option value="Lunes" <%if(clase.getDia().equals("Lunes")){ %> selected <%} %>>Lunes</option>
        				<option value="Martes" <%if(clase.getDia().equals("Martes")){ %> selected <%} %>>Martes</option>
        				<option value="Miercoles" <%if(clase.getDia().equals("Miercoles")){ %> selected <%} %>>Miercoles</option>
        				<option value="Jueves" <%if(clase.getDia().equals("Jueves")){ %> selected <%} %>>Jueves</option>
        				<option value="Viernes" <%if(clase.getDia().equals("Viernes")){ %> selected <%} %>>Viernes</option>
    				</select>
					<label for="horario">Horario:</label> 
					<select name="horario" id="opciones">
        				<option value="8:00" <%if(clase.getHorario().equals("8:00")){ %> selected <%} %>> 8:00</option>
        				<option value="9:00" <%if(clase.getHorario().equals("9:00")){ %> selected <%} %>>9:00</option>
        				<option value="10:00"<%if(clase.getHorario().equals("10:00")){ %> selected <%} %>>10:00</option>
        				<option value="11:00"<%if(clase.getHorario().equals("11:00")){ %> selected <%} %>>11:00</option>
        				<option value="12:00"<%if(clase.getHorario().equals("12:00")){ %> selected <%} %>>12:00</option>
        				<option value="13:00"<%if(clase.getHorario().equals("13:00")){ %> selected <%} %>>13:00</option>
        				<option value="14:00"<%if(clase.getHorario().equals("14:00")){ %> selected <%} %>>14:00</option>
        				<option value="15:00"<%if(clase.getHorario().equals("15:00")){ %> selected <%} %>>15:00</option>
        				<option value="16:00"<%if(clase.getHorario().equals("16:00")){ %> selected <%} %>>16:00</option>
        				<option value="17:00"<%if(clase.getHorario().equals("17:00")){ %> selected <%} %>>17:00</option>
        				<option value="18:00"<%if(clase.getHorario().equals("18:00")){ %> selected <%} %>>18:00</option>
        				<option value="19:00"<%if(clase.getHorario().equals("19:00")){ %> selected <%} %>>19:00</option>
    				</select>
				</div>
				
				<div class="campo">
				<label for="profesor">Profesor:</label>
   					<select name="idEmpleado" id="idEmpleado">
   					<% for (Empleado emp : empleados){ %>
        				<option value="<%=emp.getIdEmpleado()%>"<%if(emp.getIdEmpleado() == clase.getEmpleado().getIdEmpleado()){%> selected <%} %>> <%=emp.getNombre()%> <%=emp.getApellido()%></option>
        				<%}%>
        			
    				</select>
				</div>
				
				

				<div class="campo">
				<label for="opciones">Tipo:</label>
					<input type="text" name="tipo" value="actividad" readonly/>
				</div>
				
				
				<div class="bottomForm">
					<button class="boton" type="submit"> Aplicar cambios </button>
				</div>
				</form>
				
				
					
			
			
		</div>

		
	</div>

</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>