package entities;


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

