package logic;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

public class LogicaActividad {

    private static final Map<String, DayOfWeek> DIAS = new HashMap<>();

    static {
        DIAS.put("Lunes", DayOfWeek.MONDAY);
        DIAS.put("Martes", DayOfWeek.TUESDAY);
        DIAS.put("Miercoles", DayOfWeek.WEDNESDAY);
        DIAS.put("Miércoles", DayOfWeek.WEDNESDAY);
        DIAS.put("Jueves", DayOfWeek.THURSDAY);
        DIAS.put("Viernes", DayOfWeek.FRIDAY);
        DIAS.put("Sabado", DayOfWeek.SATURDAY);
        DIAS.put("Sábado", DayOfWeek.SATURDAY);
        DIAS.put("Domingo", DayOfWeek.SUNDAY);
    }

    public LocalDate fechaInscripcion(String diaClaseStr) {

        DayOfWeek diaClase = DIAS.get(diaClaseStr);

        if (diaClase == null) {
            throw new IllegalArgumentException("Día inválido: " + diaClaseStr);
        }

        LocalDate hoy = LocalDate.now();
        DayOfWeek hoyDow = hoy.getDayOfWeek();

        int diferencia = diaClase.getValue() - hoyDow.getValue();

        if (diferencia <= 0) {
            diferencia += 7;
        }

        return hoy.plusDays(diferencia);
    }
}
