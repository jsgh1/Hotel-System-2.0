# Guía de ejecución y validación

## 📖 Documentación Recomendada

**Antes de ejecutar, lee estos documentos para entender qué estás levantando:**

1. **[Análisis Funcional Completo](analisis_funcional.md)** ⭐ - Arquitectura de 8 dominios, flujos de datos
2. **[Análisis de Dominios](analisis_dominios.md)** - Detalle de cada dominio funcional
3. **[Orden de Carga](orden_carga.md)** - Secuencia exacta de migraciones

## Requisitos

### Software Requerido
- **Docker** y **Docker Compose** (para el contenedor PostgreSQL)
- **PowerShell 5.1+** (si usas el script en Windows)
- **psql** opcional (cliente PostgreSQL para validación manual)

### Credenciales de Validación

| Usuario | Contraseña | Propósito |
| --- | --- | --- |
| `postgres` | `postgres` | Administrativo (solo desarrollo local) |
| `ariel5253` | `ariel5253` | Instructor/usuario de aplicación |

Estas credenciales se usan para:
- Levantar el contenedor PostgreSQL
- Ejecutar Liquibase (migraciones)
- Validar el smoke test
- Conectarse desde la aplicación

## 🚀 Orden Recomendado de Ejecución

### Opción 1: Script Automático (Recomendado - Windows)

```powershell
# Navega a la carpeta infra/db
cd infra/db

# Ejecuta el script de carga
.\scripts\load-database.ps1
```

El script:
1. ✅ Levanta PostgreSQL con Docker Compose
2. ✅ Espera a que PostgreSQL esté listo (~10 segundos)
3. ✅ Ejecuta Liquibase para todas las migraciones
4. ✅ Valida con el smoke test
5. ✅ Reporta éxito o error detallado

### Opción 2: Manual Paso a Paso (Linux/Mac/Windows)

#### Paso 1: Levantar PostgreSQL
```bash
cd infra/db/docker
docker compose up -d
```
Espera ~10 segundos a que PostgreSQL esté completamente listo.

#### Paso 2: Ejecutar Liquibase (Migraciones)
```bash
cd ..
liquibase --defaults-file=liquibase.properties update
```

Si Liquibase no está instalado, usa Docker:
```bash
docker compose -f docker/docker-compose.yml run --rm liquibase
```

#### Paso 3: Validar con Smoke Test
```bash
psql -U ariel5253 -h localhost -d sistema_hotelero -f checks/001_smoke_test.sql
```

O directamente en psql:
```bash
psql -U ariel5253 -h localhost -d sistema_hotelero
# Dentro de psql, ejecuta el contenido de checks/001_smoke_test.sql
```

#### Paso 4: Detenerse (Cuando Termines)
```bash
docker compose -f docker/docker-compose.yml down
```

### Opción 3: Docker Compose Completo

```bash
cd infra/db/docker
docker compose up -d

# Espera a que PostgreSQL esté listo
sleep 10

# Ejecuta Liquibase dentro del contenedor
docker compose run --rm liquibase

# El script de entrypoint ejecutará automáticamente el smoke test
```

## ✅ Validaciones Esperadas

Después de ejecutar, debes ver:

### Smoke Test Output
```
Schema configuration: 8 tablas
Schema security: 8 tablas
Schema distribution: 7 tablas
Schema service_delivery: 5 tablas
Schema inventory: 7 tablas
Schema billing: 4 tablas
Schema notification: 4 tablas
Schema maintenance: 4 tablas

Usuario ariel5253: EXISTS
Grants para ariel5253: OK

✅ Validación completada exitosamente
```

### Validaciones Específicas

#### 1. Schemas
```sql
SELECT schema_name FROM information_schema.schemata 
WHERE schema_name IN ('configuration', 'security', 'distribution', 
                     'service_delivery', 'inventory', 'billing', 
                     'notification', 'maintenance');
-- Deberías ver 8 resultados
```

#### 2. Tablas Clave
```sql
SELECT COUNT(*) FROM information_schema.tables 
WHERE table_schema IN ('configuration', 'security', 'distribution', 
                       'service_delivery', 'inventory', 'billing', 
                       'notification', 'maintenance');
-- Deberías ver ~50 tablas
```

#### 3. Usuario Instructor
```sql
SELECT * FROM security.app_user WHERE username = 'ariel5253';
-- Deberías ver 1 resultado
```

#### 4. Vistas
```sql
SELECT COUNT(*) FROM information_schema.views 
WHERE table_schema IN ('configuration', 'security', 'distribution', 
                       'service_delivery', 'inventory', 'billing', 
                       'notification', 'maintenance');
-- Deberías ver ~5 vistas
```

#### 5. UUID en PKs
```sql
SELECT table_name, column_name, data_type FROM information_schema.columns 
WHERE column_name = 'id' AND table_schema = 'configuration' LIMIT 5;
-- Deberías ver UUID en todas las PKs
```

