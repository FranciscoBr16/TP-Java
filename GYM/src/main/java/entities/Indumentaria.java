package entities;

import java.time.LocalDate;

public class Indumentaria extends Producto {
	
	public String talle;

	public Indumentaria(String desc, String nombre, int stock, int precio, String talle) {
		super(desc, nombre, stock, precio);
		this.talle = talle;
	}

	public Indumentaria() {
		super();
	}

	public Indumentaria(int id, int stock, String desc, String img, String nomb, LocalDate fecha, Integer pre, String c) {
		super (id, stock,img, desc, nomb, fecha, pre);
		this.talle = c;
	}

	public String getTalle() {
		return talle;
	}

	public void setTalle(String talle) {
		this.talle = talle;
	}

	
	
}
