package entities;

import java.time.LocalDate;

public class Producto {
	
	private int idProducto;
	private String nombre;
	private String descripcion;
	private int stock;
	private String imagen;
	private Precio precio;
	
	
	
	
	public Producto(String desc, String nombre, int stock, int precio) {
		this.descripcion = desc;
		this.nombre = nombre;
		this.stock = stock;
		Precio p = new Precio(precio);
		this.precio = p;
	}
	public Producto() {
	}
	public Producto(int id) {
		this.idProducto = id;
	}
	public Producto(Integer id_producto, Integer stock, String descripcion, String nombre, LocalDate fecha_desde, Integer precio) {
		this.idProducto = id_producto;
		this.stock = stock;
		this.descripcion = descripcion;
		this.nombre = nombre;
		Precio p = new Precio(fecha_desde, precio);
		this.precio = p;
		
	}
	
	public Producto(int id, int stock, String img, String desc, String nomb, LocalDate fecha, Integer pre) {
		this.idProducto = id;
		this.imagen=img;
		this.stock = stock;
		this.descripcion = desc;
		this.nombre = nomb;
		Precio p = new Precio(fecha, pre);
		this.precio = p;
	}
	public Producto(int id, int stock2, String desc, String nomb) {
		this.idProducto = id;
		this.stock = stock2;
		this.descripcion = desc;
		this.nombre = nomb;
	}
	public Producto(Integer id_producto, LocalDate fecha_desde, Integer precio2) {
		this.idProducto=id_producto;
		Precio p = new Precio(fecha_desde,precio2);
		this.precio=p;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public int getValorPrecio() {
		return precio.getPrecio();
	}
	public Precio getPrecio() {
		return this.precio;
	}
	public void setPrecio(Precio precio) {
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
	public String getImagen() {
		return imagen;
	}
	public void setImagen(String imagen) {
		this.imagen = imagen;
	}
	
	
	
}

