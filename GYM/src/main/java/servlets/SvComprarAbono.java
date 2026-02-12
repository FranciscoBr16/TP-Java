package servlets;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DbAbono;
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

        int idAbono = Integer.parseInt(request.getParameter("id_abono"));

        DbAbono dbAbono = new DbAbono();
        Abono abono = dbAbono.getAbono(new Abono(idAbono));

        DbFactura dbFactura = new DbFactura();

        Factura f = new Factura();
        f.setFecha(LocalDate.now());
        f.setTipo("S");
        f.setDNI(user.getDni());
        f.setCUIT("6942069");
        f.setEstado("Pendiente de pago");
        f.setTotal(abono.getPrecio());

        int nroFactura = dbFactura.nuevaFactura(f);

        Detalle_Factura df = new Detalle_Factura();
        df.setIdProducto(idAbono);
        df.setNroFactura(nroFactura);
        df.setSubTotal(abono.getPrecio());

        dbFactura.facturarAbono(df);

        response.sendRedirect("/GYM/SvMisFacturas");
    }
}

