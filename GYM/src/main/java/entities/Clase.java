package entities;

import java.util.ArrayList;

public class Clase {
private int idClase;
private String descripcion;
private int cupo;
private String dia, nombre;
private String horario;
private Empleado empleado;
private String tipo;
private ArrayList<Inscripcion> inscripcion = new ArrayList<>();
private String imagen;



public Clase(String nombre, String desc, int cupo, String dia, String horario, String tipo, int idEmp) {
	
	this.empleado = new Empleado(idEmp);
	this.nombre = nombre;
	this.descripcion=desc;
	this.cupo=cupo;
	this.dia=dia;
	this.horario=horario;
	this.tipo=tipo;
}
public Clase(int idClase, String nombre, String desc, int cupo, String dia, String horario, String tipo, int idEmp) {
	this.idClase = idClase;
	this.empleado = new Empleado(idEmp);
	this.nombre = nombre;
	this.descripcion=desc;
	this.cupo=cupo;
	this.dia=dia;
	this.horario=horario;
	this.tipo=tipo;
}

public Clase() {

}

public Clase(int c) {
	this.idClase = c;
}

public Clase(String nombre, int cupo, String dia, String horario, String tipo) {
	this.nombre = nombre;
	this.cupo=cupo;
	this.dia=dia;
	this.horario=horario;
	this.tipo=tipo;

}
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
public String getHorario() {
	return horario;
}
public void setHorario(String horario) {
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
