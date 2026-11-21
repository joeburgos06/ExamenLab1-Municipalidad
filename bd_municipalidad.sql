CREATE DATABASE IF NOT EXISTS db_municipalidad;
USE db_municipalidad;

CREATE TABLE proyectos (
    id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    descripcion VARCHAR(255) NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    asesor_tecnico VARCHAR(100) NOT NULL,
    presupuesto DECIMAL(10, 2) NOT NULL
);

-- Dato de prueba para que la tabla no salga vacía al iniciar
INSERT INTO proyectos (nombre, descripcion, fecha_inicio, fecha_fin, asesor_tecnico, presupuesto)
VALUES ('Mejoramiento Av. Arequipa', 'Asfaltado y señalización vial', '2026-11-25', '2027-03-30', 'Carlos Mendoza Ruiz', 150000.00);