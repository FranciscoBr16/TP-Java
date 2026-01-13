package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entities.ItemCarrito;


@WebServlet("/SvCarrito")
public class SvCarrito extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SvCarrito() {
        super();

    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        ArrayList<ItemCarrito> carrito = 
            (ArrayList<ItemCarrito>) session.getAttribute("carrito");

        if (carrito == null) {
            carrito = new ArrayList<>();
        }

        String accion = request.getParameter("accion");
        int idProducto = Integer.parseInt(request.getParameter("idProducto"));

        switch (accion) {
            case "agregar":
                agregarProducto(request, carrito);
                break;
            case "sumar":
                modificarCantidad(carrito, idProducto, +1);
                break;
            case "restar":
                modificarCantidad(carrito, idProducto, -1);
                break;
            case "eliminar":
                eliminarProducto(carrito, idProducto);
                break;
        }

        session.setAttribute("carrito", carrito);
        session.setAttribute("cantidadCarrito", carrito.size());

        response.sendRedirect(request.getHeader("Referer"));

}
    private void agregarProducto(HttpServletRequest request, ArrayList<ItemCarrito> carrito) {

        int idProducto = Integer.parseInt(request.getParameter("idProducto"));
        String nombre = request.getParameter("nombre");
        String imagen = request.getParameter("imagen");
        int precio = Integer.parseInt(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        for (ItemCarrito item : carrito) {
            if (item.getIdProducto() == idProducto) {
                if (item.getCantidad() < item.getStockDisponible()) {
                    item.setCantidad(item.getCantidad() + 1);
                }
                return;
            }
        }

        carrito.add(new ItemCarrito(
            idProducto, nombre, imagen, precio, 1, stock
        ));
    }

    private void modificarCantidad(ArrayList<ItemCarrito> carrito, int idProducto, int delta) {
        for (ItemCarrito item : carrito) {
            if (item.getIdProducto() == idProducto) {
                int nuevaCantidad = item.getCantidad() + delta;

                if (nuevaCantidad >= 1 && nuevaCantidad <= item.getStockDisponible()) {
                    item.setCantidad(nuevaCantidad);
                }
                return;
            }
        }
    }

    private void eliminarProducto(ArrayList<ItemCarrito> carrito, int idProducto) {
        carrito.removeIf(item -> item.getIdProducto() == idProducto);
    }

}

