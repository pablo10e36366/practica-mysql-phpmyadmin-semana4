$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath (Split-Path -Parent $PSScriptRoot)

if (-not (Test-Path -LiteralPath '.env.local')) {
    throw 'Copia .env.example a .env.local y define tus contraseñas antes de iniciar.'
}

docker info --format '{{.ServerVersion}}' 2>$null
if ($LASTEXITCODE -ne 0) {
    throw 'Inicia Docker Desktop y espera a que el motor esté disponible.'
}

docker compose --env-file .env.local config --quiet
if ($LASTEXITCODE -ne 0) { throw 'Revisa la configuración y las variables privadas.' }
docker compose --env-file .env.local up -d --wait --wait-timeout 180
if ($LASTEXITCODE -ne 0) { throw 'Los servicios no iniciaron correctamente.' }

$OutputEncoding = [System.Text.UTF8Encoding]::new()
Get-Content -LiteralPath 'sql/01_permisos.sql' -Raw -Encoding UTF8 |
    docker exec -i tas4_mysql sh -c 'MYSQL_PWD=$MYSQL_ROOT_PASSWORD mysql -uroot'
if ($LASTEXITCODE -ne 0) { throw 'No se pudieron asignar los permisos.' }

Write-Host 'Abre http://127.0.0.1:8084 e inicia con MYSQL_USER y MYSQL_PASSWORD de .env.local.'
Write-Host 'Si aún no existe, crea prueba_tas4 desde Bases de datos.'
Write-Host 'Ejecuta sql/02_datos_prueba.sql en la pestaña SQL una sola vez.'
