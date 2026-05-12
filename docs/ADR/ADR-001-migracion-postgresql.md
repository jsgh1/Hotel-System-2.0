# ADR-001: Migracion de MySQL a PostgreSQL

## Contexto

La base original estaba pensada para MySQL. Para esta entrega conviene estandarizar el motor en PostgreSQL porque el proyecto se entrega con Liquibase y una estructura por schemas.

## Decision

La base definitiva se implementa en PostgreSQL.

## Consecuencias

- Los scripts pasan a sintaxis PostgreSQL.
- Se usan schemas, funciones y tipos compatibles con el motor.
- Liquibase queda como herramienta de versionamiento.

## Resultado esperado

Una base mas ordenada para versionamiento, mantenimiento y despliegue reproducible.
