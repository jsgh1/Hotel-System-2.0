# Seguimientos

## Estado inicial de la entrega

| Aspecto | Estado | Observacion |
| --- | --- | --- |
| Dominios | Preparado | Se definieron 8 dominios oficiales. |
| Arquitectura de datos | Preparado | Los schemas y carpetas respetan la separacion funcional. |
| PostgreSQL | Preparado | La base trabaja con UUID y `pgcrypto`. |
| Liquibase | Preparado | El changelog maestro organiza la carga. |
| Docker | Preparado | Existe un compose para levantar la base. |
| DML / DCL / TCL | En revision | Deben cargarse con el orden definido en la documentacion. |
| Smoke test | Preparado | La prueba base valida conteos y permisos principales. |

## Seguimiento por frentes

- Juan: gobierno, ADR y cierre documental.
- Oscar: infraestructura, DDL base y objetos de consulta.
- Stiven: DDL por dominios y primeras cargas.
- Jose: seguridad, permisos, transacciones y validacion.

## Pendientes habituales

- Verificar que cada archivo SQL tenga su changelog asociado.
- Confirmar que los nombres de los schemas coinciden con los de la documentacion.
- Revisar que no existan rutas rotas en los markdown.
- Confirmar que el usuario de prueba no tenga permisos excesivos.
