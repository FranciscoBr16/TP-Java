<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entities.ItemCarrito" %>
<%@ page import="entities.Usuario" %>

<%
    Usuario user = (Usuario) session.getAttribute("user");
    ArrayList<ItemCarrito> carrito =
        (ArrayList<ItemCarrito>) session.getAttribute("carrito");
    Double total = (Double) request.getAttribute("total");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Confirmar Compra</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <link rel="stylesheet" href="/GYM/style/estilosGenerales.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>

<body>

<header>
    <%
        request.setAttribute("activePage", "tienda");
    %>
    <jsp:include page="/pages/components/navbar.jsp" />
</header>

<div class="container mt-5">

    <h2 class="mb-4 text-center">Confirmar compra</h2>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger text-center">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <div class="card p-3 mb-4">

        <% for (ItemCarrito item : carrito) { %>
            <div class="d-flex align-items-center border-bottom py-3">
                <img src="<%= item.getImagen() %>" width="70">

                <div class="ms-3 flex-grow-1">
                    <strong><%= item.getNombre() %></strong><br>
                    Precio unitario: $<%= item.getPrecio() %><br>
                    Cantidad: <%= item.getCantidad() %>
                </div>

                <div class="fw-bold">
                    $<%= item.getCantidad() * item.getPrecio() %>
                </div>
            </div>
        <% } %>

        <div class="d-flex justify-content-end mt-4">
            <h4>Total: $<%= total %></h4>
        </div>
    </div>

    <div class="d-flex justify-content-between">

        <form action="/GYM/SvCancelarCompra" method="post">
            <button class="btn btn-outline-danger">
                Cancelar compra
            </button>
        </form>


        <form action="/GYM/SvConfirmarCompra" method="post">
            <button class="btn btn-success">
                Confirmar compra
            </button>
        </form>
    </div>

</div>

</body>
</html>
