$dbUser = if ($env:POSTGRES_USER) { $env:POSTGRES_USER } else { "postgres" };
$dbPassword = if ($env:POSTGRES_PASSWORD) { "$env:POSTGRES_PASSWORD" } else { "password" };
$dbName = if ($env:POSTGRES_DB) { "$env:POSTGRES_DB" } else { "newsletter" };
$dbPort = if ($env:POSTGRES_PORT) { "$env:POSTGRES_PORT" } else { "5432" };

if (-not (Test-Path env:SKIP_DOCKER)) {
    docker run `
        -e POSTGRES_USER=$dbUser `
        -e POSTGRES_PASSWORD=$dbPassword `
        -e POSTGRES_DB=$dbName `
        -p "$($dbPort):5432" `
        --name postgres `
        -d postgres `
        postgres -N 1000
}

while ($true) {
    docker exec -it postgres psql -U ${dbUser} -d ${dbName} -c 'SELECT 1' | Out-Null
    if ($?) {
        break
    }
    Write-Host -ForegroundColor DarkYellow "Postgres is still unavailable - sleeping"
    Start-Sleep -Seconds 1.0
}

Write-Host -ForegroundColor Green "Postgres is up and running on port ${dbPort}!"

$env:DATABASE_URL="postgres://${dbUser}:${dbPassword}@localhost:${dbPort}/${dbName}"
sqlx database create
sqlx migrate run

Write-Host -ForegroundColor Green "Postgres has been migrated, ready to go!"
