<%@page import="java.util.ArrayList"%>
<%@page import="entities.Empleado"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>Sobre Nosotros</title>

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
<link rel="stylesheet" href="/GYM/style/empleadosEstilos.css">
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />
<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />
<% Usuario user = (Usuario) session.getAttribute("user");
ArrayList<Empleado> listaEmpleado = (ArrayList<Empleado>)request.getAttribute("empleados");
%>
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
                            <li class="nav-item">
                                <a class="nav-link text-light" id="links" aria-current="page" href="/GYM/index.jsp">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-light" id="links" href="/GYM/SvAbono">Planes</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-light" id="links" href="/GYM/SvProductos" >Tienda</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-light" id="links" href="/GYM/pages/reservas.jsp" >Reservas</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-light active" id="links" href="/GYM/SvEmpleados" >Sobre Nosotros</a>
                            </li>
                        </ul>
				</div>

				<% if (user == null){ %>
                    <div class="cajalogin">
                        <a id="textoregistro" href="pages/signUp.jsp">Registrate</a>
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


    <div class="contenedor">
        
        <div class="caja">
        
        	<div class="titulo"><span>¿Quiénes Somos?</span></div>
        	<div class="descripcion"><span>Valhalla es un club de entrenamiento donde el concepto de lo social adquiere valor a través de lo deportivo.</span> 
        							<br>
        							<span>Para nosotros es muy importante que te diviertas mientras entrenas, para ello conformamos un equipo humano entusiasta y profesional acorde a cada necesidad.</span>
        	</div>
        	
        </div>
        
        <div class="caja">
        	<div class="titulo"><p>Nuestro Equipo</p></div>
        	<div class="descripcion">
        		<p>Conocé un poco más al equipo de Valhalla, ellos te ayudarán a llegar a donde te lo propongas.</p>
        	</div>
        		<div class="tarjetasEmpelado">
       		 <% for (Empleado emp : listaEmpleado){ %>
        		<div class="cajaEmpleado">
        			<div class="contenedorImg">
        				<img class="imagen" src="<%=emp.getImagen()%>">
        			</div>
        			<div class="nombre">
        				<p><%=emp.getNombre()%> <%=emp.getApellido()%></p>
        			</div>
        			<div class="correo">
        				<p><%=emp.getCorreo()%></p>
        			</div>
        			<div class="rol">
        				<p><%=emp.getRol()%> </p>
        			</div>
        			
        			<% if (user != null){ if(user.isAdmin()){ %>
                   		<div class="botones">
							<form action="/GYM/SvModificarEmpleado" method="GET">
								<input type="hidden" name="id" value="<%=emp.getIdEmpleado()%>">
								<button type="submit" class="boton3">Modificar</button>
							</form>
							<form action="/GYM/SvBajaEmpleado" method="POST">
								<input type="hidden" name="id" value="<%=emp.getIdEmpleado()%>">
								<button type="submit" class="boton4">Dar de Baja</button>
							</form>
                   		</div>
                  
                    <%} }%>
        	
        		</div>
        
        		<%} %>
        		</div>
        		<% if (user != null){ if(user.isAdmin()){ %>
        		<div>
        		<a href="/GYM/pages/altaEmpleado.jsp"> <button class="boton">Nuevo Empleado</button> </a>
        		</div>
        		<%} }%>
        
        </div>
        
    </div>

</body>

</html>