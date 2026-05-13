SET search_path TO notification, public;

INSERT INTO notification.promotion (id, title, description, start_date, end_date, channel, active, status)
VALUES
  ('77777777-7777-7777-7777-777777777771'::uuid, 'Welcome Offer', 'Discount for first time guests', now(), now() + interval '30 days', 'EMAIL'::notification.notification_channel, true, 'ACTIVE'::configuration.record_status),
  ('77777777-7777-7777-7777-777777777772'::uuid, 'Weekend Special', 'Weekend package promotion', now(), now() + interval '14 days', 'WHATSAPP'::notification.notification_channel, true, 'ACTIVE'::configuration.record_status)
ON CONFLICT DO NOTHING;

INSERT INTO notification.alert (id, customer_id, room_reservation_id, title, message, channel, sent_at, status)
SELECT '77777777-7777-7777-7777-777777777773'::uuid, c.id, rr.id, 'Reservation reminder', 'Your reservation is confirmed.', 'SYSTEM'::notification.notification_channel, now(), 'ACTIVE'::configuration.record_status
FROM configuration.customer c
JOIN service_delivery.room_reservation rr ON rr.customer_id = c.id
WHERE rr.id = '44444444-4444-4444-4444-444444444441'::uuid
  AND NOT EXISTS (SELECT 1 FROM notification.alert a WHERE a.id = '77777777-7777-7777-7777-777777777773'::uuid);

INSERT INTO notification.terms_condition (id, title, content, version, effective_date, mandatory, status)
VALUES
  ('77777777-7777-7777-7777-777777777774'::uuid, 'Hotel Terms', 'Basic hotel terms and conditions.', '1.0', DATE '2026-01-01', true, 'ACTIVE'::configuration.record_status)
ON CONFLICT DO NOTHING;

INSERT INTO notification.customer_loyalty (id, customer_id, level, points, last_interaction_at, note, status)
SELECT '77777777-7777-7777-7777-777777777775'::uuid, c.id, 'SILVER', 120, now(), 'First loyalty load', 'ACTIVE'::configuration.record_status
FROM configuration.customer c WHERE c.document_number = '100000001'
  AND NOT EXISTS (SELECT 1 FROM notification.customer_loyalty cl WHERE cl.id = '77777777-7777-7777-7777-777777777775'::uuid);

INSERT INTO notification.customer_loyalty (id, customer_id, level, points, last_interaction_at, note, status)
SELECT '77777777-7777-7777-7777-777777777776'::uuid, c.id, 'BRONZE', 35, now(), 'Second loyalty load', 'ACTIVE'::configuration.record_status
FROM configuration.customer c WHERE c.document_number = '100000002'
  AND NOT EXISTS (SELECT 1 FROM notification.customer_loyalty cl WHERE cl.id = '77777777-7777-7777-7777-777777777776'::uuid);
