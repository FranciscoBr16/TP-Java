<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="entities.Usuario" %>

<%
    Usuario user = (Usuario) session.getAttribute("user");
%>



<!-- Barra lateral (Offcanvas izquierda) -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasCarrito">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title">Tu carrito</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
    </div>

    <div class="offcanvas-body">

        <!-- Contenido del carrito -->
        <div id="contenidoCarrito">
            <p class="text-muted">El carrito está vacío</p>
        </div>

        <hr>

        <div class="d-grid gap-2">
            <a href="/GYM/SvCarrito" class="btn btn-primary">
                Ver carrito
            </a>

            <button class="btn btn-secondary" data-bs-dismiss="offcanvas">
                Cerrar
            </button>
        </div>

    </div>
</div>

