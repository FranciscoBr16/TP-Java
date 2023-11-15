package entities;

import java.time.LocalDate;

public class Empleado {
private int idEmpleado;
private String nombre;
private String correo;
private String apellido;
private String rol;
private LocalDate fechaDesde;
private String imagen;
public Empleado(int idEmp) {
	this.idEmpleado = idEmp;
}
public Empleado() {

}
public Empleado(Integer id_empleado, String nombre2, String apellido2, String correo2, String rol2,
		LocalDate fecha_desde) {
	this.idEmpleado = id_empleado;
	this.nombre = nombre2;
	this.apellido = apellido2;
	this.correo = correo2;
	this.rol = rol2;
	this.fechaDesde = fecha_desde;
}
public Empleado(String nombre, String apellido, String email, LocalDate fecha, String rol) {
    this.nombre = nombre;
    this.apellido = apellido;
    this.correo = email;
    this.fechaDesde = fecha;
    this.rol = rol;
}
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

public void setImagen(String img) {
	this.imagen = img;
	
}
public String getImagen() {
	return imagen;
}


}
