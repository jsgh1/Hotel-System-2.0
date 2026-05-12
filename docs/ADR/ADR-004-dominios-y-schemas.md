# ADR-004: Separacion por dominios y schemas

## Contexto

Si toda la base queda en un solo schema, el mantenimiento se vuelve confuso y es facil mezclar responsabilidades.

## Decision

Cada dominio funcional se implementa en su propio schema PostgreSQL.

## Consecuencias

- La lectura del modelo mejora mucho.
- Los cambios por dominio quedan mas aislados.
- La documentacion y la carga con Liquibase se vuelven mas previsibles.
