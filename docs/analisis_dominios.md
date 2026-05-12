# Analisis de dominios

## Objetivo

Organizar la base de datos del sistema hotelero en dominios funcionales, con schemas PostgreSQL separados y nombres tecnicos en ingles.

## Criterios usados

- Un dominio debe agrupar tablas que comparten reglas de negocio.
- Un schema no debe mezclar configuracion con operacion, seguridad o facturacion.
- Cada HU tecnica debe caer en un dominio claro.
- La estructura debe servir para Liquibase y para mantenimiento futuro.

## Dominios oficiales

| # | Dominio | Schema | Carpeta DDL | Funcion principal |
| --- | --- | --- | --- | --- |
| 1 | configuration | `configuration` | `infra/db/01_ddl/03_tables/configuration/` | Catalogos maestros, clientes, empresa y metadatos base. |
| 2 | security | `security` | `infra/db/01_ddl/03_tables/security/` | Usuarios, roles, permisos, modulos y relaciones de acceso. |
| 3 | distribution | `distribution` | `infra/db/01_ddl/03_tables/distribution/` | Sedes, habitaciones, tipos y estados. |
| 4 | service_delivery | `service_delivery` | `infra/db/01_ddl/03_tables/service_delivery/` | Reservas, cancelaciones, check in, check out y estadias. |
| 5 | inventory | `inventory` | `infra/db/01_ddl/03_tables/inventory/` | Productos, servicios, proveedores y seguimiento de stock. |
| 6 | billing | `billing` | `infra/db/01_ddl/03_tables/billing/` | Prefacturacion, facturacion, pagos y detalle de compra. |
| 7 | notification | `notification` | `infra/db/01_ddl/03_tables/notification/` | Promociones, alertas, terminos, condiciones y fidelizacion. |
| 8 | maintenance | `maintenance` | `infra/db/01_ddl/03_tables/maintenance/` | Mantenimiento de habitaciones, uso, remodelacion y tablero operativo. |

## Relacion entre dominios y modelos

Configuration sostiene a varios dominios. Distribution alimenta service_delivery. Inventory se conecta con billing y service_delivery. Security protege todo el acceso. Notification y maintenance quedan separadas para no contaminar la operacion principal.

## Regla de organizacion

La entrega mantiene una sola version de cada objeto por dominio. Si una tabla requiere indexes, functions, procedures o triggers, esos objetos viven en su carpeta propia y no se mezclan con la DDL basica.
