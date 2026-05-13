SET search_path TO distribution, public;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM distribution.room_status WHERE name = 'AVAILABLE') THEN
    INSERT INTO distribution.room_status (name, description, allows_reservation, allows_check_in)
    VALUES ('AVAILABLE', 'Room available for reservation', true, true);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM distribution.room_status WHERE name = 'OCCUPIED') THEN
    INSERT INTO distribution.room_status (name, description, allows_reservation, allows_check_in)
    VALUES ('OCCUPIED', 'Room occupied by a guest', false, false);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM distribution.room_status WHERE name = 'MAINTENANCE') THEN
    INSERT INTO distribution.room_status (name, description, allows_reservation, allows_check_in)
    VALUES ('MAINTENANCE', 'Room in maintenance', false, false);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM distribution.room_type WHERE name = 'SINGLE') THEN
    INSERT INTO distribution.room_type (name, description, base_capacity, max_capacity)
    VALUES ('SINGLE', 'Single room', 1, 1);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM distribution.room_type WHERE name = 'DOUBLE') THEN
    INSERT INTO distribution.room_type (name, description, base_capacity, max_capacity)
    VALUES ('DOUBLE', 'Double room', 2, 3);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM distribution.room_type WHERE name = 'SUITE') THEN
    INSERT INTO distribution.room_type (name, description, base_capacity, max_capacity)
    VALUES ('SUITE', 'Suite room', 2, 4);
  END IF;
END $$;

INSERT INTO distribution.branch (id, company_id, name, address, city, phone, email, status)
SELECT '33333333-3333-3333-3333-333333333331'::uuid, c.id, 'Central Branch', 'Main street 100', 'Bogota', '3003330001', 'central@hoteldemo.local', 'ACTIVE'::configuration.record_status
FROM configuration.company c
WHERE c.tax_id = '900000000-1'
  AND NOT EXISTS (SELECT 1 FROM distribution.branch b WHERE b.id = '33333333-3333-3333-3333-333333333331'::uuid);

INSERT INTO distribution.branch (id, company_id, name, address, city, phone, email, status)
SELECT '33333333-3333-3333-3333-333333333332'::uuid, c.id, 'North Branch', 'North avenue 200', 'Bogota', '3003330002', 'north@hoteldemo.local', 'ACTIVE'::configuration.record_status
FROM configuration.company c
WHERE c.tax_id = '900000000-1'
  AND NOT EXISTS (SELECT 1 FROM distribution.branch b WHERE b.id = '33333333-3333-3333-3333-333333333332'::uuid);

WITH rt AS (
  SELECT id, name FROM distribution.room_type
), rs AS (
  SELECT id, name FROM distribution.room_status
), br AS (
  SELECT id, name FROM distribution.branch
)
INSERT INTO distribution.room (id, branch_id, room_type_id, room_status_id, number, floor, capacity, description, status)
SELECT v.room_id, br.id, rt.id, rs.id, v.number, v.floor, v.capacity, v.description, v.status
FROM (
  VALUES
    ('33333333-3333-3333-3333-333333333341'::uuid, 'Central Branch', 'SINGLE', 'AVAILABLE', '101', 1, 1, 'Single room first floor', 'ACTIVE'::configuration.record_status),
    ('33333333-3333-3333-3333-333333333342'::uuid, 'Central Branch', 'DOUBLE', 'AVAILABLE', '102', 1, 2, 'Double room first floor', 'ACTIVE'::configuration.record_status),
    ('33333333-3333-3333-3333-333333333343'::uuid, 'North Branch', 'SUITE', 'MAINTENANCE', '201', 2, 4, 'Suite room second floor', 'ACTIVE'::configuration.record_status),
    ('33333333-3333-3333-3333-333333333344'::uuid, 'North Branch', 'DOUBLE', 'OCCUPIED', '202', 2, 3, 'Double room second floor', 'ACTIVE'::configuration.record_status)
) AS v(room_id, branch_name, room_type_name, status_name, number, floor, capacity, description, status)
JOIN br ON br.name = v.branch_name
JOIN rt ON rt.name = v.room_type_name
JOIN rs ON rs.name = v.status_name
WHERE NOT EXISTS (SELECT 1 FROM distribution.room r WHERE r.id = v.room_id);

