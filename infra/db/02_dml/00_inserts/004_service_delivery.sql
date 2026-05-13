SET search_path TO service_delivery, public;

INSERT INTO service_delivery.room_reservation (id, customer_id, room_id, start_date, end_date, guest_count, reservation_status, estimated_amount, status)
SELECT '44444444-4444-4444-4444-444444444441'::uuid, c.id, r.id, now() + interval '7 days', now() + interval '10 days', 1, 'CONFIRMED'::service_delivery.reservation_status, 360000, 'ACTIVE'::configuration.record_status
FROM configuration.customer c
JOIN distribution.room r ON r.number = '101'
WHERE c.document_number = '100000001'
  AND NOT EXISTS (SELECT 1 FROM service_delivery.room_reservation rr WHERE rr.id = '44444444-4444-4444-4444-444444444441'::uuid);

INSERT INTO service_delivery.room_reservation (id, customer_id, room_id, start_date, end_date, guest_count, reservation_status, estimated_amount, status)
SELECT '44444444-4444-4444-4444-444444444442'::uuid, c.id, r.id, now() + interval '15 days', now() + interval '17 days', 2, 'CANCELED'::service_delivery.reservation_status, 360000, 'ACTIVE'::configuration.record_status
FROM configuration.customer c
JOIN distribution.room r ON r.number = '102'
WHERE c.document_number = '100000002'
  AND NOT EXISTS (SELECT 1 FROM service_delivery.room_reservation rr WHERE rr.id = '44444444-4444-4444-4444-444444444442'::uuid);

INSERT INTO service_delivery.room_cancellation (id, room_reservation_id, reason, applies_penalty, penalty_amount, status)
SELECT '44444444-4444-4444-4444-444444444443'::uuid, rr.id, 'Guest requested cancellation', false, 0, 'ACTIVE'::configuration.record_status
FROM service_delivery.room_reservation rr
WHERE rr.id = '44444444-4444-4444-4444-444444444442'::uuid
  AND NOT EXISTS (SELECT 1 FROM service_delivery.room_cancellation rc WHERE rc.id = '44444444-4444-4444-4444-444444444443'::uuid);

INSERT INTO service_delivery.stay (id, room_reservation_id, customer_id, room_id, start_date, end_date, stay_status, status)
SELECT '44444444-4444-4444-4444-444444444444'::uuid, rr.id, rr.customer_id, rr.room_id, now() + interval '7 days', NULL, 'ACTIVE'::service_delivery.stay_status, 'ACTIVE'::configuration.record_status
FROM service_delivery.room_reservation rr
WHERE rr.id = '44444444-4444-4444-4444-444444444441'::uuid
  AND NOT EXISTS (SELECT 1 FROM service_delivery.stay s WHERE s.id = '44444444-4444-4444-4444-444444444444'::uuid);

INSERT INTO service_delivery.check_in (id, room_reservation_id, employee_id, event_at, note, status)
SELECT '44444444-4444-4444-4444-444444444445'::uuid, rr.id, e.id, now() + interval '7 days 2 hours', 'Guest checked in at reception', 'ACTIVE'::configuration.record_status
FROM service_delivery.room_reservation rr
JOIN configuration.employee e ON e.work_email = 'ariel5253@hotel.local'
WHERE rr.id = '44444444-4444-4444-4444-444444444441'::uuid
  AND NOT EXISTS (SELECT 1 FROM service_delivery.check_in ci WHERE ci.id = '44444444-4444-4444-4444-444444444445'::uuid);

INSERT INTO service_delivery.check_out (id, stay_id, employee_id, event_at, note, status)
SELECT '44444444-4444-4444-4444-444444444446'::uuid, s.id, e.id, now() + interval '10 days 1 hour', 'Guest checkout planned', 'ACTIVE'::configuration.record_status
FROM service_delivery.stay s
JOIN configuration.employee e ON e.work_email = 'ariel5253@hotel.local'
WHERE s.id = '44444444-4444-4444-4444-444444444444'::uuid
  AND NOT EXISTS (SELECT 1 FROM service_delivery.check_out co WHERE co.id = '44444444-4444-4444-4444-444444444446'::uuid);
