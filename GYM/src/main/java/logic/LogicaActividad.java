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
		
		case "lunes": 
			b = 1;
			break;
		case "martes":
			b = 2;
			break;
		case "miercoles":
			b = 3;
			break;
		case "jueves":
			b = 4;
			break;
		case "viernes":
			b = 5;
			break;
		default:
			b=0;

		}
		
		switch(nombreDelDia) {
		
		case "Lunes": 
			a = 1;
			break;
		case "Martes":
			a = 2;
			break;
		case "Miércoles":
			a = 3;
			break;
		case "Jueves":
			a = 4;
			break;
		case "Viernes":
			a = 5;
			break;
		case "Sábado":
			a = 6;
			break;
		case "Domingo":
			a = 7;
			break;
		default:
			a = 0;

		}
		
		int c = a - b;
		
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
