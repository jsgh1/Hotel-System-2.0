# Tablero de responsabilidades y flujo de trabajo

## Regla principal

Nadie aprueba ni fusiona su propia rama. La revision siempre la hace otra persona del grupo.

## Flujo de ramas

`feature/hu-XX-* -> dev -> qa -> main`

## Normas por etapa

| Etapa | Rama base | Revision | Merge |
| --- | --- | --- | --- |
| Desarrollo | feature/hu-XX-* | Otro integrante | Otro integrante |
| Integracion | dev | Revisor asignado | Revisor asignado |
| Calidad | qa | Revisor distinto al autor | Revisor distinto al autor |
| Entrega final | main | Revisor final | Revisor final |

## Reparto de trabajo

| Integrante | HUs sugeridas | Foco |
| --- | --- | --- |
| Juan | HU-00, HU-01, HU-02, HU-03, HU-04, HU-05, HU-23 | Estructura base, `.github`, documentacion, ADR y cierre. |
| Oscar | HU-06, HU-07, HU-08, HU-09, HU-10, HU-11 | Ambiente y DDL base. |
| Stiven | HU-12, HU-13, HU-14, HU-15, HU-16, HU-17 | Modelo fisico y DML inicial. |
| Jose | HU-18, HU-19, HU-20, HU-21, HU-22 | DML restante, autenticacion, DCL y TCL. |

## Convencion sugerida de ramas

- `feature/hu-01-flujo-ramas`
- `feature/hu-06-docker-postgres`
- `feature/hu-15-dml-configuration`

Cada rama debe incluir un mensaje de commit claro y una referencia directa a la HU trabajada.

## Orden sugerido de subida

1. Juan sube primero la estructura vacia `.github`, `docs` e `infra/db` con las carpetas base.
2. Oscar continua con Docker, Liquibase y DDL base.
3. Stiven completa los dominios y DML.
4. Jose cierra seguridad, TCL y rollbacks.
