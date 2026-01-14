package entities;

public class Detalle_Factura {
	
	private int cantidad;
	private int nro_factura;
	private int id_producto;
	private double sub_total;
	private Producto producto;
	
	public int getNroFactura() {
		return nro_factura;
	}
	public void setNroFactura(int nro_factura) {
		this.nro_factura = nro_factura;
	}
	public int getIdProducto() {
		return id_producto;
	}
	public void setIdProducto(int id_producto) {
		this.id_producto = id_producto;
	}
	public double getSubTotal() {
		return sub_total;
	}
	public void setSubTotal(double sub_total) {
		this.sub_total = sub_total;
	}
	public int getCantidad() {
		return cantidad;
	}
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	public Producto getProducto() {
		return producto;
	}
	public void setProducto(Producto producto) {
		this.producto = producto;
	}
	public Detalle_Factura(int nro_factura, int cantidad, int id_producto, double sub_total) {
		super();
		this.cantidad = cantidad;
		this.nro_factura = nro_factura;
		this.id_producto = id_producto;
		this.sub_total = sub_total;
	}
	
	
	
	

}
