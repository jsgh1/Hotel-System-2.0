CREATE OR REPLACE VIEW security.v_user_roles AS
SELECT
  u.id AS app_user_id,
  u.username,
  p.name || ' ' || p.last_name AS person,
  r.name AS role,
  u.locked,
  u.status
FROM security.app_user u
JOIN configuration.person p ON p.id = u.person_id
LEFT JOIN security.app_user_role ur ON ur.app_user_id = u.id
LEFT JOIN security.role r ON r.id = ur.role_id;
