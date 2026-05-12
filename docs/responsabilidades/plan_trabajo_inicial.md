# Plan de trabajo inicial

**Proyecto:** Sistema hotelero
**Meta:** entregar una base PostgreSQL con scripts ordenados, datos semilla, seguridad controlada y evidencia de ejecucion.

## Enfoque

| Frente | HU | Resultado esperado | Responsable sugerido |
| --- | --- | --- | --- |
| Gobierno, automatizacion y decisiones | HU-01 a HU-05 | Ramas, tablero, `.github` y ADR. | Juan |
| Ambiente ejecutable | HU-06 a HU-08 | Docker, PostgreSQL, Liquibase y DDL base. | Oscar |
| Modelo fisico | HU-09 a HU-14 | Tablas y objetos avanzados por dominio. | Oscar / Stiven |
| Datos y seguridad | HU-15 a HU-22 | DML, autenticacion, DCL, policies, TCL y rollbacks. | Stiven / Jose |
| Cierre y evidencia | HU-23 | Smoke test, guia de ejecucion y validacion final. | Juan |

## Criterios de cierre

- PostgreSQL es el motor oficial de la entrega.
- Los schemas estan separados por dominio.
- Los UUID son la clave principal en todas las tablas nuevas.
- Liquibase controla el orden de carga.
- Los archivos `.gitkeep` se conservan donde hay carpetas vacias.
- La documentacion indica exactamente donde se ejecuta cada cosa.
