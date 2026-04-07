<%@page import="entities.Clase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Empleado"%>
<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Modificar Salon</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="/GYM/style/estilosGenerales.css"/>
<link rel="stylesheet" href="/GYM/style/estilosGenerales2.css"/>
<link rel="stylesheet" href="/GYM/style/listaUsuarios.css"/>
<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon"/>

<style>
  select {
    background-color: #2a2728; border: 1px solid #3d3a3b;
    color: #ffffff; border-radius: 8px; padding: 8px 14px;
    font-size: 15px; width: 100%; transition: border-color 150ms;
  }
  select:focus { outline: none; border-color: #d95126; }
</style>

<% Usuario user = (Usuario) session.getAttribute("user"); %>
<% Clase cla = (Clase) request.getAttribute("clase"); %>
</head>

<header>
  <% request.setAttribute("activePage", "reservas"); %>
  <jsp:include page="/pages/components/navbar.jsp" />
</header>

<body>

  <div class="page-wrapper">
    <div class="row justify-content-center">
      <div class="col-lg-6 col-md-8">


        <div class="d-flex align-items-center gap-3 mb-4">
          <div class="avatar-iniciales" style="width:52px;height:52px;font-size:20px;flex-shrink:0;">
            <i class="bi bi-building"></i>
          </div>
          <div>
            <h2 class="mb-0" style="font-size:1.75rem; color:white;">Modificar Salón</h2>
            <div class="accent-line"></div>
          </div>
        </div>


        <div class="filtros-card formulario">
          <form action="/GYM/SvModificarSalon" method="POST">



            <div class="mb-3">
              <label>ID del salón</label>
              <input value="<%=cla.getIdClase()%>" type="number" name="id" readonly
                     style="background:#1a1818;color:#666;cursor:not-allowed;width:100%"/>
            </div>

            <div class="mb-4">
              <label>Nombre de la clase</label>
              <input value="<%=cla.getNombre()%>" type="text" name="nombre" required style="width:100%"/>
            </div>


            <div class="mb-3">
              <label>Cupo</label>
              <input value="<%=cla.getCupo()%>" type="number" name="cupo" required style="width:100%"/>
            </div>

            <div class="row g-3 mb-3">
              <div class="col-sm-6">
                <label>Día</label>
                <select name="dia">
                  <% String[] dias = {"Lunes","Martes","Miercoles","Jueves","Viernes"}; %>
                  <% for (String d : dias) { %>
                    <option value="<%=d%>" <%=cla.getDia().equals(d) ? "selected" : ""%>><%=d%></option>
                  <% } %>
                </select>
              </div>
              <div class="col-sm-6">
                <label>Horario</label>
                <select name="horario">
                  <% String[] horarios = {"8:00","9:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00"}; %>
                  <% for (String h : horarios) { %>
                    <option value="<%=h%>" <%=cla.getHorario().equals(h) ? "selected" : ""%>><%=h%></option>
                  <% } %>
                </select>
              </div>
            </div>

            <div class="mb-4">
              <label>Tipo de actividad</label>
              <input type="text" name="tipo" value="musculacion" readonly
                     style="background:#1a1818;color:#666;cursor:not-allowed;width:100%"/>
            </div>


            <div class="d-flex align-items-center gap-2" style="border-top:1px solid #2e2b2c;padding-top:16px;">
              <button type="submit" class="btn-filtrar">
                <i class="bi bi-pencil-square me-1"></i> Modificar
              </button>
              <a href="/GYM/SvMusculacion" class="boton4">Cancelar</a>
            </div>

          </form>
        </div>

      </div>
    </div>
  </div>

</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>