## 🔍 Cómo Verificar Manualmente

Si quieres revisar específicamente:

```bash
# Conectarse a la base
psql -U ariel5253 -h localhost -d sistema_hotelero

# Dentro de psql:
\dn                     -- Listar schemas
\dt configuration.*     -- Tablas en configuration
\dv configuration.*     -- Vistas en configuration
SELECT current_user;    -- Quién soy
\dp configuration.*     -- Permisos actuales
```

## 🐛 Troubleshooting

### Error: "PostgreSQL connection refused"
```
Solución:
1. Verifica que Docker está corriendo: docker ps
2. Espera 20 segundos más (PostgreSQL tarda en iniciarse)
3. Revisa logs: docker logs sistema_hotelero_postgres
```

### Error: "liquibase: command not found"
```
Solución:
1. Instala Liquibase: https://www.liquibase.org/
2. O usa Docker: docker compose run --rm liquibase
3. O instala Java y descarga Liquibase
```

### Error: "Access denied for user 'ariel5253'"
```
Solución:
1. Verifica credenciales en infra/db/liquibase.properties
2. Asegúrate de que PostgreSQL está levantado
3. Reinicia el contenedor: docker compose down && docker compose up -d
```

### Error: "Table already exists"
```
Solución:
Liquibase evita crear tablas duplicadas. Si limpias la base:
docker compose down -v           -- Borra el volumen
docker compose up -d
```

## 📊 Qué Se Crea

Después de ejecutar, tienes:

```
Sistema PostgreSQL con:
├── 8 Schemas funcionales
├── ~50 Tablas de negocio
├── 5 Vistas de lectura
├── 2 Vistas materializadas
├── 4+ Funciones PostgreSQL
├── Procedimientos almacenados
├── Triggers de auditoría automática
├── Índices de optimización
├── 1 Usuario instructor (ariel5253)
├── Datos semilla en cada dominio
└── Auditoria completa de cambios
```

### Dominios Disponibles para Operación

| Dominio | Tablas | Propósito |
| --- | --- | --- |
| `configuration` | customer, company, employee, etc. | Catálogos maestros |
| `security` | app_user, role, permission, etc. | Control de acceso |
| `distribution` | branch, room, room_type, etc. | Sedes y habitaciones |
| `service_delivery` | room_reservation, stay, check_in, etc. | Reservas y hospedaje |
| `inventory` | product, service, supplier, etc. | Inventario |
| `billing` | invoice, pre_invoice, partial_payment | Facturación |
| `notification` | promotion, alert, customer_loyalty | Comunicaciones |
| `maintenance` | room_maintenance, maintenance_remodeling | Mantenimiento |

Para más detalles sobre qué hay en cada dominio, consulta [Análisis Funcional](analisis_funcional.md).

## 🔐 Seguridad Post-Setup

Después de verificar que funciona:

1. **Cambiar credenciales de producción**
   - El usuario `postgres` y contraseña `postgres` son SOLO para desarrollo local
   - Cambiar antes de mover a producción

2. **Revisar permisos**
   ```bash
   psql -U postgres
   \du                    -- Ver roles
   \dp schema.*           -- Ver grants
   ```

3. **Validar soft-delete**
   ```sql
   SELECT * FROM configuration.customer WHERE deleted_at IS NOT NULL;
   -- Deberías ver registros marcados como eliminados pero no borrados
   ```

## 📚 Próximos Pasos

Después de validar la base:

1. **Lee [Análisis Funcional](analisis_funcional.md)** para entender la arquitectura
2. **Integra con tu aplicación** usando credenciales `ariel5253`
3. **Carga datos reales** reemplazando los archivos en `infra/db/02_dml/00_inserts/`
4. **Implementa funciones de negocio** agregando stored procedures en `01_ddl/07_procedures/`
5. **Configura políticas RLS** extendiendo `03_dcl/02_policies/`

## ⏱️ Tiempos Esperados

| Paso | Tiempo |
| --- | --- |
| Levantar PostgreSQL | ~10 segundos |
| Ejecutar Liquibase (DDL) | ~15 segundos |
| Cargar datos (DML) | ~5 segundos |
| Validar (Smoke Test) | ~2 segundos |
| **Total** | ~32 segundos |

## 📞 Soporte

Si tienes problemas:

1. Revisa los logs del contenedor: `docker logs sistema_hotelero_postgres`
2. Revisa el archivo de trace de Liquibase
3. Verifica que Docker Compose tiene acceso a puertos (5432 debe estar libre)
4. Revisa [docs/que_subir_y_que_no_subir.md](que_subir_y_que_no_subir.md) para credenciales

---

**Última actualización:** Mayo 2026  
**Versión:** 1.0
