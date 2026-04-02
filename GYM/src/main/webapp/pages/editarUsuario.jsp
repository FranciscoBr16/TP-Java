<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="entities.Usuario"%>

<%
Usuario u = (Usuario) request.getAttribute("usuario");
%>

<!DOCTYPE html>
<html>
<head>
<title>Editar Usuario</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
<link rel="stylesheet" href="/GYM/style/estilosGenerales.css"/>
<link rel="stylesheet" href="/GYM/style/estilosGenerales2.css"/>
<link rel="stylesheet" href="/GYM/style/listaUsuarios.css"/>

<style>
  body { color: #f0eded; }

  .input-wrap { position: relative; }
  .input-wrap .input-icon {
    position: absolute; left: 13px; top: 50%;
    transform: translateY(-50%);
    color: #6b6668; font-size: .9rem; pointer-events: none; z-index: 2;
  }
  .input-wrap input { padding-left: 36px !important; }
</style>
</head>

<body>

<!-- Navbar -->
<header>
  <%
      request.setAttribute("activePage", "usuarios");
  %>
  <jsp:include page="/pages/components/navbar.jsp" />
</header>



<div class="page-wrapper pt-2">
  <div class="row justify-content-center">
    <div class="col-lg-7 col-md-9">

      <div class="filtros-card">
        <form action="/GYM/SvEditarUsuario" method="POST">

          <input type="hidden" name="dni" value="<%=u.getDni()%>">

          <!-- Datos personales -->
          <p class="mb-3" style="font-size:.72rem;letter-spacing:2.5px;text-transform:uppercase;color:#d95126;font-weight:700;border-bottom:1px solid #2e2b2c;padding-bottom:8px;">
            <i class="fa-solid fa-id-card me-1"></i> Datos personales
          </p>

          <div class="row g-3 mb-3">
            <div class="col-sm-6">
              <label>Nombre</label>
              <div class="input-wrap">
                <i class="input-icon fa-solid fa-user"></i>
                <input name="nombre" value="<%=u.getNombre()%>" placeholder="Nombre">
              </div>
            </div>
            <div class="col-sm-6">
              <label>Apellido</label>
              <div class="input-wrap">
                <i class="input-icon fa-solid fa-user"></i>
                <input name="apellido" value="<%=u.getApellido()%>" placeholder="Apellido">
              </div>
            </div>
          </div>

          <div class="mb-3">
            <label>Fecha de nacimiento</label>
            <div class="input-wrap">
              <i class="input-icon fa-solid fa-calendar"></i>
              <input type="date" name="fecha" value="<%=u.getFechaNac()%>">
            </div>
          </div>

          <!-- Contacto -->
          <p class="mb-3 mt-4" style="font-size:.72rem;letter-spacing:2.5px;text-transform:uppercase;color:#d95126;font-weight:700;border-bottom:1px solid #2e2b2c;padding-bottom:8px;">
            <i class="fa-solid fa-envelope me-1"></i> Contacto
          </p>

          <div class="mb-3">
            <label>Correo electrónico</label>
            <div class="input-wrap">
              <i class="input-icon fa-solid fa-at"></i>
              <input name="correo" value="<%=u.getEmail()%>" placeholder="correo@ejemplo.com">
            </div>
          </div>

          <div class="mb-3">
            <label>Teléfono</label>
            <div class="input-wrap">
              <i class="input-icon fa-solid fa-phone"></i>
              <input name="telefono" value="<%=u.getTelefono()%>" placeholder="+54 11 0000-0000">
            </div>
          </div>

          <!-- Seguridad -->
          <p class="mb-3 mt-4" style="font-size:.72rem;letter-spacing:2.5px;text-transform:uppercase;color:#d95126;font-weight:700;border-bottom:1px solid #2e2b2c;padding-bottom:8px;">
            <i class="fa-solid fa-lock me-1"></i> Seguridad
          </p>

          <div class="mb-4">
            <label>Contraseña</label>
            <div class="input-wrap">
              <i class="input-icon fa-solid fa-key"></i>
              <input type="password" name="clave" value="<%=u.getPassword()%>" placeholder="••••••••">
            </div>
          </div>

          <!-- Permisos y estado -->
          <p class="mb-3" style="font-size:.72rem;letter-spacing:2.5px;text-transform:uppercase;color:#d95126;font-weight:700;border-bottom:1px solid #2e2b2c;padding-bottom:8px;">
            <i class="fa-solid fa-shield-halved me-1"></i> Permisos y estado
          </p>

          <div class="d-flex align-items-center gap-2 mb-2"
               style="background:#2a2728;border:1px solid #3d3a3b;border-radius:8px;padding:10px 14px;">
            <input type="checkbox" class="form-check-input mt-0" name="admin"
              style="width:18px;height:18px;accent-color:#d95126;cursor:pointer;"
              <%= u.isAdmin() ? "checked" : "" %>>
            <label class="mb-0">
              <span class="badge-admin-tag me-1"><i class="fa-solid fa-star"></i></span>
              Administrador
            </label>
          </div>

          <div class="d-flex align-items-center gap-2 mb-4"
               style="background:#2a2728;border:1px solid #3d3a3b;border-radius:8px;padding:10px 14px;">
            <input type="checkbox" class="form-check-input mt-0" name="estado" checked
              style="width:18px;height:18px;accent-color:#d95126;cursor:pointer;">
            <label class="mb-0">
              <span class="badge-activo me-1"><i class="fa-solid fa-circle-check"></i></span>
              Usuario activo
            </label>
          </div>

          <!-- Botones — clases del proyecto -->
          <div class="d-flex align-items-center gap-2"
               style="border-top:1px solid #2e2b2c;padding-top:16px;">
            <button type="submit" class="btn-filtrar">
              <i class="fa-solid fa-floppy-disk me-1"></i> Guardar cambios
            </button>
            <a href="/GYM/SvUsuarios" class="btn-limpiar">
              <i class="fa-solid fa-xmark me-1"></i> Cancelar
            </a>
          </div>

        </form>
      </div>

    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
