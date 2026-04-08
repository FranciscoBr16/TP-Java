package logic;

import java.time.LocalDate;

import db.DbAbono;
import db.DbContrato;
import db.DbFactura;
import entities.Abono;
import entities.Factura;
import entities.Usuario;

public class LogicaFactura {

    public int comprarAbono(int idAbono, Usuario user) throws Exception {

        DbAbono dbAbono = new DbAbono();
        DbContrato dbContrato = new DbContrato();
        DbFactura dbFactura = new DbFactura();

        // 1 Obtener abono
        Abono abono = dbAbono.getAbono(new Abono(idAbono));

        if (abono == null) {
            throw new Exception("El abono seleccionado no existe");
        }
        
        if (dbFactura.tienePendientes(user.getDni())) {
            throw new Exception("Tenés facturas pendientes de pago. Saldá tu deuda antes de realizar una nueva compra.");
        }

        // 2 Validación de contrato activo si es mensual
        if (abono.es_mensual()) {

            if (dbContrato.tieneContratoActivo(user.getDni())) {
                throw new Exception(
                    "Ya tienes un abono mensual activo. No puedes comprar otro hasta que expire el actual."
                );
            }
        }

        // 3 Crear factura
        Factura f = new Factura();
        f.setFecha(LocalDate.now());
        f.setTipo("S");
        f.setDNI(user.getDni());
        f.setCUIT("6942069");
        f.setEstado("Pendiente de pago");
        f.setTotal(abono.getPrecio());

        // 4 Ejecutar compra (transacción)
        dbFactura.comprarAbono(abono, f);

        return idAbono;
    }
}