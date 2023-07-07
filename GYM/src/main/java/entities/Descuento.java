package entities;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Descuento {
	
	private int id_descuento;
	private float procentaje_descuento;
	private static DateTimeFormatter formato_fecha = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	private LocalDate fecha_desde;
	private LocalDate fecha_hasta;
	
	public int getId_descuento() {
		return id_descuento;
	}
	public void setId_descuento(int id_descuento) {
		this.id_descuento = id_descuento;
	}
	public float getProcentaje_descuento() {
		return procentaje_descuento;
	}
	public void setProcentaje_descuento(float procentaje_descuento) {
		this.procentaje_descuento = procentaje_descuento;
	}
	public LocalDate getFecha_desde() {
		return fecha_desde;
	}
	public void setFecha_desde(LocalDate fecha_desde) {
		this.fecha_desde = fecha_desde;
	}
	public String getFecha_hasta(boolean b) {
		LocalDate f = this.getFecha_hasta(); 
		String fr = null;
		if (f !=null) 
		fr = this.getFecha_hasta().format(formato_fecha);
		else fr = "0";
		return fr;
	}
	private LocalDate getFecha_hasta() {
		return null;
	}
	public void setFecha_hasta(LocalDate fecha_hasta) {
		this.fecha_hasta = fecha_hasta;
	}
	
	

}
