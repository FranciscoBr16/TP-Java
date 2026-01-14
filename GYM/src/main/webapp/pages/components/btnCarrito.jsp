<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="entities.ItemCarrito" %>

<%
    ArrayList<ItemCarrito> carrito =
        (ArrayList<ItemCarrito>) session.getAttribute("carrito");

    int totalItems = 0;

    if (carrito != null) {
        for (ItemCarrito item : carrito) {
            totalItems += item.getCantidad();
        }
    }
%>

<button 
    class="btn btn-outline-light position-relative"
    type="button"
    data-bs-toggle="offcanvas"
    data-bs-target="#offcanvasCarrito"
    style="margin-right: 10px">

    <i class="bi bi-cart3"></i>

    <% if (totalItems > 0) { %>
        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
            <%= totalItems %>
        </span>
    <% } %>
</button>
