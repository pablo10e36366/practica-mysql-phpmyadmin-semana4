<?php
// Comprobacion desde el contenedor phpMyAdmin, usando la red de Docker.
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$host = 'mysql';
$ip = gethostbyname($host);
if ($ip === $host) {
    throw new RuntimeException('El nombre mysql no pudo resolverse.');
}
$socket = fsockopen($host, 3306, $errno, $error, 5);
if (!$socket) {
    throw new RuntimeException('No se pudo abrir el puerto MySQL.');
}
fclose($socket);
$db = new mysqli($host, getenv('MYSQL_USER'), getenv('MYSQL_PASSWORD'), 'prueba_tas4', 3306);
$db->set_charset('utf8mb4');
$server = $db->query('SELECT VERSION() AS version, DATABASE() AS base, CURRENT_USER() AS usuario, @@port AS puerto')->fetch_assoc();
$rows = $db->query('SELECT id, nombre, precio FROM productos ORDER BY id')->fetch_all(MYSQLI_ASSOC);
if (count($rows) !== 3 || $rows[0]['nombre'] !== 'Cuaderno' || $rows[1]['nombre'] !== 'Lapiz' || $rows[2]['nombre'] !== 'Carpeta') {
    throw new RuntimeException('Los tres registros esperados no coinciden.');
}
echo json_encode([
    'estado' => 'correcto',
    'nombre_dns' => $host,
    'ip_resuelta' => $ip,
    'tcp_3306' => 'accesible',
    'servidor' => $server,
    'filas' => count($rows),
    'productos' => $rows,
], JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE), PHP_EOL;
