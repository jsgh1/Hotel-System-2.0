# Historias de usuario - Entrega de base de datos

Este backlog organiza la entrega tecnica de la base del sistema hotelero. La meta es dejar una base PostgreSQL ejecutable, documentada y trazable por Liquibase, con dominios separados y convenciones en ingles.

## Lectura del backlog

| Campo | Uso |
| --- | --- |
| ID | Consecutivo para seguimiento y tablero. |
| Necesidad | Lo que debe resolverse en la entrega. |
| Entregable | Archivo, carpeta o evidencia esperada. |
| Aceptacion | Condicion minima para cerrar la historia. |

## Gobierno del trabajo y decisiones

| ID | Necesidad | Entregable | Aceptacion |
| -- | --------- | ---------- | ---------- |
| HU-00 | Como equipo, necesitamos una estructura vacia y organizada antes de subir scripts y migraciones. | `.github/`, `docs/`, `infra/db/` y subcarpetas base con `.gitkeep`. | Todos los integrantes identifican donde subir sus archivos sin mezclar responsabilidades. |
| HU-01 | Como equipo, necesitamos acordar un flujo de ramas que evite mezclar cambios. | Reglas de `dev`, `qa` y `main`; convencion de ramas `feature/hu-XX`. | Cada cambio se sube por rama hija y con revision previa. |
| HU-02 | Como equipo, necesitamos una ruta de trabajo visible para saber que se hizo y que falta. | `docs/responsabilidades/`, `Historias de usuario.md`, `matriz_trazabilidad_hu.md`, `que_subir_y_que_no_subir.md`. | El avance queda explicado, asignado y rastreable. |
| HU-03 | Como analistas, necesitamos cerrar los dominios funcionales antes de definir schemas y tablas. | `docs/analisis_dominios.md`. | Quedan definidos 8 dominios oficiales, sin mezclar responsabilidades. |
| HU-04 | Como equipo tecnico, necesitamos justificar decisiones de arquitectura de datos. | Carpeta `docs/ADR/` con 6 decisiones clave. | Cada ADR explica contexto, decision, consecuencias y criterio de uso. |
| HU-05 | Como equipo, necesitamos automatizar validaciones basicas para que cada subida revise estructura, migraciones y una prueba minima. | `.github/workflows/db-ci.yml`, `infra/db/checks/001_smoke_test.sql` y `infra/db/scripts/load-database.ps1`. | El workflow valida la estructura, ejecuta Liquibase, prueba rollback y corre el smoke test. |

## Ambiente ejecutable

| ID | Necesidad | Entregable | Aceptacion |
| -- | --------- | ---------- | ---------- |
| HU-06 | Como desarrolladores, necesitamos levantar PostgreSQL sin configuraciones manuales pesadas. | `infra/db/docker/docker-compose.yml`. | La base publica el puerto definido y puede arrancar en local. |
| HU-07 | Como equipo, necesitamos aplicar migraciones de forma ordenada y repetible. | `infra/db/liquibase.properties`, `infra/db/changelog/changelog-master.yaml` y `infra/db/changelog/changelog-master.sql`. | Liquibase ejecuta el flujo completo en el orden correcto. |
| HU-08 | Como equipo, necesitamos una base DDL inicial con extensiones, schemas, tipos y auditoria. | `infra/db/01_ddl/00_extensions`, `01_schemas`, `02_types`, `03_tables`. | La base usa UUID, separa schemas y deja auditoria consistente. |

## Modelo fisico por dominios

