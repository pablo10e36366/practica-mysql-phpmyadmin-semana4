# Cómo mostrar y explicar la práctica

## Abrir los servicios ya creados

Inicia Docker Desktop. Abre PowerShell en esta carpeta y ejecuta:

```powershell
docker compose --env-file .env.local up -d
docker compose --env-file .env.local ps
```

Abre http://127.0.0.1:8084. El usuario es pablo; su contraseña de laboratorio está en .local/acceso_phpmyadmin.txt. Es una cuenta de MySQL independiente del usuario de Ubuntu.

En phpMyAdmin, abre prueba_tas4 y después productos. Deben aparecer los tres registros: Cuaderno, Lapiz y Carpeta. No vuelvas a ejecutar el INSERT del archivo de carga para mostrar datos que ya existen.

## Mostrar la red y la conexión

```powershell
docker network inspect tas4_red --format '{{range .Containers}}{{.Name}} -> {{.IPv4Address}}{{println}}{{end}}'
docker port tas4_phpmyadmin
docker port tas4_mysql
powershell -ExecutionPolicy Bypass -File scripts/verificar.ps1
```

La red contiene ambos contenedores. El puerto 80 de phpMyAdmin se publica en 127.0.0.1:8084; MySQL no publica un puerto en Windows. La comprobación PHP se ejecuta dentro de phpMyAdmin y consulta MySQL mediante el nombre mysql y el puerto 3306.

## Explicación oral breve

«Creé un contenedor para MySQL y otro para phpMyAdmin. Los conecté a una red bridge personalizada llamada tas4_red. phpMyAdmin encuentra al servidor con el nombre mysql y se comunica por el puerto 3306. Desde Windows accedo a la interfaz por el puerto 8084. Creé prueba_tas4 desde el formulario web, después una tabla de productos y tres registros. Finalmente comprobé la red y ejecuté una consulta desde el contenedor phpMyAdmin para verificar la comunicación real.»

## Conceptos que debes distinguir

- Imagen: paquete base para crear el contenedor.
- Contenedor MySQL: ejecuta el servidor y administra los datos.
- Contenedor phpMyAdmin: ofrece la interfaz web y actúa como cliente de MySQL.
- Red bridge propia: conecta los servicios y permite resolver sus nombres.
- PMA_HOST=mysql: indica a phpMyAdmin qué servidor debe utilizar.
- 8084: puerto utilizado por el navegador en Windows; 80: puerto web dentro de phpMyAdmin.
- 3306: puerto de MySQL dentro de la red Docker.
- Volumen tas4_mysql_data: conserva los archivos de MySQL separados de la capa del contenedor.
- healthy: la comprobación configurada de MySQL ha terminado correctamente.
- SELECT: consulta datos; CREATE TABLE define la tabla; INSERT agrega registros.

## Detener sin borrar los datos

```powershell
docker compose --env-file .env.local stop
```

El informe Markdown es informe.md. El guion_audio.md ayuda a preparar el MP3 personal de al menos 60 segundos solicitado en la plataforma.
