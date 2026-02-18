<%@page import="entities.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Crear Abono</title>

<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@347&display=swap"
	rel="stylesheet" />

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous">
  </script>


<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/estilosGenerales2.css" />
<link rel="stylesheet" type="text/css" href="/GYM/style/formularioEstilos.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>
/* Estilos adicionales para el selector de tipo */
.tipo-selector {
    display: flex;
    gap: 20px;
    margin: 15px 0;
}

.tipo-opcion {
    flex: 1;
    padding: 20px;
    border: 2px solid #e0e0e0;
    border-radius: 10px;
    cursor: pointer;
    transition: all 0.3s ease;
    text-align: center;
    background-color: white;
}

.tipo-opcion:hover {
    border-color: #d95126;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.tipo-opcion input[type="radio"] {
    display: none;
}

.tipo-opcion input[type="radio"]:checked + .tipo-contenido {
    color: #d95126;
}

.tipo-opcion input[type="radio"]:checked + .tipo-contenido .tipo-icono {
    background-color: #d95126;
    color: white;
}

.tipo-opcion input[type="radio"]:checked ~ * {
    border-color: #d95126;
}

.tipo-contenido {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
}

.tipo-icono {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background-color: #f0f0f0;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2rem;
    transition: all 0.3s ease;
}

.tipo-titulo {
    font-weight: bold;
    font-size: 1.1rem;
}

.tipo-descripcion {
    font-size: 0.9rem;
    color: #666;
}

label[for="tipoAbono"] {
    display: block;
    margin-bottom: 10px;
    font-weight: bold;
}
</style>

<link rel="shortcut icon" href="/GYM/img/logo.ico" type="image/x-icon" />
<% Usuario user = (Usuario) session.getAttribute("user");%>
</head>

<header>
		<%
		    request.setAttribute("activePage", "tienda");
		%>
		<jsp:include page="/pages/components/navbar.jsp" />
		
	</header>

<body>


	<div class="contenedor">
		<div class="formulario">
			<div class="headerForm">
				<p class="titulo">Crear un nuevo <span class="anaranjado">abono</span></p>
			</div>
			<hr>
			<form action="/GYM/SvAltaAbono" method="POST" class="formulario-campos" enctype="multipart/form-data">
			
				<!-- Selector de Tipo de Abono -->
				<div class="campo">
					<label for="tipoAbono">Tipo de Abono:</label>
					<div class="tipo-selector">
						<!-- Opción Mensual -->
						<label class="tipo-opcion" for="esMensualSi">
							<input type="radio" id="esMensualSi" name="esMensual" value="true" checked>
							<div class="tipo-contenido">
								<div class="tipo-icono">
									<i class="bi bi-calendar-month"></i>
								</div>
								<div class="tipo-titulo">Plan Mensual</div>
								<div class="tipo-descripcion">
									Acceso completo por 30 días
								</div>
							</div>
						</label>
						
						<!-- Opción Clases Adicionales -->
						<label class="tipo-opcion" for="esMensualNo">
							<input type="radio" id="esMensualNo" name="esMensual" value="false">
							<div class="tipo-contenido">
								<div class="tipo-icono">
									<i class="bi bi-calendar-plus"></i>
								</div>
								<div class="tipo-titulo">Clases Adicionales</div>
								<div class="tipo-descripcion">
									Pack de clases para usar cuando quieras
								</div>
							</div>
						</label>
					</div>
				</div>
			
				<div class="campo">
					<label for="imagen">Selecciona una imagen:</label>
	  				 <input type="file" name="imagen" id="imagenU">
	    		</div>
	    		
				<div class="campo">
					<label for="nombreAbono">Nombre de Abono:</label> 
					<input type="text" name="nombreAbono" placeholder="Ej: Plan Premium, Pack 5 Clases" required/> 
				</div>
					
				<div class="campo">
					<label for="cantReservas">Cantidad de clases:</label>
					<input type="number" name="cantReservas" min="1" placeholder="Ej: 20" required />
				</div>
			
				<div class="campo">
					<label for="precio">Precio:</label>
					<input type="number" name="precio" min="0" placeholder="Ej: 15000" required />
				</div>
			
				<div class="campo">
					<label for="descripcion">Descripción:</label>
					<textarea name="descripcion" rows="3" placeholder="Descripción del abono..." style="width: 100%; padding: 10px; border-radius: 5px; border: 1px solid #ccc;"></textarea>
				</div>
				
				<div class="final">
					<button class="boton botonregistro" type="submit">
						<i class="bi bi-plus-circle"></i> Crear Abono
					</button>
				</div>
			</form>
		</div>
	</div>

<script>
// Agregar efecto visual al seleccionar tipo de abono
document.querySelectorAll('.tipo-opcion').forEach(opcion => {
    opcion.addEventListener('click', function() {
        document.querySelectorAll('.tipo-opcion').forEach(o => {
            o.style.borderColor = '#e0e0e0';
            o.style.backgroundColor = 'white';
        });
        this.style.borderColor = '#d95126';
        this.style.backgroundColor = '#fff5f2';
    });
});

// Establecer estilo inicial para la opción seleccionada
document.addEventListener('DOMContentLoaded', function() {
    const checked = document.querySelector('input[name="esMensual"]:checked');
    if (checked) {
        checked.closest('.tipo-opcion').style.borderColor = '#d95126';
        checked.closest('.tipo-opcion').style.backgroundColor = '#fff5f2';
    }
});
</script>

</body>
<jsp:include page="/pages/components/carrito.jsp" />
</html>
