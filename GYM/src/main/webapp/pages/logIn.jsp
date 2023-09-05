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
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@347&display=swap" rel="stylesheet">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous">
  </script>
  <link rel="stylesheet" href="../style/styleLogIn.css" />
</head>

<body>
  <header>
    <nav class="navbar navbar-expand-lg ">
      <div class="container-fluid">
        <a class="navbar-brand" href="../index.jsp"><img src="../img/logo.png" alt="logo del gimnasio"></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
          aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item">
              <a class="nav-link text-light active" id="links" aria-current="page" href="../index.jsp">Inicio</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-light" id="links" href="#">Planes</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-light" id="links" href="#">Tienda</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-light" id="links" href="#">Reservas</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-light" id="links" href="#">Sobre Nosotros</a>
            </li>
          </ul>
        </div>
        <div class="cajalogin">
          <a id="textoregistro" href="signUp.jsp">Registrate</a>
          <a href="logIn.jsp"><button class="btn nuestroboton">Iniciar Sesion</button></a>
        </div>
      </div>
    </nav>
  </header>
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-12 col-sm-4 rounded " id="cartalogin">
        <div class="inicia text-center">
          <p>Iniciar Sesi�n</p>
        </div>
        
        <form>
          <div class="inputs" method="POST" action="SvLogIn.java">
            <label for="username"><b>Usuario</b></label>
            <input type="text" id="username" name="usuario" required class="form-control">
          </div>
          <div class="inputs">
            <label for="password"><b>Contrase�a</b></label>
            <input type="password" id="password" name="clave" required class="form-control">
          </div>
          <div class="text-center botonabajo">
            <button id="botonsesion" type="submit" class="btn">Iniciar Sesion</button>
          </div>

        </form>
      </div>
    </div>
  </div>
</body>

</html>