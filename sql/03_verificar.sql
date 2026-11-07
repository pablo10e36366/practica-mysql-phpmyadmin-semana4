SELECT VERSION() AS version_mysql;
SELECT SCHEMA_NAME, DEFAULT_CHARACTER_SET_NAME, DEFAULT_COLLATION_NAME
FROM information_schema.schemata
WHERE SCHEMA_NAME = 'prueba_tas4';
SELECT id, nombre, precio FROM prueba_tas4.productos ORDER BY id;
SELECT COUNT(*) AS filas, SUM(precio) AS total_precios FROM prueba_tas4.productos;
