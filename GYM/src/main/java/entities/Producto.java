package entities;

import java.util.ArrayList;

public class Producto {
	
	public int idProducto;
	public String descripcion;
	public int stock;
	private ArrayList<Precio> precio = new ArrayList<>();
	
	public ArrayList<Precio> getPrecio() {
		return precio;
	}
	public void setPrecio(ArrayList<Precio> precio) {
		this.precio = precio;
	}
	public int getIdProducto() {
		return idProducto;
	}
	public void setIdProducto(int idProducto) {
		this.idProducto = idProducto;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
}
