package entities;

import java.util.ArrayList;

public class Clase {
private int idClase;
private String descripcion;
private int cupo;
private String dia, nombre;
private int horario;
private Empleado empleado;
private String tipo;
private ArrayList<Inscripcion> inscripcion = new ArrayList<>();
private String imagen;



public String getTipo() {
	return tipo;
}
public void setTipo(String tipo) {
	this.tipo = tipo;
}
public ArrayList<Inscripcion> getInscripcion() {
	return inscripcion;
}
public void setInscripcion(ArrayList<Inscripcion> inscripcion) {
	this.inscripcion = inscripcion;
}
public Empleado getEmpleado() {
	return empleado;
}
public void setEmpleado(Empleado empleado) {
	this.empleado = empleado;
}
public int getIdClase() {
	return idClase;
}
public void setIdClase(int idClase) {
	this.idClase = idClase;
}
public String getDescripcion() {
	return descripcion;
}
public void setDescripcion(String descripcion) {
	this.descripcion = descripcion;
}
public int getCupo() {
	return cupo;
}
public void setCupo(int cupo) {
	this.cupo = cupo;
}
public String getDia() {
	return dia;
}
public void setDia(String dia) {
	this.dia = dia;
}
public int getHorario() {
	return horario;
}
public void setHorario(int horario) {
	this.horario = horario;
}

public String getNombre() {
	return nombre;
}
public void setNombre(String nombre) {
	this.nombre = nombre;
	
}
public String getImagen() {
	return imagen;
}

public void setImagen(String img) {
	this.imagen = img;
	
}



}
