<%@page import="entities.Detalle_Factura"%>
<%@page import="entities.Factura"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Usuario"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<title>Mis Facturas</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="/GYM/style/estilosGenerales.css">
<link rel="stylesheet" href="/GYM/style/estilosGenerales2.css">
<link rel="stylesheet" href="/GYM/style/estilosMisFacturas.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">



<%
    Usuario user = (Usuario) session.getAttribute("user");
    ArrayList<Factura> facturas = (ArrayList<Factura>) request.getAttribute("facturas");
    Boolean esAdmin = (Boolean) user.isAdmin();
    if (esAdmin == null) esAdmin = false;
    
    String mensaje = (String) session.getAttribute("mensaje");
    String tipoMensaje = (String) session.getAttribute("tipoMensaje");
    session.removeAttribute("mensaje");
    session.removeAttribute("tipoMensaje");
    
    LocalDate hoy = LocalDate.now();
%>
</head>

<body>

<header>
    <%
        request.setAttribute("activePage", "none");
    %>
    <jsp:include page="/pages/components/navbar.jsp" />
</header>

<!-- Mensaje de confirmación -->
<% if (mensaje != null) { %>
    <div class="mensaje-alerta <%= tipoMensaje.equals("success") ? "mensaje-exito" : "mensaje-error" %>" id="mensajeAlerta">
        <button class="btn-cerrar-mensaje" onclick="cerrarMensaje()">&times;</button>
        <%= mensaje %>
    </div>
<% } %>

