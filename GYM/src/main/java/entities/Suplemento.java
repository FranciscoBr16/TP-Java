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

	public Suplemento(int id, int stock, String desc, String nomb, String unidad, Float valor) {
		super (id, stock,desc,nomb);
		this.unidad = unidad;
		this.valor = valor;
		
	}

	public Suplemento(Integer id_producto, Integer stock, String descripcion,String img, String nombre, LocalDate fecha_desde, Integer precio, String unidad, Float valor) {
		super( id_producto,  stock,  descripcion, img, nombre,  fecha_desde,  precio);
		this.unidad = unidad;
		this.valor = valor;
	}

	public Suplemento(Integer id_producto, Integer stock, String descripcion, String nombre, String unidad2,
			Float valor2) {
		super(id_producto, stock, descripcion, nombre);
		this.unidad=unidad2;
		this.valor=valor2;
	}

	
	
	
}
