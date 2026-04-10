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

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />


<%
    Usuario user = (Usuario) session.getAttribute("user");
    ArrayList<Factura> facturas = (ArrayList<Factura>) request.getAttribute("facturas");
    Boolean esAdmin = user != null && user.isAdmin();
    
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
        request.setAttribute("activePage","facturas");
    %>
    <jsp:include page="/pages/components/navbar.jsp" />
</header>

<% if (mensaje != null) { %>
    <div class="mensaje-alerta <%= tipoMensaje != null && tipoMensaje.equals("success") ? "mensaje-exito" : "mensaje-error" %>" id="mensajeAlerta">
        <button class="btn-cerrar-mensaje" onclick="cerrarMensaje()">&times;</button>
        <%= mensaje %>
    </div>
<% } %>

<div class="factura-container">

    <div class="factura-header">
        <i class="bi <%= esAdmin ? "bi-receipt-cutoff" : "bi-receipt" %>"></i>
        <h2 style = "color:white;"><%= esAdmin ? "Todas las Facturas (Administrador)" : "Mis Facturas" %></h2>
    </div>

    <form method="get" action="SvMisFacturas" class="filtros-factura">
        <div class="filtros-row">
            <div class="filtro-grupo">
                <label for="nro">N° Factura</label>
                <input type="number" 
                       id="nro"
                       name="nro" 
                       class="filtro-input"
                       placeholder="Ingrese número"
                       value="<%= request.getAttribute("nro") != null ? request.getAttribute("nro") : "" %>">
            </div>

            <% if (esAdmin) { %>
            <div class="filtro-grupo">
                <label for="dniCliente">DNI Cliente</label>
                <input type="number" 
                       id="dniCliente"
                       name="dniCliente" 
                       class="filtro-input"
                       placeholder="Buscar DNI"
                       value="<%= request.getAttribute("dniCliente") != null ? request.getAttribute("dniCliente") : "" %>">
            </div>
            <% } %>

            <div class="filtro-grupo">
                <label for="estado">Estado</label>
                <select name="estado" id="estado" class="filtro-select">
                    <option value="">Todas</option>
                    <option value="Pendiente de pago" <%= "Pendiente de pago".equals(request.getAttribute("estado")) ? "selected" : "" %>>Pendiente de pago</option>
                    <option value="Pagada" <%= "Pagada".equals(request.getAttribute("estado")) ? "selected" : "" %>>Pagada</option>
                    <option value="Rechazada" <%= "Rechazada".equals(request.getAttribute("estado")) ? "selected" : "" %>>Rechazada</option>
                </select>
            </div>

            <div class="filtro-grupo">
                <label for="orden">Orden por fecha</label>
                <select name="orden" id="orden" class="filtro-select">
                    <option value="">Por defecto</option>
                    <option value="asc" <%= "asc".equals(request.getAttribute("orden")) ? "selected" : "" %>>Más antiguas</option>
                    <option value="desc" <%= "desc".equals(request.getAttribute("orden")) ? "selected" : "" %>>Más recientes</option>
                </select>
            </div>

            <div class="filtro-grupo">
                <button type="submit" class="boton3">
                    <i class="bi bi-funnel"></i> Filtrar
                </button>
            </div>
        </div>
    </form>

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
                if (f.getEstado() != null && f.getEstado().equalsIgnoreCase("Pendiente de pago") && f.getFecha() != null) {
                    diasVencimiento = ChronoUnit.DAYS.between(f.getFecha(), hoy);
                    esVencida = diasVencimiento > 4;
                }
            %>

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
                    <td><%= f.getFecha() != null ? f.getFecha() : "N/A" %></td>
                    <% if (esAdmin) { %>
                        <td><%= f.getDNI() != null ? f.getDNI() : "N/A" %></td>
                    <% } %>
                    <td><strong>$ <%= String.format("%.2f", f.getTotal()) %></strong></td>

                    <td>
                        <% if (f.getEstado() != null && f.getEstado().equalsIgnoreCase("Pagada")) { %>
                            <span class="estado-badge estado-pagada">
                                <i class="bi bi-check-circle"></i> Pagada
                            </span>
                        <% } else if (f.getEstado() != null && f.getEstado().equalsIgnoreCase("Pendiente de pago")) { %>
                            <span class="estado-badge estado-pendiente">
                                <i class="bi bi-clock"></i> Pendiente
                                <% if (diasVencimiento >= 0 && diasVencimiento <= 4) { %>
                                    <span class="contador-dias">(Día <%= diasVencimiento %>/4)</span>
                                <% } %>
                            </span>
                        <% } else if (f.getEstado() != null && f.getEstado().equalsIgnoreCase("Rechazada")) { %>
                            <span class="estado-badge estado-rechazada">
                                <i class="bi bi-x-circle"></i> Rechazada
                            </span>
                        <% } else { %>
                            <span class="estado-badge" style="background-color: #6c757d; color: white;">
                                <%= f.getEstado() != null ? f.getEstado() : "N/A" %>
                            </span>
                        <% } %>
                    </td>

                    <td style="text-align: center;">
					    <% if (esAdmin && f.getEstado() != null && f.getEstado().equalsIgnoreCase("Pendiente de pago")) { %>
					        <form action="SvConfirmarPago" method="post" style="display:inline;">
					            <input type="hidden" name="action" value="confirmarPago">
					            <input type="hidden" name="nroFactura" value="<%= f.getNroFactura() %>">
					            <button type="submit" class="btn-confirmar-pago"
					                    onclick="return confirm('¿Confirmar el pago de la factura #<%= f.getNroFactura() %>?')">
					                <i class="bi bi-check-lg"></i> Confirmar Pago
					            </button>
					        </form>
					
					    <% } else if (!esAdmin && f.getEstado() != null && f.getEstado().equalsIgnoreCase("Pendiente de pago")) { %>
					        <%-- Botón cancelar para usuarios --%>
					        <form action="SvCancelarFactura" method="post" style="display:inline;">
					            <input type="hidden" name="nroFactura" value="<%= f.getNroFactura() %>">
					            <button type="submit" class="boton3"
					                    style="background-color:#c0392b; border-color:#c0392b;"
					                    onclick="return confirm('¿Cancelar la factura #<%= f.getNroFactura() %>? Esta acción no se puede deshacer.')">
					                <i class="bi bi-x-lg"></i> Cancelar
					            </button>
					        </form>
					
					    <% } else { %>
					        <span style="color: #999;">—</span>
					    <% } %>
					</td>
                </tr>

                <tr class="collapse fila-detalles" id="detalles-<%= f.getNroFactura() %>">
                    <td colspan="<%= esAdmin ? "7" : "6" %>">
                        <div class="detalles-content">
                            <div class="detalles-titulo">
                                <i class="bi bi-box-seam"></i>
                                <span>Detalle de Productos y Abonos</span>
                            </div>

                            <% if (f.getDetalles() != null && !f.getDetalles().isEmpty()) { %>
                                <% for (Detalle_Factura df : f.getDetalles()) { 
                                    boolean esProducto = (df.getProducto() != null);
                                    boolean esAbono = (df.getAbono() != null);
                                %>
                                    <div class="producto-detalle">
                                        <% if (esProducto && df.getProducto().getImagen() != null) { %>
                                            <img src="<%= df.getProducto().getImagen() %>"
                                                 alt="<%= df.getProducto().getNombre() %>"
                                                 class="producto-imagen">
                                        <% } else if (esAbono && df.getAbono().getImagen() != null) { %>
                                            <img src="<%= df.getAbono().getImagen() %>"
                                                 alt="<%= df.getAbono().getNombreAbono() %>"
                                                 class="producto-imagen">
                                        <% } else { %>
                                            <div class="producto-imagen-placeholder">
                                                <i class="bi bi-<%= esAbono ? "calendar-check" : "box" %>"></i>
                                            </div>
                                        <% } %>

                                        <div class="producto-info">
                                            <div class="producto-nombre">
                                                <% if (esProducto) { %>
                                                    <%= df.getProducto().getNombre() %>
                                                    <span class="tipo-badge tipo-producto">PRODUCTO</span>
                                                <% } else if (esAbono) { %>
                                                    <%= df.getAbono().getNombreAbono() %>
                                                    <span class="tipo-badge tipo-abono">ABONO</span>
                                                <% } else { %>
                                                    Item #<%= df.getNroFactura() %>
                                                <% } %>
                                            </div>
                                            
                                            <% if (esProducto && df.getProducto().getDescripcion() != null) { %>
                                                <div class="producto-descripcion">
                                                    <%= df.getProducto().getDescripcion() %>
                                                </div>
                                            <% } else if (esAbono && df.getAbono().getDescripcion() != null) { %>
                                                <div class="producto-descripcion">
                                                    <%= df.getAbono().getDescripcion() %>
                                                </div>
                                            <% } %>
                                            
                                            <% if (esProducto) { %>
                                                <span class="producto-cantidad">
                                                    Cantidad: <%= df.getCantidad() %>
                                                </span>
                                            <% } %>
                                        </div>

                                        <div class="producto-precios">
                                            <% if (esProducto && df.getCantidad() > 0) { %>
                                                <div class="precio-unitario">
                                                    Precio unitario: $ <%= String.format("%.2f", df.getSubTotal() / df.getCantidad()) %>
                                                </div>
                                            <% } %>
                                            <div class="precio-subtotal">
                                                $ <%= String.format("%.2f", df.getSubTotal()) %>
                                            </div>
                                        </div>
                                    </div>
                                <% } %>
                                
                                <div class="total-factura">
                                    <span class="total-factura-label">Total: </span>
                                    <span class="total-factura-monto">$ <%= String.format("%.2f", f.getTotal()) %></span>
                                </div>
                            <% } else { %>
                                <p style="color: #999; text-align: center; padding: 20px;">
                                    Esta factura no tiene productos ni abonos registrados.
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