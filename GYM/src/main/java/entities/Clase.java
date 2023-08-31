package entities;

import java.util.ArrayList;

public class Clase {
private int idClase;
private String descripcion;
private int cupo;
private String dia;
private String horario;
private Empleado empleado;
private ArrayList<Inscripcion> inscripcion = new ArrayList<>();

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

}
