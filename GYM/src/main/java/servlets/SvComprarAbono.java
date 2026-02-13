package servlets;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbAbono;
import db.DbContrato;
import db.DbFactura;
import entities.Abono;
import entities.Detalle_Factura;
import entities.Factura;
import entities.Usuario;

@WebServlet("/SvComprarAbono")
public class SvComprarAbono extends HttpServlet {

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        Usuario user = (Usuario) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("/GYM/pages/logIn.jsp");
            return;
        }

        try {
            int idAbono = Integer.parseInt(request.getParameter("id_abono"));

            DbAbono dbAbono = new DbAbono();
            Abono abono = dbAbono.getAbono(new Abono(idAbono));
            
            if (abono == null) {
                request.getSession().setAttribute("mensaje", "El abono seleccionado no existe");
                request.getSession().setAttribute("tipoMensaje", "error");
                response.sendRedirect("/GYM/SvAbonos");
                return;
            }
            
            // VALIDACIÓN: Si es_mensual = 1, verificar que no tenga contrato activo
            if (abono.es_mensual()) {
                DbContrato dbContrato = new DbContrato();
                
                if (dbContrato.tieneContratoActivo(user.getDni())) {
                    request.getSession().setAttribute("mensaje", 
                        "Ya tienes un abono mensual activo. " +
                        "No puedes comprar otro hasta que expire el actual. " +
                        "Puedes comprar clases adicionales en su lugar.");
                    request.getSession().setAttribute("tipoMensaje", "error");
                    response.sendRedirect("/GYM/SvAbono");
                    return;
                }
            }
            // Si es_mensual = 0 (clases adicionales), siempre se permite

            // Crear la factura
            DbFactura dbFactura = new DbFactura();

            Factura f = new Factura();
            f.setFecha(LocalDate.now());
            f.setTipo("S");  // S = Suscripción/Abono
            f.setDNI(user.getDni());
            f.setCUIT("6942069");
            f.setEstado("Pendiente de pago");
            f.setTotal(abono.getPrecio());

            int nroFactura = dbFactura.nuevaFactura(f);
            
            if (nroFactura == -1) {
                request.getSession().setAttribute("mensaje", "Error al crear la factura");
                request.getSession().setAttribute("tipoMensaje", "error");
                response.sendRedirect("/GYM/SvAbono");
                return;
            }

            Detalle_Factura df = new Detalle_Factura();
            df.setIdProducto(idAbono);
            df.setNroFactura(nroFactura);
            df.setSubTotal(abono.getPrecio());

            boolean detalleCreado = dbFactura.facturarAbono(df);
            
            if (!detalleCreado) {
                request.getSession().setAttribute("mensaje", "Error al crear el detalle de la factura");
                request.getSession().setAttribute("tipoMensaje", "error");
                response.sendRedirect("/GYM/SvAbono");
                return;
            }
            
            // Mensaje de éxito
            String tipoCompra = abono.es_mensual() ? "abono mensual" : "clases adicionales";
            String mensajeExito = "¡Compra de " + tipoCompra + " realizada exitosamente! " +
                                "Tu factura #" + nroFactura + " quedó en estado pendiente. " +
                                "El administrador debe confirmar tu pago para activarlo.";
            
            request.getSession().setAttribute("mensaje", mensajeExito);
            request.getSession().setAttribute("tipoMensaje", "success");

            response.sendRedirect("/GYM/SvMisFacturas");
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("mensaje", "ID de abono inválido");
            request.getSession().setAttribute("tipoMensaje", "error");
            response.sendRedirect("/GYM/SvAbono");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("mensaje", "Error al procesar la compra: " + e.getMessage());
            request.getSession().setAttribute("tipoMensaje", "error");
            response.sendRedirect("/GYM/SvAbono");
        }
    }
}