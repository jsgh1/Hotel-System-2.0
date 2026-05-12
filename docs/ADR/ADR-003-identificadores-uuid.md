# ADR-003: Identificadores UUID en lugar de bigint

## Contexto

El modelo anterior dependia de identificadores numericos secuenciales. Para una entrega moderna y distribuible conviene usar UUID como clave principal.

## Decision

Todas las tablas nuevas usan UUID como llave primaria y para referencias entre entidades.

## Consecuencias

- Menor dependencia de secuencias locales.
- Mejor compatibilidad con sistemas distribuidos y migraciones futuras.
- Las tablas de auditoria tambien referencian UUID.
