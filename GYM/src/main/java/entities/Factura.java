package entities;

import java.util.ArrayList;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Factura {
	
	private int nroFactura;
	private LocalDate fecha;
	private String CUIT;
	private double total;
	private String descripcion;
	private String tipo;
	private ArrayList<Detalle_Factura> detalles = new ArrayList<>();
	private Usuario usuario;
	private Producto producto;
	private boolean estado;
	
	
	
	public boolean isEstado() {
		return estado;
	}
	public void setEstado(boolean estado) {
		this.estado = estado;
	}
	public Producto getProducto() {
		return producto;
	}
	public void setProducto(Producto producto) {
		this.producto = producto;
	}
	public Usuario getUsuario() {
		return usuario;
	}
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	public int getNroFactura() {
		return nroFactura;
	}
	public void setNroFactura(int nroFactura) {
		this.nroFactura = nroFactura;
	}
	public LocalDate getFecha() {
		return fecha;
	}
	public void setFecha(LocalDate fecha) {
		this.fecha = fecha;
	}
	public String getCUIT() {
		return CUIT;
	}
	public void setCUIT(String cUIT) {
		CUIT = cUIT;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public ArrayList<Detalle_Factura> getDetalles() {
		return detalles;
	}
	public void setDetalles(ArrayList<Detalle_Factura> detalles) {
		this.detalles = detalles;
	}
	
	public double calculaTotal() {
		double total = 0;
		for (Detalle_Factura unDetalle : detalles) {
		}
		return total;
		//PROGRAMAR!!
		}
			
		
	
	
	
	
}
