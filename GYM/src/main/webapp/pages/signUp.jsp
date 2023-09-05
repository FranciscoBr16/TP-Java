<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Registro</title>
        <link rel="stylesheet" href="../style/styleSignUp.css" />
        <link rel="shortcut icon" href="../img/logo.ico" type="image/x-icon" />
    </head>
    <body>
        <div class="formulario">
            <h1>�Unite al club!</h1>
            <form action="" method="post">
                <div class="campo">
                    <label for="nomusuario">Nombre de Usuario</label>
                    <input type="text" name="surname" id="nomusuario" />
                </div>
                <div class="campo">
                    <label for="nombre">Nombre:</label>
                    <input type="text" name="name" id="nombre" />
                </div>
                <div class="campo">
                    <label for="apellido">Apellido:</label>
                    <input type="text" name="surname" id="surname" />
                </div>
                <div class="campo">
                    <label for="password">Contrase�a:</label>
                    <input type="text" name="password" id="password" />
                </div>
                <div class="campo">
                    <label for="correo">Correo Electr�nico</label>
                    <input type="text" name="correo" id="correa" />
                </div>
                <div class="campo">
                    <label for="telefono">Tel�fono:</label>
                    <input type="text" name="telefono" id="telefono" />
                </div>
                <div class="campo">
                    <label for="">Fecha de Nacimiento</label>
                    <input type="text" name="" />
                </div>
                <button type="submit">Registrarse</button>
            </form>
        </div>
    </body>
</html>
