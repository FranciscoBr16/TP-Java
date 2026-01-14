<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="entities.Usuario" %>
<%@ page import="entities.ItemCarrito" %>
<%@page import="java.util.ArrayList"%>

<%
    Usuario user = (Usuario) session.getAttribute("user");
%>
<%
    ArrayList<ItemCarrito> carrito = 
        (ArrayList<ItemCarrito>) session.getAttribute("carrito");
%>
<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasCarrito">
    
    <div class="offcanvas-header border-bottom">
        <h5 class="offcanvas-title">Tu carrito</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
    </div>

    <!-- BODY CON SCROLL -->
    <div class="offcanvas-body d-flex flex-column p-3" style="overflow-y:auto;">
    	<%
		    double total = 0;
		
		    if (carrito != null) {
		        for (ItemCarrito item : carrito) {
		            total += item.getPrecio() * item.getCantidad();
		        }
		    }
		%>
    	

        <% if (carrito == null || carrito.isEmpty()) { %>

            <p class="text-muted text-center mt-3">
                El carrito está vacío
            </p>

        <% } else { %>

            <% for (ItemCarrito item : carrito) { %>

            <!-- PRODUCTO -->
            <div class="card mb-3 shadow-sm">
                <div class="card-body p-2">

                    <div class="d-flex align-items-center">

                        <img src="<%= item.getImagen() %>" width="60" class="me-2">

                        <div class="flex-grow-1">
                            <strong><%= item.getNombre() %></strong>
                            <p class="mb-1">$<%= item.getPrecio() %></p>
                        </div>

                        <div class="d-flex align-items-center">

                            <!-- Restar -->
                            <form action="/GYM/SvCarrito" method="post">
                                <input type="hidden" name="accion" value="restar">
                                <input type="hidden" name="idProducto" value="<%= item.getIdProducto() %>">
                                <button class="btn btn-sm btn-outline-secondary">-</button>
                            </form>

                            <span class="mx-2"><%= item.getCantidad() %></span>

                            <!-- Sumar -->
                            <form action="/GYM/SvCarrito" method="post">
                                <input type="hidden" name="accion" value="sumar">
                                <input type="hidden" name="idProducto" value="<%= item.getIdProducto() %>">
                                <button class="btn btn-sm btn-outline-secondary">+</button>
                            </form>

                            <!-- Eliminar -->
                            <form action="/GYM/SvCarrito" method="post">
                                <input type="hidden" name="accion" value="eliminar">
                                <input type="hidden" name="idProducto" value="<%= item.getIdProducto() %>">
                                <button class="btn btn-sm btn-danger ms-2">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </form>

                        </div>
                    </div>

                </div>
            </div>

            <% } %>

        <% } %>

    </div>

    <!-- FOOTER FIJO -->
    <div class="offcanvas-footer p-3 border-top">

    <% if (carrito != null && !carrito.isEmpty()) { %>

        <div class="d-flex justify-content-between mb-2">
            <strong>Total:</strong>
            <strong>$<%= total %></strong>
        </div>

        <form action="/GYM/SvConfirmarCompra" method="get">
            <button class="btn boton w-100">
                Finalizar compra
            </button>
        </form>

    <% } %>

</div>


</div>

