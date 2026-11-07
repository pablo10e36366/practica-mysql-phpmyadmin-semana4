$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath (Split-Path -Parent $PSScriptRoot)
New-Item -ItemType Directory -Path '.local' -Force | Out-Null

$privateLines = Get-Content -LiteralPath '.env.local' |
    Where-Object { $_ -match '^MYSQL_(USER|PASSWORD)=' }
$privateLines | Set-Content -LiteralPath '.local/php-cliente.env' -Encoding Ascii

docker compose --env-file .env.local ps
docker network inspect tas4_red --format '{{range .Containers}}{{.Name}} -> {{.IPv4Address}}{{println}}{{end}}'
docker cp scripts/verificar_red.php tas4_phpmyadmin:/tmp/verificar_red.php
docker exec --env-file .local/php-cliente.env tas4_phpmyadmin php /tmp/verificar_red.php
if ($LASTEXITCODE -ne 0) { throw 'Falló la consulta desde phpMyAdmin a MySQL.' }

$OutputEncoding = [System.Text.UTF8Encoding]::new()
Get-Content -LiteralPath 'sql/03_verificar.sql' -Raw -Encoding UTF8 |
    docker exec -i tas4_mysql sh -c 'MYSQL_PWD=$MYSQL_ROOT_PASSWORD mysql -uroot'
if ($LASTEXITCODE -ne 0) { throw 'Falló la verificación de datos.' }
