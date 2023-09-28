<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Registro</title>
        <link rel="stylesheet" type="text/css" href="../style/styleRegister.css" />
        <link rel="stylesheet" type="text/css" href="../style/generalStyles.css" />
        <link rel="shortcut icon" href="../img/logo.ico" type="image/x-icon" />
    </head>
    <body>
        <div class="formulario">
            <div class="headerForm">
                <p>Unite al Club!</p>
            </div>
            <form action="/GYM/SvSignUp" method="POST" class="formulario-campos">
                <div class="campo">
                    <label for="dni">Numero de Documento (DNI):</label>
                    <input
                        type="number"
                        name="dni"
                        id="dni"
                        required
                        min="1000000"
                        max="99999999"
                    />
                    <label for="password">Contraseña:</label>
                    <input
                        type="password"
                        name="password"
                        id="password"
                        required
                    />
                </div>
                <div class="campo">
                    <label for="nombre">Nombre:</label>
                    <input type="text" name="name" id="name" required />
                    <label for="apellido">Apellido:</label>
                    <input type="text" name="surname" id="surname" required />
                </div>
                <div class="campo">
                    <label for="email">Correo Electrónico:</label>
                    <input type="email" name="email" id="email" required />
                </div>
                <div class="campo">
                    <label for="phonenumber">Teléfono:</label>
                    <input
                        type="text"
                        name="phonenumber"
                        id="phonenumber"
                        required
                    />
                </div>
                <div class="campo">
                    <label for="birthdate">Fecha de Nacimiento:</label>
                    <input
                        type="date"
                        name="birthdate"
                        id="birthdate"
                        required
                    />
                </div>
                <div class="botonRegister">
                    <button type="submit">Registrarse</button>
                    <button href="index.jsp">Volver al Inicio</button>
                </div>
            </form>
        </div>
    </body>
</html>
