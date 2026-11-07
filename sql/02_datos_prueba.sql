-- Ejecutar desde la pestaña SQL de phpMyAdmin, después de crear prueba_tas4.
USE prueba_tas4;

CREATE TABLE productos (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(80) NOT NULL,
  precio DECIMAL(10,2) NOT NULL
);

INSERT INTO productos (nombre, precio) VALUES
  ('Cuaderno', 2.50),
  ('Lapiz', 0.75),
  ('Carpeta', 1.25);

SELECT id, nombre, precio FROM productos ORDER BY id;
