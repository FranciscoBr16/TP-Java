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
<title>Log In</title>

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

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.12.1/css/all.css"
	crossorigin="anonymous" />

<link rel="stylesheet" type="text/css" href="/GYM/style/modificarPerfilStyle.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/generalStyles.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/generalStyles2.css" />

<% Usuario user = (Usuario) session.getAttribute("user");
 Clase clase = (Clase) request.getAttribute("clase");
 ArrayList<Empleado> empleados = (ArrayList<Empleado>) request.getAttribute("empleados");
%>

</head>

<body>
	<header>
		<nav class="navbar navbar-expand-lg">
			<div class="container-fluid">
				<a class="navbar-brand" href="../index.jsp"><img
					src="/GYM/img/logo.png" alt="logo del gimnasio" /></a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link text-light"
							id="links" aria-current="page" href="../index.jsp">Inicio</a></li>
						<li class="nav-item"><a class="nav-link text-light"
							id="links" href="/GYM/SvAbono">Planes</a></li>
						<li class="nav-item"><a class="nav-link text-light"
							id="links" href="#">Tienda</a></li>
						<li class="nav-item"><a class="nav-link text-light"
							id="links" href="#">Reservas</a></li>
						<li class="nav-item"><a class="nav-link text-light"
							id="links" href="#">Sobre Nosotros</a></li>
					</ul>
				</div>
				<% if (user == null){ %>
                    <div class="cajalogin">
                        <a id="textoregistro" href="pages/signUp.jsp"
                            >Registrate</a
                        >
                        <a href="/GYM/pages/logIn.jsp"><button class="boton2">Iniciar Sesión</button></a
                        >
                    </div>
                    <% } else {%>
                    <div class="cajaUser">
                        <i class="fas fa-solid fa-user"></i>
                        <a class="nombreUsuario" href="/GYM/SvUsuario"
                            ><%= user.getNombre() %></a
                        >
                    </div>
                    <%} %>
			</div>
		</nav>
	</header>

	<div class="contenedor">
		<div class="cajaModificar">
		<div class="titulo">
			<p>Modifica la Actividad </p>
		</div>

			<form action="/GYM/SvModificarActividad" method="POST" class="formulario-campos">
				<div class="campo">
					<label for="idClase">Id Clase:</label> 
					<input class="idClase" type="number" name="idClase" id="idAbono" value="<%=clase.getIdClase()%>" readonly/>
				</div>
				
				<div class="campo">
					<label for="nombreClase">Nombre Actividad:</label> 
					<input class="nombreClase" type="text" name="nombreClase" id="nombreClase" value="<%=clase.getNombre()%>" />
				</div>
				<div class="campo">
					<label for="descripcion">Descripcion:</label> 
					<input type="text" name="descripcion" id="descripcion" value="<%=clase.getDescripcion()%>"/>
				</div>
				<div class="campo">
					<label for="cupo">Cupo:</label>
					<input type="number" name="cupo" id="cupo" value="<%=clase.getCupo()%>"/>
				</div>
				<div class="campo">
					<label for="horario">Horario:</label> 
					<input type="number" name="horario" id="horario" value="<%=clase.getHorario()%>"/> 
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
					<label for="dia">Dia:</label>
					<input type="text" name="dia" id="dia" value="<%=clase.getDia()%>"/>
				</div>

				<div class="campo">
					<label for="opciones">Tipo:</label>
   					<select name="tipo" id="opciones">
        				<option value="musculacion" <%if(clase.getTipo().equals("musculacion")){%> selected <%} %>>musculacion</option>
        				
        				<option value="actividad"<%if(clase.getTipo().equals("actividad")){%> selected <%} %>>actividad</option>
    				</select>
				</div>
				
				<div class="final">
					<button class="boton" type="submit"> Aplicar cambios </button>
				</div>
				</form>
			
		</div>

		
	</div>

</body>

</html>