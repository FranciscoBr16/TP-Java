package entities;
import java.time.LocalDate;

public class Precio {
	private LocalDate fechaDesde;
	private int precio;
	
	
	public Precio(int precio) {
		this.precio = precio;
	}
	
	public Precio(LocalDate fecha_desde, Integer precio2) {
		this.fechaDesde = fecha_desde;
		this.precio = precio2;
	}

	public LocalDate getFechaDesde() {
		return fechaDesde;
	}
	public void setFechaDesde(LocalDate fechaDesde) {
		this.fechaDesde = fechaDesde;
	}
	public int getPrecio() {
		return precio;
	}
	public void setPrecio(int precio) {
		this.precio = precio;
	}
}
