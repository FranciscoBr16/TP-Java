package entities;

public class Abono {
	private int idAbono, cantReservas, precio;
	private String nombreAbono, descripcion;
	
	
	
	public String getNombreAbono() {
		return nombreAbono;
	}
	
	public void setNombreAbono(String nombreAbono) {
		this.nombreAbono = nombreAbono;
	}
	
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
	public int getPrecio() {
		return precio;
	}
	public void setPrecio(int precio) {
		this.precio = precio;
	}
	public Abono(int cantReservas, int precio, String nombreAbono, String descripcion) {
		
		
		this.cantReservas = cantReservas;
		this.precio = precio;
		this.nombreAbono = nombreAbono;
		this.descripcion = descripcion;
	}

	public Abono() {
	}

	public Abono(int id) {
		this.idAbono = id;
	}

	public Abono(Integer idAbono, String nombreAbono, Integer cantReservas, Integer precio, String descripcion) {

		this.idAbono = idAbono;
		this.cantReservas = cantReservas;
		this.precio = precio;
		this.nombreAbono = nombreAbono;
		this.descripcion = descripcion;
	}


}
