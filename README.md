# Semana 4 — MySQL y phpMyAdmin en una red Docker

Práctica TAS4 de Tendencias Tecnológicas. Pablo Ortega, Instituto Sudamericano, 4.º semestre. Fecha: 6 de noviembre de 2026.

## Informe y evidencias

El documento principal para entregar es [informe.md](informe.md). Contiene el procedimiento, las explicaciones, 12 capturas reales, resultados y referencias.

- [Guion para el audio personal de al menos 60 segundos](guion_audio.md).
- [Configuración de los dos servicios](compose.yml).
- [Resultados de las 13 comprobaciones](evidencias/resultados.json).
- [Imágenes y digests ejecutados](imagenes.lock.json).
- [Guía para demostrar la práctica](guia_demostracion.md).

## Resultado

MySQL 8.4.13 y phpMyAdmin 5.2.3 se conectan por la red bridge tas4_red. La base prueba_tas4 se creó desde la interfaz web. La tabla productos contiene Cuaderno, Lapiz y Carpeta. Se verificó una consulta desde el contenedor phpMyAdmin al servidor MySQL por nombre y puerto.

## Iniciar y consultar

1. Inicia Docker Desktop.
2. Copia .env.example a .env.local y define tus contraseñas. El usuario predeterminado es pablo; si se cambia, hay que adaptar también sql/01_permisos.sql.
3. Ejecuta scripts/iniciar.ps1 desde PowerShell.
4. Abre http://127.0.0.1:8084 e inicia con las credenciales de .env.local.
5. Si todavía no existe, crea prueba_tas4 desde Bases de datos.
6. Ejecuta sql/02_datos_prueba.sql una sola vez desde la pestaña SQL.
7. Ejecuta scripts/verificar.ps1 para comprobar la red y los datos.

El script de inicio no crea automáticamente la base: se realiza desde la interfaz para reproducir el requisito de la actividad. El archivo SQL de datos no debe repetirse sobre una tabla ya creada.

## Archivos privados

.env.local y .local/ están excluidos de Git y del ZIP. La contraseña local del laboratorio está en .local/acceso_phpmyadmin.txt. Estas credenciales de MySQL son independientes de las de Ubuntu.

Para detener sin eliminar los datos: docker compose --env-file .env.local stop. Para iniciar de nuevo: docker compose --env-file .env.local up -d.

La entrega requiere el enlace del informe Markdown y un MP3 personal de al menos 60 segundos. El guion está preparado; la grabación de voz se adjunta por separado.
