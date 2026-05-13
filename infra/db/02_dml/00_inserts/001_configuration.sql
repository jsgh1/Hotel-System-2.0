SET search_path TO configuration, public;

INSERT INTO configuration.company (id, name, tax_id, legal_name, phone, email, address, website, status)
SELECT '11111111-1111-1111-1111-111111111101'::uuid, 'Hotel Demo', '900000000-1', 'Hotel Demo S.A.S.', '3000000000', 'contacto@hoteldemo.local', 'Main address', 'https://hoteldemo.local', 'ACTIVE'::configuration.record_status
WHERE NOT EXISTS (
  SELECT 1 FROM configuration.company c WHERE c.id = '11111111-1111-1111-1111-111111111101'::uuid
);

INSERT INTO configuration.day_type (id, name, description, applies_season, applies_holiday, applies_special, status)
VALUES
  ('11111111-1111-1111-1111-111111111102'::uuid, 'WEEKDAY', 'Regular weekday operating day', false, false, false, 'ACTIVE'::configuration.record_status),
  ('11111111-1111-1111-1111-111111111103'::uuid, 'WEEKEND', 'Weekend day', false, false, false, 'ACTIVE'::configuration.record_status),
  ('11111111-1111-1111-1111-111111111104'::uuid, 'HOLIDAY', 'Holiday', false, true, false, 'ACTIVE'::configuration.record_status),
  ('11111111-1111-1111-1111-111111111105'::uuid, 'HIGH_SEASON', 'High season rule day', true, false, false, 'ACTIVE'::configuration.record_status)
ON CONFLICT DO NOTHING;

INSERT INTO configuration.payment_method (id, name, description, requires_reference, allows_partial_payment, status)
VALUES
  ('11111111-1111-1111-1111-111111111106'::uuid, 'CASH', 'Cash payment', false, true, 'ACTIVE'::configuration.record_status),
  ('11111111-1111-1111-1111-111111111107'::uuid, 'CARD', 'Debit or credit card payment', true, true, 'ACTIVE'::configuration.record_status),
  ('11111111-1111-1111-1111-111111111108'::uuid, 'BANK_TRANSFER', 'Bank transfer payment', true, true, 'ACTIVE'::configuration.record_status)
ON CONFLICT DO NOTHING;

INSERT INTO configuration.person (id, document_type, document_number, name, last_name, phone, email, status)
VALUES
  ('11111111-1111-1111-1111-111111111109'::uuid, 'CC', '52530001', 'Ariel', 'Administrator', '3005253001', 'ariel5253@example.local', 'ACTIVE'::configuration.record_status),
  ('11111111-1111-1111-1111-111111111110'::uuid, 'CC', '52530002', 'Front Desk', 'Demo', '3005253002', 'recepcion@example.local', 'ACTIVE'::configuration.record_status),
  ('11111111-1111-1111-1111-111111111111'::uuid, 'CC', '52530003', 'House Keeping', 'Demo', '3005253003', 'housekeeping@example.local', 'ACTIVE'::configuration.record_status)
ON CONFLICT DO NOTHING;

INSERT INTO configuration.customer (id, document_type, document_number, name, last_name, phone, email, address, status)
VALUES
  ('11111111-1111-1111-1111-111111111112'::uuid, 'CC', '100000001', 'Sofia', 'Martinez', '3001112233', 'sofia.martinez@example.local', 'Street 10 # 1-20', 'ACTIVE'::configuration.record_status),
  ('11111111-1111-1111-1111-111111111113'::uuid, 'CC', '100000002', 'Carlos', 'Rojas', '3002223344', 'carlos.rojas@example.local', 'Avenue 15 # 30-50', 'ACTIVE'::configuration.record_status),
  ('11111111-1111-1111-1111-111111111114'::uuid, 'CC', '100000003', 'Paula', 'Lopez', '3003334455', 'paula.lopez@example.local', 'Street 50 # 5-10', 'ACTIVE'::configuration.record_status)
ON CONFLICT DO NOTHING;

INSERT INTO configuration.legal_information (id, company_id, legal_document_type, legal_document_number, description, issue_date, expiration_date, status)
SELECT '11111111-1111-1111-1111-111111111115'::uuid, c.id, 'RNT', 'RNT-001', 'Tourism registry', DATE '2026-01-01', NULL, 'ACTIVE'::configuration.record_status
FROM configuration.company c
WHERE c.id = '11111111-1111-1111-1111-111111111101'::uuid
  AND NOT EXISTS (SELECT 1 FROM configuration.legal_information li WHERE li.id = '11111111-1111-1111-1111-111111111115'::uuid);

INSERT INTO configuration.employee (id, person_id, position, hire_date, work_phone, work_email, status)
SELECT '11111111-1111-1111-1111-111111111116'::uuid, p.id, 'Administrator', DATE '2026-01-01', '3005253001', 'ariel5253@hotel.local', 'ACTIVE'::configuration.record_status
FROM configuration.person p
WHERE p.document_number = '52530001'
  AND NOT EXISTS (SELECT 1 FROM configuration.employee e WHERE e.id = '11111111-1111-1111-1111-111111111116'::uuid);

INSERT INTO configuration.employee (id, person_id, position, hire_date, work_phone, work_email, status)
SELECT '11111111-1111-1111-1111-111111111117'::uuid, p.id, 'Receptionist', DATE '2026-01-02', '3005253002', 'recepcion@hotel.local', 'ACTIVE'::configuration.record_status
FROM configuration.person p
WHERE p.document_number = '52530002'
  AND NOT EXISTS (SELECT 1 FROM configuration.employee e WHERE e.id = '11111111-1111-1111-1111-111111111117'::uuid);
