package entities;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Contrato {
	private static DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	
	private LocalDate fechaDesde, fechaHasta;
	private int reservasRestantes;
	
	public static DateTimeFormatter getFormato() {
		return formato;
	}
	    
	public static void setFormato(DateTimeFormatter formato) {
		Contrato.formato = formato;
	}

	public LocalDate getFechaDesde() {
		return fechaDesde;
	}

	public void setFechaDesde(LocalDate fechaDesde) {
		this.fechaDesde = fechaDesde;
	}

	public LocalDate getFechaHasta() {
		return fechaHasta;
	}

	public void setFechaHasta(LocalDate fechaHasta) {
		this.fechaHasta = fechaHasta;
	}

	public int getReservasRestantes() {
		return reservasRestantes;
	}

	public void setReservasRestantes(int reservasRestantes) {
		this.reservasRestantes = reservasRestantes;
	}
	
	
	
		
}
