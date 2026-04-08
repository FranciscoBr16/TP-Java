<%@page import="entities.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Nueva Clase</title>

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


<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/listaUsaurios.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

<% Usuario user = (Usuario) session.getAttribute("user");

if (user == null || !user.isAdmin()) {
        response.sendRedirect("/GYM/pages/logIn.jsp");
        return; 
    }%>

</head>

 <header>
		<%
		    request.setAttribute("activePage", "reservas");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
	</header> 


<body>
    <div class="contenedor d-flex justify-content-center align-items-center" style="min-height: 80vh;">
        
        <div class="cajaModificar p-4 shadow-lg" style="background-color: #1e1c1d; border-radius: 14px; border: 1px solid #2e2b2c; width: 100%; max-width: 500px;">
            
            <div class="headerForm text-center mb-4">
                <h2 class="titulo text-white">Modifica la <span class="anaranjado" style="color: #d95126;">Actividad</span></h2>
                <div class="accent-line mx-auto"></div> </div>

            <hr class="border-secondary mb-4">

            <form action="/GYM/SvCambiarImagenActividad" method="POST" enctype="multipart/form-data">
                
                <div class="campoCentrado mb-4">
                    <label for="imagen" class="form-label text-light d-block mb-3">
                        <i class="bi bi-image me-2"></i>Selecciona la nueva imagen:
                    </label>
                    
                    <input type="file" name="imagen" id="imagen" class="form-control" 
                           style="background-color: #2a2728; border: 1px solid #3d3a3b; color: #ffffff;">
                </div>

                <div class="bottomForm text-center mt-5">
                    <button class="boton w-100" type="submit" style="margin: 0;">
                        Actualizar Imágen
                    </button>
                    
                    <a href="/GYM/SvActividades" class="justify-content-center" style="text-decoration: none; color:white;">
                        Cancelar
                    </a>
                </div>

            </form>
        </div>

    </div>
</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>