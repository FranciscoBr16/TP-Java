package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbContrato;
import db.DbFactura;
import entities.Factura;
import entities.Usuario;

/**
 * Servlet implementation class SvConfirmarPago
 */
@WebServlet("/SvConfirmarPago")
public class SvConfirmarPago extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvConfirmarPago() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	 @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        Usuario user = (Usuario) request.getSession().getAttribute("user");

	        if (user == null || !user.isAdmin()) {
	        	response.sendRedirect("/GYM/pages/logIn.jsp");
	            return;
	        }

	        try {
	            int nroFactura = Integer.parseInt(request.getParameter("nroFactura"));

	            DbFactura dbFactura = new DbFactura();

	            // Primero actualizar estado de la factura a "Pagada"
	            boolean facturaActualizada = dbFactura.actualizarEstadoFactura(nroFactura, "Pagada");

	            if (!facturaActualizada) {
	                request.getSession().setAttribute("mensaje", "Error al actualizar el estado de la factura");
	                request.getSession().setAttribute("tipoMensaje", "error");
	                response.sendRedirect("/GYM/SvMisFacturas");
	                return;
	            }

	            // Obtener información de la factura para verificar si es de tipo abono
	            Factura factura = new Factura();
	            factura.setNroFactura(nroFactura);
	            factura = dbFactura.getFacturaAbono(factura);

	            // Si la factura existe y es de tipo "S" (Suscripción/Abono), crear el contrato
	            if (factura != null && "S".equals(factura.getTipo())) {

	                // Verificar que tenga detalles con abono
	                if (factura.getDetalles() != null && !factura.getDetalles().isEmpty() &&
	                    factura.getDetalles().get(0).getAbono() != null) {

	                    // Obtener el DNI del cliente y el ID del abono
	                    String dniCliente = factura.getDNI();
	                    int idAbono = factura.getDetalles().get(0).getAbono().getIdAbono();

	                    // Verificar si ya tiene un contrato activo
	                    DbContrato dbContrato = new DbContrato();
	                    boolean tieneContratoActivo = dbContrato.tieneContratoActivo(dniCliente);

	                    if (tieneContratoActivo) {
	                        request.getSession().setAttribute("mensaje",
	                            "Pago confirmado. ATENCIÓN: El cliente ya tiene un contrato activo.");
	                        request.getSession().setAttribute("tipoMensaje", "success");
	                    } else {
	                        // Crear el contrato de 30 días
	                        boolean contratoCreado = dbContrato.crearContrato(dniCliente, idAbono);

	                        if (contratoCreado) {
	                            request.getSession().setAttribute("mensaje",
	                                "Pago confirmado y contrato creado exitosamente por 30 días");
	                            request.getSession().setAttribute("tipoMensaje", "success");
	                        } else {
	                            request.getSession().setAttribute("mensaje",
	                                "Pago confirmado pero hubo un error al crear el contrato");
	                            request.getSession().setAttribute("tipoMensaje", "error");
	                        }
	                    }
	                } else {
	                    // Es abono pero no tiene detalles correctos
	                    request.getSession().setAttribute("mensaje",
	                        "Pago confirmado pero no se pudo obtener información del abono");
	                    request.getSession().setAttribute("tipoMensaje", "success");
	                }
	            } else {
	                // Es una factura de productos (tipo "C") o no se pudo obtener
	                request.getSession().setAttribute("mensaje", "Pago confirmado exitosamente");
	                request.getSession().setAttribute("tipoMensaje", "success");
	            }

	        } catch (NumberFormatException e) {
	            request.getSession().setAttribute("mensaje", "Número de factura inválido");
	            request.getSession().setAttribute("tipoMensaje", "error");
	        } catch (Exception e) {
	            e.printStackTrace();
	            request.getSession().setAttribute("mensaje", "Error al procesar el pago: " + e.getMessage());
	            request.getSession().setAttribute("tipoMensaje", "error");
	        }

	        response.sendRedirect("/GYM/SvMisFacturas");
	    }

}