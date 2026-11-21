package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import conexion.Conexion;
import entidad.Proyecto;

public class ProyectoDAO {

    public boolean registrar(Proyecto p) {
        boolean registrado = false;
        String sql = "INSERT INTO proyectos (nombre, descripcion, fecha_inicio, fecha_fin, asesor_tecnico, presupuesto) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setString(3, p.getFechaInicio());
            ps.setString(4, p.getFechaFin());
            ps.setString(5, p.getAsesorTecnico());
            ps.setDouble(6, p.getPresupuesto());
            
            registrado = ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error al registrar: " + e.getMessage());
            e.printStackTrace();
        }
        return registrado;
    }

    public List<Proyecto> listar() {
        List<Proyecto> lista = new ArrayList<>();
        String sql = "SELECT * FROM proyectos ORDER BY id_proyecto DESC";
        
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Proyecto p = new Proyecto();
                p.setIdProyecto(rs.getInt("id_proyecto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setFechaInicio(rs.getString("fecha_inicio"));
                p.setFechaFin(rs.getString("fecha_fin"));
                p.setAsesorTecnico(rs.getString("asesor_tecnico"));
                p.setPresupuesto(rs.getDouble("presupuesto"));
                lista.add(p);
            }
        } catch (Exception e) {
            System.out.println("Error al listar: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }
}