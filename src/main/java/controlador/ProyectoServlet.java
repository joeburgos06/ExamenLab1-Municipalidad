package controlador;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entidad.Proyecto;
import modelo.ProyectoDAO;

@WebServlet("/ProyectoServlet")
public class ProyectoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProyectoDAO dao = new ProyectoDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        cargarLista(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("txtNombre");
        String descripcion = request.getParameter("txtDescripcion");
        String fechaInicio = request.getParameter("txtFechaInicio");
        String fechaFin = request.getParameter("txtFechaFin");
        String asesor = request.getParameter("txtAsesor");
        String presupuestoStr = request.getParameter("txtPresupuesto");

        String error = null;

        if (nombre == null || nombre.trim().length() < 4 || nombre.trim().length() > 60) {
            error = "El nombre del proyecto es obligatorio y debe tener entre 4 y 60 caracteres.";
        } else if (fechaInicio == null || fechaInicio.trim().isEmpty()) {
            error = "La fecha de inicio es obligatoria.";
        } else if (fechaFin == null || fechaFin.trim().isEmpty()) {
            error = "La fecha de culminación es obligatoria.";
        } else if (fechaFin.compareTo(fechaInicio) < 0) {
            error = "La fecha de culminación no puede ser anterior a la fecha de inicio.";
        } else if (asesor == null || asesor.trim().isEmpty()) {
            error = "El asesor técnico es obligatorio.";
        } else if (presupuestoStr == null || presupuestoStr.trim().isEmpty()) {
            error = "El presupuesto asignado es obligatorio.";
        }

        double presupuesto = 0;
        if (error == null) {
            try {
                presupuesto = Double.parseDouble(presupuestoStr);
                if (presupuesto <= 0) {
                    error = "El presupuesto debe ser mayor a 0.";
                }
            } catch (NumberFormatException e) {
                error = "El presupuesto debe ser un monto numérico válido.";
            }
        }

        if (error != null) {
            request.setAttribute("mensajeError", error);
            cargarLista(request, response);
            return;
        }

        Proyecto p = new Proyecto();
        p.setNombre(nombre.trim());
        p.setDescripcion(descripcion != null ? descripcion.trim() : "");
        p.setFechaInicio(fechaInicio);
        p.setFechaFin(fechaFin);
        p.setAsesorTecnico(asesor.trim());
        p.setPresupuesto(presupuesto);

        boolean ok = dao.registrar(p);
        if (ok) {
            request.setAttribute("mensajeExito", "Proyecto registrado correctamente.");
        } else {
            request.setAttribute("mensajeError", "Error al guardar en la base de datos. Revisa la consola.");
        }

        cargarLista(request, response);
    }

    private void cargarLista(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Proyecto> lista = dao.listar();
        request.setAttribute("listaProyectos", lista);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}