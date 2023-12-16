package logic;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;


public class LogicaActividad {
	
	
	public LocalDate fechaIncripcion(String fechastr) {
		int b = 0;
		int a = 0;
		
		LocalDate hoy = LocalDate.now();
		DateTimeFormatter formato = DateTimeFormatter.ofPattern("EEEE");
		String nombreDelDia = hoy.format(formato);
		
		
		switch(fechastr) {
		
		case "Lunes": 
			b = 1;
			break;
		case "Martes":
			b = 2;
			break;
		case "Miercoles":
			b = 3;
			break;
		case "Jueves":
			b = 4;
			break;
		case "Viernes":
			b = 5;
			break;
		default:
			break;

		}
		
		switch(nombreDelDia) {
		
		case "lunes": 
			a = 1;
			break;
		case "martes":
			a = 2;
			break;
		case "miércoles":
			a = 3;
			break;
		case "jueves":
			a = 4;
			break;
		case "viernes":
			a = 5;
			break;
		case "sábado":
			a = 6;
			break;
		case "domingo":
			a = 7;
			break;
		default:
			break;
		}
		
		int c = b - a;
		
		if ( c > 0 ) {
			LocalDate fechaEnElFuturo = hoy.plusDays(c);
			return  fechaEnElFuturo;
		}else {
			c= c +7;
			LocalDate fechaEnElFuturo = hoy.plusDays(c);
			return  fechaEnElFuturo;
		}
		
		}
	
	

}
