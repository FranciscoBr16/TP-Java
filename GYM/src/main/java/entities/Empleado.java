package entities;

import java.time.LocalDate;

public class Empleado {
private int idEmpleado;
private String nombre;
private String correo;
private String apellido;
private String rol;
private LocalDate fechaDesde;
public int getIdEmpleado() {
	return idEmpleado;
}
public void setIdEmpleado(int idEmpleado) {
	this.idEmpleado = idEmpleado;
}
public String getNombre() {
	return nombre;
}
public void setNombre(String nombre) {
	this.nombre = nombre;
}
public String getCorreo() {
	return correo;
}
public void setCorreo(String correo) {
	this.correo = correo;
}
public String getApellido() {
	return apellido;
}
public void setApellido(String apellido) {
	this.apellido = apellido;
}
public String getRol() {
	return rol;
}
public void setRol(String rol) {
	this.rol = rol;
}
public LocalDate getFechaDesde() {
	return fechaDesde;
}
public void setFechaDesde(LocalDate fechaDesde) {
	this.fechaDesde = fechaDesde;
}

}
