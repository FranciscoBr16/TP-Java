package entities;

public class Abono {
	private int idAbono, cantReservas;
	private double precio;
	private String descripcion;
	
	
	
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public int getIdAbono() {
		return idAbono;
	}
	public void setIdAbono(int idAbono) {
		this.idAbono = idAbono;
	}
	public int getCantReservas() {
		return cantReservas;
	}
	public void setCantReservas(int cantReservas) {
		this.cantReservas = cantReservas;
	}
	public double getPrecio() {
		
		return precio;
	}
	public void setPrecio(double precio) {
		this.precio = precio;
	}
	

}
