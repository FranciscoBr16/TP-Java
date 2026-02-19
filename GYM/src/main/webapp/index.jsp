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

        <% 
            String mensaje = (String) session.getAttribute("mensaje");
            String tipoMensaje = (String) session.getAttribute("tipoMensaje");
            if (mensaje != null) { 
                // Definimos el color según el tipo de mensaje (verde éxito, rojo error)
                String colorFondo = (tipoMensaje != null && tipoMensaje.equals("success")) ? "#28a745" : "#dc3545";
        %>
            <div id="mensajeAlerta" style="position: fixed; top: 80px; right: 20px; z-index: 1000; min-width: 300px; padding: 15px 20px; border-radius: 8px; background-color: <%= colorFondo %>; color: white; font-weight: bold; border: 2px solid #191617; box-shadow: 0 4px 12px rgba(0,0,0,0.2);">
                <button onclick="document.getElementById('mensajeAlerta').style.display='none'" style="background: transparent; border: none; color: white; font-size: 20px; cursor: pointer; float: right; margin-left: 15px; margin-top: -5px;">&times;</button>
                <%= mensaje %>
            </div>
            <script>
                // Ocultar automáticamente después de 5 segundos
                setTimeout(function() {
                    var msj = document.getElementById('mensajeAlerta');
                    if (msj) { msj.style.display = 'none'; }
                }, 5000);
            </script>
        <% 
                // Limpiamos la sesión para que el mensaje no vuelva a aparecer si recargan la página
                session.removeAttribute("mensaje");
                session.removeAttribute("tipoMensaje");
            } 
        %>

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