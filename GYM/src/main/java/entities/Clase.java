package entities;

public class Clase {
private int id_clase;
private String descripcion;
private int cupo;
private int dia;
private float horario;
private int id_actividad;
private int id_empleado;

public int getId_clase() {
	return id_clase;
}
public void setId_clase(int id_clase) {
	this.id_clase = id_clase;
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
public int getDia() {
	return dia;
}
public void setDia(int dia) {
	this.dia = dia;
}
public float getHorario() {
	return horario;
}
public void setHorario(float horario) {
	this.horario = horario;
}
public int getId_actividad() {
	return id_actividad;
}
public void setId_actividad(int id_actividad) {
	this.id_actividad = id_actividad;
}
public int getId_empleado() {
	return id_empleado;
}
public void setId_empleado(int id_empleado) {
	this.id_empleado = id_empleado;
}

}
