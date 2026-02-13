package entities;
import java.time.LocalDate;

public class Precio {
	private LocalDate fechaDesde;
	private double precio;


	public Precio(double precio) {
		this.precio = precio;
	}

	public Precio(LocalDate fecha_desde, Double precio2) {
		this.fechaDesde = fecha_desde;
		this.precio = precio2;
	}

	public LocalDate getFechaDesde() {
		return fechaDesde;
	}
	public void setFechaDesde(LocalDate fechaDesde) {
		this.fechaDesde = fechaDesde;
	}
	public double getPrecio() {
		return precio;
	}
	public void setPrecio(double precio) {
		this.precio = precio;
	}
}
