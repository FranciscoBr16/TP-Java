<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Modificar Imagen Producto</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
    <link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />
    <link rel="stylesheet" type="text/css" href="/GYM/style/formularioEstilos.css" />
    <link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />

    <% Usuario user = (Usuario) session.getAttribute("user"); 
    
    if (user == null || !user.isAdmin()) {
        response.sendRedirect("/GYM/pages/logIn.jsp");
        return; 
    }%>
</head>

<header>
    <% request.setAttribute("activePage", "tienda"); %>
    <jsp:include page="/pages/components/navbar.jsp" />
</header>

<body>
    <div class="contenedor d-flex justify-content-center align-items-center" style="min-height: 80vh;">
        <div class="formulario p-4 shadow-lg" style="background-color: #1e1c1d; border-radius: 14px; border: 1px solid #2e2b2c; width: 100%; max-width: 500px;">
            
            <div class="headerForm text-center mb-4">
                <p class="titulo text-white">Modifica el <span class="anaranjado" style="color: #d95126;">Producto</span></p>
                <div class="accent-line mx-auto" style="height: 4px; width: 60px; background: #d95126; border-radius: 4px;"></div>
            </div>
            
            <hr class="border-secondary">

            <form action="/GYM/SvCambiarImagenProducto" method="POST" enctype="multipart/form-data">
                <div class="campoCentrado mb-4">
                    <label for="imagen" class="form-label text-light d-block mb-3">
                        <i class="bi bi-camera me-2"></i>Nueva imagen del producto:
                    </label>
                    <input type="file" name="imagen" class="form-control" 
                           style="background-color: #2a2728; border: 1px solid #3d3a3b; color: #ffffff;" required>
                </div>

                <div class="bottomForm text-center mt-4">
                    <button class="boton w-100" type="submit" style="margin: 0;">
                        <i class="bi bi-cloud-arrow-up-fill me-2"></i>Guardar Cambios
                    </button>
                    <a href="/GYM/SvProductos" class="btn-limpiar mt-3 w-100 justify-content-center" style="text-decoration: none; display: flex;">
                        Cancelar
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>