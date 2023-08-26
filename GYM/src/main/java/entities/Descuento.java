package entities;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Descuento {
	
	private static DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	private int idDescuento;
	private double procDescuento;
	
	public static DateTimeFormatter getFormato() {
		return formato;
	}
	public static void setFormato(DateTimeFormatter formato) {
		Descuento.formato = formato;
	}
	public int getIdDescuento() {
		return idDescuento;
	}
	public void setIdDescuento(int idDescuento) {
		this.idDescuento = idDescuento;
	}
	public double getProcDescuento() {
		return procDescuento;
	}
	public void setProcDescuento(double procDescuento) {
		this.procDescuento = procDescuento;
	}
	
	
	

}
