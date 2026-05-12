# ADR-005: Liquibase, versionamiento y contenerizacion Docker

## Contexto

La entrega necesita poder levantarse de forma repetible sin depender de pasos manuales poco controlados.

## Decision

Liquibase gestiona migraciones y Docker levanta PostgreSQL y los contenedores de apoyo.

## Consecuencias

- La base se puede reconstruir desde cero.
- Los cambios quedan versionados por archivos.
- El entorno local se vuelve mas cercano a la entrega final.
