package logic;

import java.text.Normalizer;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

public class LogicaActividad {

    private static final Map<String, DayOfWeek> DIAS = new HashMap<>();

    static {
        DIAS.put("LUNES", DayOfWeek.MONDAY);
        DIAS.put("MARTES", DayOfWeek.TUESDAY);
        DIAS.put("MIERCOLES", DayOfWeek.WEDNESDAY);
        DIAS.put("JUEVES", DayOfWeek.THURSDAY);
        DIAS.put("VIERNES", DayOfWeek.FRIDAY);
        DIAS.put("SABADO", DayOfWeek.SATURDAY);
        DIAS.put("DOMINGO", DayOfWeek.SUNDAY);
    }

    public LocalDate fechaInscripcion(String diaClaseStr) {

        String normalizado = Normalizer
            .normalize(diaClaseStr, Normalizer.Form.NFD)
            .replaceAll("\\p{InCombiningDiacriticalMarks}", "")
            .toUpperCase();

        DayOfWeek diaClase = DIAS.get(normalizado);

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