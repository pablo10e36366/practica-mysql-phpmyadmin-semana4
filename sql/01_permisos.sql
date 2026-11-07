-- La base aún no existe: este permiso permite crearla desde phpMyAdmin.
-- El nombre pablo debe coincidir con MYSQL_USER de .env.local.
GRANT ALL PRIVILEGES ON prueba_tas4.* TO 'pablo'@'%';
SHOW GRANTS FOR 'pablo'@'%';
