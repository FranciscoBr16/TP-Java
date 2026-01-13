<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<button 
    class="btn btn-outline-light position-relative"
    type="button"
    data-bs-toggle="offcanvas"
    data-bs-target="#offcanvasCarrito"
    style="margin-right: 10px">


    <i class="bi bi-cart3"></i>

    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
        <%= session.getAttribute("cantidadCarrito") != null 
            ? session.getAttribute("cantidadCarrito") 
            : 0 %>
    </span>
</button>
