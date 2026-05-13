SET search_path TO billing, public;

INSERT INTO billing.pre_invoice (id, stay_id, room_reservation_id, customer_id, subtotal, tax, discount, total, status)
SELECT '66666666-6666-6666-6666-666666666661'::uuid, s.id, rr.id, c.id, 360000, 68400, 0, 428400, 'ACTIVE'::configuration.record_status
FROM service_delivery.stay s
JOIN service_delivery.room_reservation rr ON rr.id = s.room_reservation_id
JOIN configuration.customer c ON c.id = rr.customer_id
WHERE s.id = '44444444-4444-4444-4444-444444444444'::uuid
  AND NOT EXISTS (SELECT 1 FROM billing.pre_invoice pi WHERE pi.id = '66666666-6666-6666-6666-666666666661'::uuid);

INSERT INTO billing.invoice (id, customer_id, stay_id, invoice_number, issued_at, subtotal, tax, discount, total, invoice_status, status)
SELECT '66666666-6666-6666-6666-666666666662'::uuid, c.id, s.id, 'INV-2026-0001', now(), 360000, 68400, 0, 428400, 'ISSUED'::billing.invoice_status, 'ACTIVE'::configuration.record_status
FROM service_delivery.stay s
JOIN service_delivery.room_reservation rr ON rr.id = s.room_reservation_id
JOIN configuration.customer c ON c.id = rr.customer_id
WHERE s.id = '44444444-4444-4444-4444-444444444444'::uuid
  AND NOT EXISTS (SELECT 1 FROM billing.invoice i WHERE i.id = '66666666-6666-6666-6666-666666666662'::uuid);

INSERT INTO billing.partial_payment (id, room_reservation_id, invoice_id, payment_method_id, amount, paid_at, payment_reference, status)
SELECT '66666666-6666-6666-6666-666666666663'::uuid, rr.id, i.id, pm.id, 200000, now(), 'CASH-0001', 'ACTIVE'::configuration.record_status
FROM service_delivery.room_reservation rr
JOIN billing.invoice i ON i.id = '66666666-6666-6666-6666-666666666662'::uuid
JOIN configuration.payment_method pm ON pm.name = 'CASH'
WHERE rr.id = '44444444-4444-4444-4444-444444444441'::uuid
  AND NOT EXISTS (SELECT 1 FROM billing.partial_payment pp WHERE pp.id = '66666666-6666-6666-6666-666666666663'::uuid);

INSERT INTO billing.purchase_detail (id, invoice_id, product_id, service_id, description, quantity, unit_price, total_amount, status)
SELECT '66666666-6666-6666-6666-666666666664'::uuid, i.id, p.id, NULL, 'Water bottles for room service', 4, 5000, 20000, 'ACTIVE'::configuration.record_status
FROM billing.invoice i
JOIN inventory.product p ON p.name = 'Water Bottle'
WHERE i.id = '66666666-6666-6666-6666-666666666662'::uuid
  AND NOT EXISTS (SELECT 1 FROM billing.purchase_detail pd WHERE pd.id = '66666666-6666-6666-6666-666666666664'::uuid);

INSERT INTO billing.purchase_detail (id, invoice_id, product_id, service_id, description, quantity, unit_price, total_amount, status)
SELECT '66666666-6666-6666-6666-666666666665'::uuid, i.id, NULL, s2.id, 'Laundry service', 1, 25000, 25000, 'ACTIVE'::configuration.record_status
FROM billing.invoice i
JOIN inventory.service s2 ON s2.name = 'Laundry Service'
WHERE i.id = '66666666-6666-6666-6666-666666666662'::uuid
  AND NOT EXISTS (SELECT 1 FROM billing.purchase_detail pd WHERE pd.id = '66666666-6666-6666-6666-666666666665'::uuid);
