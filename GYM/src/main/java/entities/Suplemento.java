package entities;

import java.time.LocalDate;

public class Suplemento extends Producto{
	
	public float valor;
	public String unidad;
	

	public float getValor() {
		return valor;
	}

	public void setValor(float valor) {
		this.valor = valor;
	}

	public String getUnidad() {
		return unidad;
	}

	public void setUnidad(String unidad) {
		this.unidad = unidad;
	}
	
	public Suplemento(String desc, String nombre, int stock, int precio, String unidad, float valor) {
		super(desc, nombre, stock, precio);
		this.unidad = unidad;
		this.valor = valor;
		
	}

	public Suplemento() {
		super();
	
	}

	public Suplemento(int id, int stock, String desc, String img, String nomb, LocalDate fecha, int pre, String unidad, Float valor) {
		super (id, stock,img,desc, nomb, fecha, pre);
		this.unidad = unidad;
		this.valor = valor;
		
	}
	
	
}