<div class="factura-container">


    <!-- Formulario de Filtros -->
    <form method="get" action="SvMisFacturas" class="filtros-factura">
        <div class="filtros-row">
            <!-- Buscar por N° Factura -->
            <div class="filtro-grupo">
                <label for="nroFactura">N° Factura</label>
                <input type="number" 
                       id="nroFactura"
                       name="nroFactura" 
                       class="filtro-input"
                       placeholder="Ingrese número"
                       value="<%= request.getParameter("nroFactura") != null ? request.getParameter("nroFactura") : "" %>">
            </div>

            <!-- Estado -->
            <div class="filtro-grupo">
                <label for="estado">Estado</label>
                <select name="estado" id="estado" class="filtro-select">
                    <option value="">Todas</option>
                    <option value="Pendiente de pago">Pendiente de pago</option>
                    <option value="Pagada">Pagada</option>
                    <option value="Rechazada">Rechazada</option>
                </select>
            </div>

            <!-- Orden Fecha -->
            <div class="filtro-grupo">
                <label for="ordenFecha">Orden por fecha</label>
                <select name="ordenFecha" id="ordenFecha" class="filtro-select">
                    <option value="">Por defecto</option>
                    <option value="asc">Más antiguas</option>
                    <option value="desc">Más recientes</option>
                </select>
            </div>

            <!-- Botón -->
            <div class="filtro-grupo">
                <button type="submit" class="boton3">
                    <i class="bi bi-funnel"></i> Filtrar
                </button>
            </div>
        </div>
    </form>

    <!-- Tabla de Facturas -->
    <% if (facturas != null && !facturas.isEmpty()) { %>

    <div class="tabla-facturas">
        <table>
            <thead>
                <tr>
                    <th style="width: 50px;"></th>
                    <th>N° Factura</th>
                    <th>Fecha</th>
                    <% if (esAdmin) { %>
                        <th>DNI Cliente</th>
                    <% } %>
                    <th>Total</th>
                    <th>Estado</th>
                    <th style="text-align: center;">Acciones</th>
                </tr>
            </thead>
            <tbody>

            <% 
            for (Factura f : facturas) { 
                long diasVencimiento = 0;
                boolean esVencida = false;
                if (f.getEstado().equalsIgnoreCase("Pendiente de pago") && f.getFecha() != null) {
                    diasVencimiento = ChronoUnit.DAYS.between(f.getFecha(), hoy);
                    esVencida = diasVencimiento > 4;
                }
            %>

                <!-- FILA FACTURA -->
                <tr class="<%= esVencida ? "factura-vencida" : "" %>">
                    <td style="text-align: center;">
                        <button class="btn-expandir"
                                type="button"
                                data-bs-toggle="collapse"
                                data-bs-target="#detalles-<%= f.getNroFactura() %>"
                                aria-expanded="false">
                            <i class="bi bi-chevron-down"></i>
                        </button>
                    </td>

                    <td><strong>#<%= f.getNroFactura() %></strong></td>
                    <td><%= f.getFecha() %></td>
                    <% if (esAdmin) { %>
                        <td><%= f.getDNI() %></td>
                    <% } %>
                    <td><strong>$ <%= String.format("%.2f", f.getTotal()) %></strong></td>

                    <td>
                        <% if (f.getEstado().equalsIgnoreCase("Pagada")) { %>
                            <span class="estado-badge estado-pagada">
                                <i class="bi bi-check-circle"></i> Pagada
                            </span>
                        <% } else if (f.getEstado().equalsIgnoreCase("Pendiente de pago")) { %>
                            <span class="estado-badge estado-pendiente">
                                <i class="bi bi-clock"></i> Pendiente
                                <% if (diasVencimiento >= 0 && diasVencimiento <= 4) { %>
                                    <span class="contador-dias">(Día <%= diasVencimiento %>/4)</span>
                                <% } %>
                            </span>
                        <% } else if (f.getEstado().equalsIgnoreCase("Rechazada")) { %>
                            <span class="estado-badge estado-rechazada">
                                <i class="bi bi-x-circle"></i> Rechazada
                            </span>
                        <% } else { %>
                            <span class="estado-badge" style="background-color: #6c757d; color: white;">
                                <%= f.getEstado() %>
                            </span>
                        <% } %>
                    </td>

                    <!-- ACCIONES -->
                    <td style="text-align: center;">
                        <% if (esAdmin && f.getEstado().equalsIgnoreCase("Pendiente de pago")) { %>
                            <form action="<%= request.getContextPath() %>/SvMisFacturas" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="confirmarPago">
                                <input type="hidden" name="nroFactura" value="<%= f.getNroFactura() %>">
                                <button type="submit" 
                                        class="btn-confirmar-pago"
                                        onclick="return confirm('¿Confirmar el pago de la factura #<%= f.getNroFactura() %>?')">
                                    <i class="bi bi-check-lg"></i> Confirmar Pago
                                </button>
                            </form>
                        <% } else { %>
                            <span style="color: #999;">—</span>
                        <% } %>
                    </td>
                </tr>

                <!-- FILA DETALLES -->
                <tr class="collapse fila-detalles" id="detalles-<%= f.getNroFactura() %>">
                    <td colspan="<%= esAdmin ? "7" : "6" %>">
                        <div class="detalles-content">
                            <div class="detalles-titulo">
                                <i class="bi bi-box-seam"></i>
                                <span>Detalle de Productos</span>
                            </div>

                            <% if (f.getDetalles() != null && !f.getDetalles().isEmpty()) { %>
                                <% for (Detalle_Factura df : f.getDetalles()) { %>

                                    <div class="producto-detalle">
                                        <!-- Imagen -->
                                        <% if (df.getProducto() != null && df.getProducto().getImagen() != null) { %>
                                            <img src="<%= df.getProducto().getImagen() %>"
                                                 alt="<%= df.getProducto().getNombre() %>"
                                                 class="producto-imagen">
                                        <% } else { %>
                                            <div class="producto-imagen-placeholder">
                                                <i class="bi bi-image"></i>
                                            </div>
                                        <% } %>

                                        <!-- Información -->
                                        <div class="producto-info">
                                            <div class="producto-nombre">
                                                <%= df.getProducto() != null ? df.getProducto().getNombre() : "Producto #" + df.getIdProducto() %>
                                            </div>
                                            <% if (df.getProducto() != null && df.getProducto().getDescripcion() != null) { %>
                                                <div class="producto-descripcion">
                                                    <%= df.getProducto().getDescripcion() %>
                                                </div>
                                            <% } %>
                                            <span class="producto-cantidad">
                                                Cantidad: <%= df.getCantidad() %>
                                            </span>
                                        </div>

                                        <!-- Precios -->
                                        <div class="producto-precios">
                                            <div class="precio-unitario">
                                                Precio unitario: $ <%= String.format("%.2f", df.getSubTotal() / df.getCantidad()) %>
                                            </div>
                                            <div class="precio-subtotal">
                                                $ <%= String.format("%.2f", df.getSubTotal()) %>
                                            </div>
                                        </div>
                                    </div>

                                <% } %>
                                
                                <!-- Total -->
                                <div class="total-factura">
                                    <span class="total-factura-label">Total: </span>
                                    <span class="total-factura-monto">$ <%= String.format("%.2f", f.getTotal()) %></span>
                                </div>
                                
                            <% } else { %>
                                <p style="color: #999; text-align: center; padding: 20px;">
                                    Esta factura no tiene productos registrados.
                                </p>
                            <% } %>
                        </div>
                    </td>
                </tr>

            <% } %>

            </tbody>
        </table>
    </div>

    <% } else { %>

    <div class="sin-facturas">
        <i class="bi bi-receipt"></i>
        <h4>
            <% if (esAdmin) { %>
                No hay facturas registradas en el sistema
            <% } else { %>
                No has realizado ninguna compra
            <% } %>
        </h4>
    </div>

    <% } %>

</div>

<script>
// Auto-cerrar mensaje después de 5 segundos
setTimeout(function() {
    var mensaje = document.getElementById('mensajeAlerta');
    if (mensaje) {
        mensaje.style.animation = 'slideIn 0.3s ease-out reverse';
        setTimeout(function() {
            mensaje.style.display = 'none';
        }, 300);
    }
}, 5000);

function cerrarMensaje() {
    var mensaje = document.getElementById('mensajeAlerta');
    if (mensaje) {
        mensaje.style.display = 'none';
    }
}
</script>

<jsp:include page="/pages/components/carrito.jsp" />
</body>
</html>
