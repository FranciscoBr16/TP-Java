package entities;

import java.time.LocalDate;

public class Inscripcion {
private LocalDate fechaInscripcion;
private Clase clase;



public Clase getClase() {
	return clase;
}

public void setClase(Clase clase) {
	this.clase = clase;
}

public LocalDate getFechaInscripcion() {
	return fechaInscripcion;
}

public void setFechaInscripcion(LocalDate fechaInscripcion) {
	this.fechaInscripcion = fechaInscripcion;
}

}
