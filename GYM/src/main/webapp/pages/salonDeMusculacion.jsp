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

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" type="text/css" href="/GYM/style/salonDeMusculacionEstilos.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% Usuario user = (Usuario) session.getAttribute("user");%>
<%  ArrayList<Clase> clases = (ArrayList<Clase>)request.getAttribute("clases");%>	


</head>

<body>
	<header>
		<%
		    request.setAttribute("activePage", "reservas");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
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
					<span class="horario"><%=lun.getHorario()%></span>
				</div>
				<div class="cajaDerecha">
					<div class="cajaCupo">
						<p class="cupo">Cupo: <%=lun.getCupo()%> </p>
					</div>
					<div class="cajaBotones">
							<% if(user != null){  %>
							<form action="/GYM/SvInscripcion" method ="POST">
						<input type="hidden" name="id" value="<%=lun.getIdClase()%>">
						<button type="submit" class="boton3">Reservar</button>
							</form>	
								<% if(user.isAdmin()){ %>
									<div class="botonesFinales">
									<form action="/GYM/SvModificarSalon" method="GET">
										<input type="hidden" name="id" value="<%=lun.getIdClase()%>">
										
										<button type="submit" class="boton5">Modificar Clase</button>
									</form>
									<form action="/GYM/SvBajaClase" method="POST">
									<input type="hidden" name="id" value="<%=lun.getIdClase()%>">
									<button type="submit" class="boton6"><i class="fas fa-solid fa-trash"></i></button>
								</form>
								</div>
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
					<span class="horario"><%=mar.getHorario()%></span>
				</div>
				<div class="cajaDerecha">
					<p class="cupo">Cupo: <%=mar.getCupo()%> </p>
					<% if(user != null){  %>
					<form action="/GYM/SvInscripcion" method ="POST">
						<input type="hidden" name="id" value="<%=mar.getIdClase()%>">
						<button type="submit" class="boton3">Reservar</button>
					</form>		
					<% if(user.isAdmin()){ %>	
						<div class="botonesFinales">
						<form action="/GYM/SvModificarSalon" method="GET">
								<input type="hidden" name="id" value="<%=mar.getIdClase()%>">
								<button type="submit" class="boton5">Modificar Clase</button>
						</form>
						<form action="/GYM/SvBajaClase" method="POST">
									<input type="hidden" name="id" value="<%=mar.getIdClase()%>">
									<button type="submit" class="boton6"><i class="fas fa-solid fa-trash"></i></button>
								</form>
								</div>
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
						<span class="horario"><%=mier.getHorario()%></span>
					</div>
					<div class="cajaDerecha">
						<p class="cupo">Cupo: <%=mier.getCupo()%> </p>
						<% if(user != null){  %>
						<form action="/GYM/SvInscripcion" method ="POST">
						<input type="hidden" name="id" value="<%=mier.getIdClase()%>">
						<button type="submit" class="boton3">Reservar</button>
					</form>	
							<% if(user.isAdmin()){ %>
								<div class="botonesFinales">
								<form action="/GYM/SvModificarSalon" method="GET">
									<input type="hidden" name="id" value="<%=mier.getIdClase()%>">
									<button type="submit" class="boton5">Modificar Clase</button>
								</form>
								<form action="/GYM/SvBajaClase" method="POST">
									<input type="hidden" name="id" value="<%=mier.getIdClase()%>">
									<button type="submit" class="boton6"><i class="fas fa-solid fa-trash"></i></button>
								</form>
								</div>
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
						<span class="horario"><%=jue.getHorario()%></span>
					</div>
					<div class="cajaDerecha">
						<p class="cupo">Cupo: <%=jue.getCupo()%> </p>
						<% if(user != null){  %>
						<form action="/GYM/SvInscripcion" method ="POST">
						<input type="hidden" name="id" value="<%=jue.getIdClase()%>">
						<button type="submit" class="boton3">Reservar</button>
					</form>	
							<% if(user.isAdmin()){ %>
								<div class="botonesFinales">
								<form action="/GYM/SvModificarSalon" method="GET">
									<input type="hidden" name="id" value="<%=jue.getIdClase()%>">
									<button type="submit" class="boton5">Modificar Clase</button>
								</form>
								<form action="/GYM/SvBajaClase" method="POST">
									<input type="hidden" name="id" value="<%=jue.getIdClase()%>">
									<button type="submit" class="boton6"><i class="fas fa-solid fa-trash"></i></button>
								</form>
								</div>
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
					<span class="horario"><%=vie.getHorario()%></span>
					</div>
					<div class="cajaDerecha">
						<p class="cupo">Cupo: <%=vie.getCupo()%> </p>
						<% if(user != null){  %>
						<form action="/GYM/SvInscripcion" method ="POST">
						<input type="hidden" name="id" value="<%=vie.getIdClase()%>">
						<button type="submit" class="boton3">Reservar</button>
					</form>	
							<% if(user.isAdmin()){ %>
								<div class="botonesFinales">
								<form action="/GYM/SvModificarSalon" method="GET">
									<input type="hidden" name="id" value="<%=vie.getIdClase()%>">
									<button type="submit" class="boton5">Modificar Clase</button>
								</form>
								<form action="/GYM/SvBajaClase" method="POST">
									<input type="hidden" name="id" value="<%=vie.getIdClase()%>">
									<button type="submit" class="boton6"><i class="fas fa-solid fa-trash"></i></button>
								</form>
								</div>
								
							<% } }%>
					</div>
				</div>
			<%} %>
		</div>
	</div>
		
	
		<% if(user != null){%>
		<% if(user.isAdmin()){ %>
		<div> <a href="/GYM/pages/altaSalon.jsp"><button class="boton">Nueva Clase</button></a> </div>
		<%}}%>
		
		
	</div>
	
	

</body>
<jsp:include page="/pages/components/carrito.jsp" />

</html>