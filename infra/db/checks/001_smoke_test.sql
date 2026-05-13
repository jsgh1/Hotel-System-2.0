-- Smoke test del sistema hotelero
-- Verifica tablas base, autenticacion SQL y usuario semilla del instructor.

SELECT table_schema AS schema_name,
       COUNT(*) AS base_tables
FROM information_schema.tables
WHERE table_schema IN (
    'configuration',
    'security',
    'distribution',
    'service_delivery',
    'inventory',
    'billing',
    'notification',
    'maintenance'
)
AND table_type = 'BASE TABLE'
GROUP BY table_schema
ORDER BY table_schema;

SELECT COUNT(*) AS total_schemas
FROM information_schema.schemata
WHERE schema_name IN (
    'configuration',
    'security',
    'distribution',
    'service_delivery',
    'inventory',
    'billing',
    'notification',
    'maintenance'
);

SELECT current_user AS authenticated_user,
       session_user AS session_user;

SELECT username,
       locked,
       status
FROM security.app_user
WHERE username = 'ariel5253';

SELECT 'smoke_test_ok' AS status;
