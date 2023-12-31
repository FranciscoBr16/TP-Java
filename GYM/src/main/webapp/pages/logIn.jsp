<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Log In</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@347&display=swap"
	rel="stylesheet">

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

<link rel="stylesheet" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" href="/GYM/style/estilosGenerales2.css" />
<link rel="stylesheet" href="/GYM/style/usuLogInEstilos.css" />

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />
</head>

<body>
	<header>
		<nav class="navbar navbar-expand-lg">
			<div class="container-fluid">
				<a class="navbar-brand" href="../index.jsp"><img
					src="/GYM/img/logo.png" alt="logo del gimnasio"></a>
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
                                <a class="nav-link text-light" id="links" href="/GYM/SvEmpleados" >Sobre Nosotros</a>
                            </li>
                        </ul>
				</div>
				<div class="cajalogin">
					<a id="textoregistro" href="signUp.jsp">Registrate</a> <a
						href="logIn.jsp"><button class="boton2">Iniciar
							Sesi�n</button></a>
				</div>
			</div>
		</nav>
	</header>

	<div class="contenedor">
		<div class="tarjetaLogin">
			<div class="inicia">
				<p>Iniciar Sesi�n</p>
			</div>
			<form action="/GYM/SvLogIn" method="POST">
				<div class="inputs">
					<label for="username">DNI</label> <input type="text" id="username"
						name="dni" required class="form-control">
				</div>
				<div class="inputs">
					<label for="password">Contrase�a</label> <input type="password"
						id="password" name="password" required class="form-control">
				</div>
				<div class="final">
					<a><button  type="submit" class="boton">Iniciar Sesi�n</button> </a>
				</div>

			</form>

		</div>
	</div>

</body>

</html>