package entities;

public class Indumentaria extends Producto {
	
	public String talle;

	public Indumentaria(String desc, String nombre, int stock, int precio, String talle) {
		super(desc, nombre, stock, precio);
		this.talle = talle;
	}

	public Indumentaria() {
		super();
	}

	public String getTalle() {
		return talle;
	}

	public void setTalle(String talle) {
		this.talle = talle;
	}

	
	
}
