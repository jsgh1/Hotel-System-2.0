param(
    [string]$Host = "localhost",
    [int]$Port = 5445,
    [string]$Database = "sistema_hotelero",
    [string]$DatabaseUser = "postgres",
    [string]$DatabasePassword = "postgres",
    [string]$LiquibaseImage = "liquibase/liquibase:4.25",
    [string]$Changelog = "changelog/changelog-master.yaml"
)

$ErrorActionPreference = 'Stop'

Write-Host "Running Liquibase update against $Host:$Port/$Database as $DatabaseUser"

docker run --rm `
    -e PGPASSWORD=$DatabasePassword `
    --network host `
    -v "${PWD}:/liquibase/workspace" `
    -w /liquibase/workspace `
    $LiquibaseImage `
    liquibase `
    --url="jdbc:postgresql://$Host:$Port/$Database" `
    --username=$DatabaseUser `
    --password=$DatabasePassword `
    --changeLogFile=$Changelog `
    update
