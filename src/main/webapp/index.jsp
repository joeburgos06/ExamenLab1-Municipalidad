<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entidad.Proyecto" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Municipalidad Metropolitana de Lima - Proyectos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-primary shadow-sm mb-4">
    <div class="container">
        <span class="navbar-brand mb-0 h1">🏛️ Municipalidad Metropolitana de Lima - Proyectos de Inversión Pública</span>
    </div>
</nav>

<div class="container">
    <% if (request.getAttribute("mensajeError") != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <strong>¡Atención!</strong> <%= request.getAttribute("mensajeError") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <% if (request.getAttribute("mensajeExito") != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <strong>¡Listo!</strong> <%= request.getAttribute("mensajeExito") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card shadow-sm">
                <div class="card-header bg-dark text-white">
                    <h5 class="mb-0">Registrar Nuevo Proyecto</h5>
                </div>
                <div class="card-body">
                    <form action="ProyectoServlet" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Nombre del Proyecto *</label>
                            <input type="text" name="txtNombre" class="form-control" 
                                   minlength="4" maxlength="60" required 
                                   placeholder="Ej. Construcción Parque Zonal">
                            <div class="form-text">De 4 a 60 caracteres.</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Descripción Técnica (Opcional)</label>
                            <textarea name="txtDescripcion" class="form-control" rows="2" 
                                      maxlength="255" placeholder="Detalles técnicos..."></textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Fecha de Inicio *</label>
                            <input type="date" name="txtFechaInicio" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Fecha de Culminación *</label>
                            <input type="date" name="txtFechaFin" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Asesor Técnico *</label>
                            <input type="text" name="txtAsesor" class="form-control" 
                                   required placeholder="Nombres y Apellidos">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Presupuesto Asignado (S/) *</label>
                            <input type="number" name="txtPresupuesto" class="form-control" 
                                   step="0.01" min="1" required placeholder="0.00">
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Guardar Proyecto</button>
                            <a href="ProyectoServlet" class="btn btn-outline-secondary">Actualizar Lista</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Listado de Proyectos Registrados</h5>
                    <a href="ProyectoServlet" class="btn btn-light btn-sm">Cargar Registros</a>
                </div>
                <div class="card-body table-responsive">
                    <table class="table table-striped table-hover table-bordered align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Proyecto</th>
                                <th>Descripción</th>
                                <th>Inicio</th>
                                <th>Fin</th>
                                <th>Asesor Técnico</th>
                                <th>Presupuesto</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Proyecto> lista = (List<Proyecto>) request.getAttribute("listaProyectos");
                                if (lista != null && !lista.isEmpty()) {
                                    for (Proyecto p : lista) {
                            %>
                            <tr>
                                <td><%= p.getIdProyecto() %></td>
                                <td class="fw-bold"><%= p.getNombre() %></td>
                                <td><%= (p.getDescripcion() == null || p.getDescripcion().isEmpty()) ? "-" : p.getDescripcion() %></td>
                                <td><%= p.getFechaInicio() %></td>
                                <td><%= p.getFechaFin() %></td>
                                <td><%= p.getAsesorTecnico() %></td>
                                <td class="text-end">S/ <%= String.format("%.2f", p.getPresupuesto()) %></td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">
                                    No hay proyectos cargados. Haz clic en <strong>"Cargar Registros"</strong> o registra uno nuevo.
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>