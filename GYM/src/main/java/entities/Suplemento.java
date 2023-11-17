package entities;

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
	
	
}
