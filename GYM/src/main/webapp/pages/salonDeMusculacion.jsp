<%@page import="entities.Clase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Actividades</title>

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

<link rel="stylesheet" type="text/css" href="/GYM/style/estilosSalonDeMusculacion.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />

<% Usuario user = (Usuario) session.getAttribute("user");%>
<%  ArrayList<Clase> clases = (ArrayList<Clase>)request.getAttribute("clases");%>	


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
						<li class="nav-item"><a class="nav-link text-light"
							id="links" aria-current="page" href="/GYM/index.jsp">Inicio</a></li>
						<li class="nav-item"><a class="nav-link text-light"
							id="links" href="/GYM/SvAbono">Planes</a></li>
						<li class="nav-item"><a class="nav-link text-light"
							id="links" href="#">Tienda</a></li>
						<li class="nav-item"><a class="nav-link text-light active"
							id="links" href="/GYM/pages/reservas.jsp">Reservas</a></li>
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
                        <a class="nombreUsuario" href="/GYM/SvUsuario"><%= user.getNombre() %> <%= user.getApellido()%></a>
                        <img class ="imglogo" src="<%=user.getImagen()%>"></img>
                    </div>
                    <%} %>
			</div>
		</nav>
	</header>
	
	<!--  Usar para la barra de busqueda y filtrado 
	<div>
	
	</div>
	-->
	<% ArrayList<Clase> actividadesLunes = new ArrayList<>();
	ArrayList<Clase> actividadesMartes = new ArrayList<>();
	ArrayList<Clase> actividadesMiercoles = new ArrayList<>();
	ArrayList<Clase> actividadesJueves = new ArrayList<>();
	ArrayList<Clase> actividadesViernes = new ArrayList<>();

	for(Clase act : clases){ 
	switch(act.getDia()) {
		case "Lunes": 
			actividadesLunes.add(act);
			break;
		case "Martes":
			actividadesMartes.add(act);
			break;
		case "Miercoles":
			actividadesMiercoles.add(act);
			break;
		case "Jueves":
			actividadesJueves.add(act);
			break;
		case "Viernes":
			actividadesViernes.add(act);
			break;
		default:
			break;

		}
	}%>

	<div class="contenedor"> 
	
	<div class="Caja">
		<div class="titulo"> 
			<p>Lunes</p>
		</div>
		<div class="contenidoCaja"> 
			<%for (Clase lun : actividadesLunes){ %>
			<div class="cajaClase">
				<div class="cajaIzquierda">
					<%String horario = String.valueOf(lun.getHorario());  
						if (horario.length() == 4){%>
						<span><%=horario.substring(0, 2)%>:<%=horario.substring(2)%></span>
						<%} else { %>
						<span><%=horario.substring(0, 1)%>:<%=horario.substring(1)%></span>
						<%} %>
				</div>
				<div class="cajaDerecha">
					<div class="cajaCupo">
						<p class="cupo">Cupo: <%=lun.getCupo()%> </p>
					</div>
					<div class="cajaBotones">
						<a href="#"><button class="boton2">Reservar</button> </a>
							<% if(user != null){  %>
								<% if(user.isAdmin()){ %>
									<form action="/GYM/SvModificarActividad" method="GET">
										<input type="hidden" name="id" value="<%=lun.getIdClase()%>">
										<button type="submit" class="boton2">Modificar Clase</button>
									</form>
							<% } }%>
					</div>
				</div>	
			</div>
		
			<%} %>
		</div>
	</div>
	
	<div class="Caja">
		<div class="titulo">
			<p>Martes</p>
		</div>
		<div class="contenidoCaja">
			<%for (Clase mar : actividadesMartes){ %>
			<div class="cajaClase">
				<div class="cajaIzquierda">
					<%String horario = String.valueOf(mar.getHorario()); 
						if (horario.length() == 4){%>
						<span><%=horario.substring(0, 2)%>:<%=horario.substring(2)%></span>
						<%} else { %> 
						<span><%=horario.substring(0, 1)%>:<%=horario.substring(1)%></span>
						<%} %>
				</div>
				<div class="cajaDerecha">
					<p class="cupo">Cupo: <%=mar.getCupo()%> </p>
					<a href="#"><button class="boton2">Reservar</button> </a>
					<% if(user != null){  %>
						<% if(user.isAdmin()){ %>
						<form action="/GYM/SvModificarActividad" method="GET">
								<input type="hidden" name="id" value="<%=mar.getIdClase()%>">
								<button type="submit" class="boton2">Modificar Clase</button>
						</form>
						<% } }%>
				</div>
			</div>
			<%} %>
		</div>
	</div>
		
	<div class="Caja">
		<div class="titulo">
			<p>Miercoles</p>
		</div>
		<div class="contenidoCaja">
			<%for (Clase mier : actividadesMiercoles){ %>
				<div class="cajaClase">
					<div class="cajaIzquierda">
						<%String horario = String.valueOf(mier.getHorario()); 
						if (horario.length() == 4){%>
						<span><%=horario.substring(0, 2)%>:<%=horario.substring(2)%></span>
						<%} else { %>
						<span><%=horario.substring(0, 1)%>:<%=horario.substring(1)%></span>
						<%} %>
					</div>
					<div class="cajaDerecha">
						<p class="cupo">Cupo: <%=mier.getCupo()%> </p>
						<a href="#"><button class="boton2">Reservar</button> </a>
						<% if(user != null){  %>
							<% if(user.isAdmin()){ %>
								<form action="/GYM/SvModificarActividad" method="GET">
									<input type="hidden" name="id" value="<%=mier.getIdClase()%>">
									<button type="submit" class="boton2">Modificar Clase</button>
								</form>
							<% } }%>
					</div>
				</div>
			<%} %>
		</div>
	</div>
	
	<div class="Caja">
		<div class="titulo">
			<p>Jueves</p>
		</div>
		<div class="contenidoCaja">
			<%for (Clase jue : actividadesJueves){ %>
				<div class="cajaClase">
					<div class="cajaIzquierda">
						<%String horario = String.valueOf(jue.getHorario());  
						if (horario.length() == 4){%>
						<span><%=horario.substring(0, 2)%>:<%=horario.substring(2)%></span>
						<%} else { %>
						<span><%=horario.substring(0, 1)%>:<%=horario.substring(1)%></span>
						<%} %>
					</div>
					<div class="cajaDerecha">
						<p class="cupo">Cupo: <%=jue.getCupo()%> </p>
						<a href="#"><button class="boton2">Reservar</button> </a>
						<% if(user != null){  %>
							<% if(user.isAdmin()){ %>
								<form action="/GYM/SvModificarActividad" method="GET">
									<input type="hidden" name="id" value="<%=jue.getIdClase()%>">
									<button type="submit" class="boton2">Modificar Clase</button>
								</form>
						<% } }%>
					</div>
				</div>
			<%} %>
		</div>
	</div>
	
	<div class="Caja">
		<div class="titulo">
			<p>Viernes</p>
		</div>
		<div class="contenidoCaja">
			<%for (Clase vie : actividadesViernes){ %>
				<div class="cajaClase">
					<div class="cajaIzquierda">
					<%String horario = String.valueOf(vie.getHorario());  
						if (horario.length() == 4){%>
						<span><%=horario.substring(0, 2)%>:<%=horario.substring(2)%></span>
						<%} else { %>
						<span><%=horario.substring(0, 1)%>:<%=horario.substring(1)%></span>
						<%} %> 
					</div>
					<div class="cajaDerecha">
						<p class="cupo">Cupo: <%=vie.getCupo()%> </p>
						<a href="#"><button class="boton2">Reservar</button> </a>
						<% if(user != null){  %>
							<% if(user.isAdmin()){ %>
								<form action="/GYM/SvModificarActividad" method="GET">
									<input type="hidden" name="id" value="<%=vie.getIdClase()%>">
									<button type="submit" class="boton2">Modificar Clase</button>
								</form>
							<% } }%>
					</div>
				</div>
			<%} %>
		</div>
	</div>
		
	
		<% if(user != null){%>
		<% if(user.isAdmin()){ %>
		<div> <a href="/GYM/SvActividadesEmpleado"><button class="boton">Nueva Clase</button></a> </div>
		<%}}%>
		
		
	</div>
	
	

</body>

</html>