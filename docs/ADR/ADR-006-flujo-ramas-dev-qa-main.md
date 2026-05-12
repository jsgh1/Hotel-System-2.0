# ADR-006: Flujo de ramas dev -> qa -> main

## Contexto

La entrega necesita control de calidad y una ruta clara para que cada HU suba por etapas.

## Decision

Se usa el flujo `feature/* -> dev -> qa -> main`, con reglas de revision por otra persona y subida por HU hija.

## Consecuencias

- Cada integrante trabaja sin bloquear al resto.
- QA revisa antes de llegar a main.
- Las HUs quedan trazables por rama, commit y responsable.