| ID | Necesidad | Entregable | Aceptacion |
| -- | --------- | ---------- | ---------- |
| HU-09 | Como equipo operativo, necesitamos persistir configuration y security. | `infra/db/01_ddl/03_tables/configuration/` y `infra/db/01_ddl/03_tables/security/`. | Las tablas comparten convenciones, llaves y audit trail. |
| HU-10 | Como equipo de operaciones, necesitamos registrar distribution y service delivery. | `infra/db/01_ddl/03_tables/distribution/` y `infra/db/01_ddl/03_tables/service_delivery/`. | La estructura soporta disponibilidad, reservas, check in y check out. |
| HU-11 | Como administracion, necesitamos registrar inventory y billing. | `infra/db/01_ddl/03_tables/inventory/` y `infra/db/01_ddl/03_tables/billing/`. | El ciclo de productos, servicios, prefactura, factura y pagos queda cubierto. |
| HU-12 | Como operacion, necesitamos mantener notification y maintenance separados. | `infra/db/01_ddl/03_tables/notification/` y `infra/db/01_ddl/03_tables/maintenance/`. | Las tablas de comunicaciones y mantenimiento no se mezclan con los dominios criticos. |

## Objetos derivados y automatizacion

| ID | Necesidad | Entregable | Aceptacion |
| -- | --------- | ---------- | ---------- |
| HU-13 | Como equipo, necesitamos consultas reutilizables para operacion y reportes. | `infra/db/01_ddl/04_views/`, `05_materialized_views/`, `06_functions/`. | Las vistas y funciones quedan disponibles para consumo del sistema. |
| HU-14 | Como equipo, necesitamos automatizar reglas y optimizaciones. | `infra/db/01_ddl/07_procedures/`, `08_triggers/`, `09_indexes/`. | Los procedimientos, triggers e indexes soportan integridad y rendimiento. |

## Datos semilla y seguridad

| ID | Necesidad | Entregable | Aceptacion |
| -- | --------- | ---------- | ---------- |
| HU-15 | Como equipo, necesitamos datos canonicos iniciales para configuration y security. | `infra/db/02_dml/00_inserts/001_configuration.sql`, `002_security.sql`. | Existen los registros base para validar catalogos y acceso. |
| HU-16 | Como equipo, necesitamos datos canonicos para distribution y service delivery. | `infra/db/02_dml/00_inserts/003_distribution.sql`, `004_service_delivery.sql`. | Las sedes, habitaciones y reservas de ejemplo quedan listas. |
| HU-17 | Como equipo, necesitamos datos canonicos para inventory y billing. | `infra/db/02_dml/00_inserts/005_inventory.sql`, `006_billing.sql`. | Los productos, servicios y comprobantes de ejemplo quedan listos. |
| HU-18 | Como equipo, necesitamos datos canonicos para notification y maintenance. | `infra/db/02_dml/00_inserts/007_notification.sql`, `008_maintenance.sql`. | Existen alertas, promociones y mantenimiento demo. |
| HU-19 | Como equipo, necesitamos un rol de base para el instructor que solo ejecute DDL y DML. | `infra/db/03_dcl/00_roles/001_access_role.sql`. | El usuario `ariel5253` existe con acceso limitado y sin privilegios DCL. |
| HU-20 | Como equipo, necesitamos grants consistentes para schemas y objetos. | `infra/db/03_dcl/01_grants/001_grants.sql`. | El rol instructor puede operar las tablas permitidas sin administrar usuarios. |
| HU-21 | Como equipo, necesitamos dejar preparado el espacio para politicas de acceso futuro. | `infra/db/03_dcl/02_policies/001_policies.sql`. | El archivo existe, carga sin error y deja listo el punto de extension. |
| HU-22 | Como equipo, necesitamos bloques transaccionales y respaldos para recuperacion. | `infra/db/04_tcl/00_transaction_blocks/001_safe_load.sql`, `01_manual_recoveries/001_refresh_materialized_views.sql`, `infra/db/05_rollbacks/`. | La carga segura y los respaldos existen y no rompen el flujo. |
| HU-23 | Como equipo, necesitamos una prueba minima de salud de la base. | `infra/db/checks/001_smoke_test.sql`, `infra/db/scripts/load-database.ps1`. | La prueba confirma schemas, tablas y el usuario instructor. |
