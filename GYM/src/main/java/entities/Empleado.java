package entities;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Empleado {
	
	private int id_empleado;
	private String nombre;
	private String apellido;
	private String mail;
	private static DateTimeFormatter formato_fecha = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	private LocalDate fecha_desde;
	private String rol;
	
	public int getId_empleado() {
		return id_empleado;
	}
	public void setId_empleado(int id_empleado) {
		this.id_empleado = id_empleado;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getApellido() {
		return apellido;
	}
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public LocalDate getFecha_desde() {
		return fecha_desde;
	}
	public void setFecha_desde(LocalDate fecha_desde) {
		this.fecha_desde = fecha_desde;
	}
	public String getRol() {
		return rol;
	}
	public void setRol(String rol) {
		this.rol = rol;
	}
	
	

}
