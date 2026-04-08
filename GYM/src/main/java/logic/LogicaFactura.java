package logic;

import java.time.LocalDate;
import java.util.ArrayList;

import db.DbAbono;
import db.DbContrato;
import db.DbFactura;
import db.DbProducto;
import entities.Abono;
import entities.Factura;
import entities.ItemCarrito;
import entities.Producto;
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
    
    public void comprarProductos(ArrayList<ItemCarrito> carrito, Usuario user) throws Exception {

        DbFactura dbFactura = new DbFactura();
        DbProducto dbProducto = new DbProducto();

        // 2 — Validar stock
        for (ItemCarrito item : carrito) {
            int stockActual = dbProducto.getProducto(item).getStock();
            if (item.getCantidad() > stockActual) {
                throw new Exception("No hay stock suficiente del producto: " + item.getNombre());
            }
        }

        // 3 — Armar factura
        double total = 0;
        for (ItemCarrito item : carrito) total += item.getCantidad() * item.getPrecio();

        Factura factura = new Factura();
        factura.setFecha(LocalDate.now());
        factura.setTipo("C");
        factura.setCUIT("6942069");
        factura.setDNI(user.getDni());
        factura.setEstado("Pendiente de pago");
        factura.setTotal(total);

        // 4 — Transacción: factura + detalles
        dbFactura.comprarProductos(factura, carrito);

       
    }
}