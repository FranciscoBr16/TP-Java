<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="entities.Abono"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>Abonos</title>

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
<link rel="stylesheet" href="/GYM/style/abonoStyles.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/generalStyles.css" />
<link rel="stylesheet" type="text/css"
	href="/GYM/style/generalStylesII.css" />
<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% ArrayList<Abono> listaAbonos = (ArrayList<Abono>)request.getAttribute("listaAbono");	%>
</head>


<body>
	 <header>
		<nav class="navbar navbar-expand-lg">
			<div class="container-fluid">
				<a class="navbar-brand" href="index.jsp"><img src="/GYM/img/logo.png"
					alt="logo del gimnasio" /></a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link text-light"
							id="links" aria-current="page" href="/GYM/pages/index.jsp">Inicio</a></li>
						<li class="nav-item"><a class="nav-link text-light active"
							id="links" href="/GYM/SvAbono">Planes</a></li>
						<li class="nav-item"><a class="nav-link text-light"
							id="links" href="#">Tienda</a></li>
						<li class="nav-item"><a class="nav-link text-light"
							id="links" href="#">Reservas</a></li>
						<li class="nav-item"><a class="nav-link text-light"
							id="links" href="/GYM/pages/sobreNosotros.jsp">Sobre Nosotros</a></li>
					</ul>
				</div>

				<div class="cajalogin">
					<a id="textoregistro" href="pages/signUp.jsp">Registrate</a> <a
						href="/GYM/pages/logIn.jsp"><button class="boton2">Iniciar
							Sesion</button></a>
				</div>

			</div>

		</nav>

	</header> 

	<div class="principal-box">

	
		<div class="contenido-box">
			<h2 class="bold">Elegi tu <span class="naranja">plan ideal</span></h2>
			<p>Entrena con nosotros eligiendo un plan. Todos incluyen las areas de cardio, peso integrado, peso libre, funcional, profesores de piso para evaluaciones y creacion de rutinas, vestidores y mas.</p>
		</div>

		<div class="planes-box">
			<% for (Abono i : listaAbonos) { %>
				<% if(i.getIdAbono() == 1) { %>
					<div class="tarjeta-plan">
						<img src="/GYM/img/plan-simple.png" alt="">
						<div class="descripcion-plan">
							<h2><span class="naranja">Plan</span><%=i.getNombreAbono()%></h2>
							<p>Desde $<%=i.getPrecio()%>/mes</p>
							<p><%=i.getCantReservas()%> clases mensuales</p>
							<button class="boton-linea">Incribirse</button>
						</div>
					</div>
				<% } %>

				<% if(i.getIdAbono() == 2) { %>
					<div class="tarjeta-plan">
						<img src="/GYM/img/plan-estandar.jpg" alt="">
						<div class="descripcion-plan">
							<h2><span class="naranja">Plan</span><%=i.getNombreAbono()%></h2>
							<p>Desde $<%=i.getPrecio()%>/mes</p>
							<p><%=i.getCantReservas()%> clases mensuales</p>
							<button class="boton-linea">Incribirse</button>
						</div>
					</div>
				<% } %>

				<% if(i.getIdAbono() == 3) { %>
					<div class="tarjeta-plan">
						<img src="/GYM/img/plan-premium.jpg" alt="">
						<div class="descripcion-plan">
							<h2><span class="naranja">Plan</span><%=i.getNombreAbono()%></h2>
							<p>Desde $<%=i.getPrecio()%>/mes</p>
							<p><%=i.getCantReservas()%> clases mensuales</p>
							<button class="boton-linea">Incribirse</button>
						</div>
					</div>
				<% } %>
				
				
			<% 
			}  %>
		</div>

	</div>
		


</body>

</html>