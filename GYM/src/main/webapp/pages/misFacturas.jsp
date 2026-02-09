<%@page import="entities.Detalle_Factura"%>
<%@page import="entities.Factura"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<title>Mis Facturas</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="/GYM/style/estilosGenerales.css">
<link rel="stylesheet" href="/GYM/style/estilosGenerales2.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<%
    Usuario user = (Usuario) session.getAttribute("user");
    ArrayList<Factura> facturas = (ArrayList<Factura>) request.getAttribute("facturas");
%>
</head>

<body>

<header>
    <jsp:include page="/pages/components/navbar.jsp" />
</header>

<div class="container mt-4">

<% if (facturas != null && !facturas.isEmpty()) { %>

<table class="table table-bordered align-middle">
    <thead class="table-dark">
        <tr>
            <th></th>
            <th>N° Factura</th>
            <th>Fecha</th>
            <th>Total</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>

    <% for (Factura f : facturas) { %>

        <!-- FILA FACTURA -->
        <tr>
            <td class="text-center">
                <button class="btn btn-sm btn-outline-secondary"
                        data-bs-toggle="collapse"
                        data-bs-target="#detalles-<%=f.getNroFactura()%>">
                    <i class="bi bi-chevron-down"></i>
                </button>
            </td>

            <td><%= f.getNroFactura() %></td>
            <td><%= f.getFecha() %></td>
            <td>$ <%= f.getTotal() %></td>

            <td>
                <span class="badge
                    <%= f.getEstado().equalsIgnoreCase("Pendiente de pago")
                        ? "bg-warning text-dark"
                        : "bg-success" %>">
                    <%= f.getEstado() %>
                </span>
            </td>

            <!-- ACCIONES -->
            <td class="text-center">
                <% if (user != null && user.isAdmin()
                        && f.getEstado().equalsIgnoreCase("Pendiente de pago")) { %>

                    <form action="SvConfirmarPago" method="post" class="d-inline">
                        <input type="hidden" name="nroFactura" value="<%= f.getNroFactura() %>">
                        <button type="submit" class="btn btn-sm btn-success">
                            <i class="bi bi-check-circle"></i> Confirmar pago
                        </button>
                    </form>

                <% } else { %>
                    <span class="text-muted">—</span>
                <% } %>
            </td>
        </tr>

        <!-- FILA DETALLES -->
        <tr class="collapse bg-light" id="detalles-<%=f.getNroFactura()%>">
            <td colspan="6">
                <div class="p-3">

                <% if (f.getDetalles() != null && !f.getDetalles().isEmpty()) { %>
                    <% for (Detalle_Factura df : f.getDetalles()) { %>

                        <div class="d-flex align-items-center border-bottom py-2">
                            <img src="<%= df.getProducto().getImagen() %>"
                                 width="70"
                                 class="me-3 rounded">

                            <div class="flex-grow-1">
                                <strong><%= df.getProducto().getNombre() %></strong><br>
                                Cantidad: <%= df.getCantidad() %>
                            </div>

                            <div class="fw-bold">
                                $ <%= df.getSubTotal() %>
                            </div>
                        </div>

                    <% } %>
                <% } else { %>
                    <p class="text-muted">Esta factura no tiene productos.</p>
                <% } %>

                </div>
            </td>
        </tr>

    <% } %>

    </tbody>
</table>

<% } else { %>

<div class="text-center mt-5">
    <h4>No hay facturas para mostrar</h4>
</div>

<% } %>

</div>

</body>
</html>
