<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%> <%@ page import="entities.Usuario"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Inicio</title>

        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@347&display=swap" rel="stylesheet" />

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" 
        	rel="stylesheet" 
        	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
            crossorigin="anonymous"
        />
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
            crossorigin="anonymous"
        ></script>

        <link rel="shortcut icon" href="img/logo.ico" type="image/x-icon" />
        
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link rel="stylesheet" href="/GYM/style/indexEstilos.css" />
        <link rel="stylesheet" href="/GYM/style/estilosGenerales.css" />

        <% Usuario user = (Usuario) session.getAttribute("user");%>
    </head>

    <body>
        <header>
		<%
		    request.setAttribute("activePage", "inicio");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
	</header> 
        <div class="caja">
            <a class="caja1" href="/GYM/pages/reservas.jsp">
                <p>ENTRENA</p>
            </a>
            <a class="caja2" href="/GYM/SvProductos">
                <p>COMPRA</p>
            </a>
            <a class="caja3" href="/GYM/SvEmpleados">
                <p>CONOCENOS</p>
            </a>
        </div>
        
    </body>
    <jsp:include page="/pages/components/carrito.jsp" />
</html>
