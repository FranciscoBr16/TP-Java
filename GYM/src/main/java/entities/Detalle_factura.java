package entities;

public class Detalle_factura {
	
	private int cantidad;
	private float sub_total;
	private int id_producto;
	private int nro_factura;
	
	public int getCantidad() {
		return cantidad;
	}
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	public float getSub_total() {
		return sub_total;
	}
	public void setSub_total(float sub_total) {
		this.sub_total = sub_total;
	}
	public int getId_producto() {
		return id_producto;
	}
	public void setId_producto(int id_producto) {
		this.id_producto = id_producto;
	}
	public int getNro_factura() {
		return nro_factura;
	}
	public void setNro_factura(int nro_factura) {
		this.nro_factura = nro_factura;
	}
	
	
}
