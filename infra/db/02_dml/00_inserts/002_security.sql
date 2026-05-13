SET search_path TO security, public;

INSERT INTO security.role (id, name, description, status)
VALUES
  ('22222222-2222-2222-2222-222222222201'::uuid, 'ADMINISTRATOR', 'Full access demo role', 'ACTIVE'::configuration.record_status),
  ('22222222-2222-2222-2222-222222222202'::uuid, 'INSTRUCTOR', 'Instructor role for DDL and DML validation', 'ACTIVE'::configuration.record_status),
  ('22222222-2222-2222-2222-222222222203'::uuid, 'FRONT_DESK', 'Reception and check-in role', 'ACTIVE'::configuration.record_status)
ON CONFLICT DO NOTHING;

INSERT INTO security.permission (id, name, description, action, status)
VALUES
  ('22222222-2222-2222-2222-222222222211'::uuid, 'CONFIG_READ', 'Read configuration catalogs', 'SELECT', 'ACTIVE'::configuration.record_status),
  ('22222222-2222-2222-2222-222222222212'::uuid, 'CONFIG_WRITE', 'Modify configuration catalogs', 'WRITE', 'ACTIVE'::configuration.record_status),
  ('22222222-2222-2222-2222-222222222213'::uuid, 'ROOM_OPERATE', 'Operate rooms and reservations', 'WRITE', 'ACTIVE'::configuration.record_status),
  ('22222222-2222-2222-2222-222222222214'::uuid, 'BILLING_VIEW', 'View billing documents', 'SELECT', 'ACTIVE'::configuration.record_status)
ON CONFLICT DO NOTHING;

INSERT INTO security.module (id, name, description, base_path, status)
VALUES
  ('22222222-2222-2222-2222-222222222221'::uuid, 'CONFIGURATION', 'Catalog management module', '/configuration', 'ACTIVE'::configuration.record_status),
  ('22222222-2222-2222-2222-222222222222'::uuid, 'OPERATIONS', 'Hotel operations module', '/operations', 'ACTIVE'::configuration.record_status)
ON CONFLICT DO NOTHING;

INSERT INTO security.screen (id, module_id, name, description, path, status)
SELECT v.screen_id, m.id, v.screen_name, v.description, v.path, v.status
FROM (
  VALUES
    ('22222222-2222-2222-2222-222222222231'::uuid, 'CONFIGURATION', 'Catalogs', 'Catalog maintenance screen', '/configuration/catalogs', 'ACTIVE'::configuration.record_status),
    ('22222222-2222-2222-2222-222222222232'::uuid, 'CONFIGURATION', 'Users', 'Security users screen', '/configuration/users', 'ACTIVE'::configuration.record_status),
    ('22222222-2222-2222-2222-222222222233'::uuid, 'OPERATIONS', 'Reservations', 'Reservation management screen', '/operations/reservations', 'ACTIVE'::configuration.record_status),
    ('22222222-2222-2222-2222-222222222234'::uuid, 'OPERATIONS', 'Billing', 'Billing screen', '/operations/billing', 'ACTIVE'::configuration.record_status)
) AS v(screen_id, module_name, screen_name, description, path, status)
JOIN security.module m ON m.name = v.module_name
WHERE NOT EXISTS (SELECT 1 FROM security.screen s WHERE s.id = v.screen_id);

INSERT INTO security.app_user (id, person_id, username, password_hash, last_access_at, locked, status)
SELECT '22222222-2222-2222-2222-222222222241'::uuid, p.id, 'ariel5253', crypt('ariel5253', gen_salt('bf')), now(), false, 'ACTIVE'::configuration.record_status
FROM configuration.person p
WHERE p.document_number = '52530001'
  AND NOT EXISTS (SELECT 1 FROM security.app_user au WHERE au.username = 'ariel5253');

INSERT INTO security.app_user_role (id, app_user_id, role_id, status)
SELECT '22222222-2222-2222-2222-222222222251'::uuid, au.id, r.id, 'ACTIVE'::configuration.record_status
FROM security.app_user au
JOIN security.role r ON r.name = 'INSTRUCTOR'
WHERE au.username = 'ariel5253'
  AND NOT EXISTS (SELECT 1 FROM security.app_user_role aur WHERE aur.id = '22222222-2222-2222-2222-222222222251'::uuid);

INSERT INTO security.role_permission (id, role_id, permission_id, status)
SELECT v.link_id, r.id, p.id, v.status
FROM (
  VALUES
    ('22222222-2222-2222-2222-222222222261'::uuid, 'INSTRUCTOR', 'CONFIG_READ', 'ACTIVE'::configuration.record_status),
    ('22222222-2222-2222-2222-222222222262'::uuid, 'INSTRUCTOR', 'CONFIG_WRITE', 'ACTIVE'::configuration.record_status),
    ('22222222-2222-2222-2222-222222222263'::uuid, 'INSTRUCTOR', 'ROOM_OPERATE', 'ACTIVE'::configuration.record_status),
    ('22222222-2222-2222-2222-222222222264'::uuid, 'INSTRUCTOR', 'BILLING_VIEW', 'ACTIVE'::configuration.record_status)
) AS v(link_id, role_name, permission_name, status)
JOIN security.role r ON r.name = v.role_name
JOIN security.permission p ON p.name = v.permission_name
WHERE NOT EXISTS (SELECT 1 FROM security.role_permission rp WHERE rp.id = v.link_id);

INSERT INTO security.module_screen (id, module_id, screen_id, status)
SELECT v.link_id, m.id, s.id, v.status
FROM (
  VALUES
    ('22222222-2222-2222-2222-222222222271'::uuid, 'CONFIGURATION', 'Catalogs', 'ACTIVE'::configuration.record_status),
    ('22222222-2222-2222-2222-222222222272'::uuid, 'CONFIGURATION', 'Users', 'ACTIVE'::configuration.record_status),
    ('22222222-2222-2222-2222-222222222273'::uuid, 'OPERATIONS', 'Reservations', 'ACTIVE'::configuration.record_status),
    ('22222222-2222-2222-2222-222222222274'::uuid, 'OPERATIONS', 'Billing', 'ACTIVE'::configuration.record_status)
) AS v(link_id, module_name, screen_name, status)
JOIN security.module m ON m.name = v.module_name
JOIN security.screen s ON s.name = v.screen_name
WHERE NOT EXISTS (SELECT 1 FROM security.module_screen ms WHERE ms.id = v.link_id);