INSERT INTO distribution.room_availability (id, room_id, start_date, end_date, available, unavailable_reason, status)
SELECT '33333333-3333-3333-3333-333333333351'::uuid, r.id, now(), now() + interval '30 days', true, NULL, 'ACTIVE'::configuration.record_status
FROM distribution.room r
WHERE r.number = '101' AND NOT EXISTS (SELECT 1 FROM distribution.room_availability ra WHERE ra.id = '33333333-3333-3333-3333-333333333351'::uuid);

INSERT INTO distribution.room_availability (id, room_id, start_date, end_date, available, unavailable_reason, status)
SELECT '33333333-3333-3333-3333-333333333352'::uuid, r.id, now(), now() + interval '30 days', true, NULL, 'ACTIVE'::configuration.record_status
FROM distribution.room r
WHERE r.number = '102' AND NOT EXISTS (SELECT 1 FROM distribution.room_availability ra WHERE ra.id = '33333333-3333-3333-3333-333333333352'::uuid);

INSERT INTO distribution.room_catalog (id, room_id, title, description, base_price, visible, status)
SELECT '33333333-3333-3333-3333-333333333361'::uuid, r.id, 'Comfort Single', 'Basic single room for one guest', 120000, true, 'ACTIVE'::configuration.record_status
FROM distribution.room r
WHERE r.number = '101' AND NOT EXISTS (SELECT 1 FROM distribution.room_catalog rc WHERE rc.id = '33333333-3333-3333-3333-333333333361'::uuid);

INSERT INTO distribution.room_catalog (id, room_id, title, description, base_price, visible, status)
SELECT '33333333-3333-3333-3333-333333333362'::uuid, r.id, 'Family Double', 'Double room with extra space', 180000, true, 'ACTIVE'::configuration.record_status
FROM distribution.room r
WHERE r.number = '102' AND NOT EXISTS (SELECT 1 FROM distribution.room_catalog rc WHERE rc.id = '33333333-3333-3333-3333-333333333362'::uuid);

INSERT INTO configuration.price (id, room_type_id, day_type_id, amount, start_date, end_date, condition_text, status)
SELECT '11111111-1111-1111-1111-111111111111'::uuid, rt.id, dt.id, 120000, DATE '2026-01-01', NULL, 'Standard single weekday price', 'ACTIVE'::configuration.record_status
FROM distribution.room_type rt
JOIN configuration.day_type dt ON dt.name = 'WEEKDAY'
WHERE rt.name = 'SINGLE' AND NOT EXISTS (SELECT 1 FROM configuration.price p WHERE p.id = '11111111-1111-1111-1111-111111111111'::uuid);

INSERT INTO configuration.price (id, room_type_id, day_type_id, amount, start_date, end_date, condition_text, status)
SELECT '11111111-1111-1111-1111-111111111112'::uuid, rt.id, dt.id, 180000, DATE '2026-01-01', NULL, 'Standard double weekday price', 'ACTIVE'::configuration.record_status
FROM distribution.room_type rt
JOIN configuration.day_type dt ON dt.name = 'WEEKDAY'
WHERE rt.name = 'DOUBLE' AND NOT EXISTS (SELECT 1 FROM configuration.price p WHERE p.id = '11111111-1111-1111-1111-111111111112'::uuid);

INSERT INTO configuration.price (id, room_type_id, day_type_id, amount, start_date, end_date, condition_text, status)
SELECT '11111111-1111-1111-1111-111111111113'::uuid, rt.id, dt.id, 240000, DATE '2026-01-01', NULL, 'Suite weekday price', 'ACTIVE'::configuration.record_status
FROM distribution.room_type rt
JOIN configuration.day_type dt ON dt.name = 'WEEKDAY'
WHERE rt.name = 'SUITE' AND NOT EXISTS (SELECT 1 FROM configuration.price p WHERE p.id = '11111111-1111-1111-1111-111111111113'::uuid);
