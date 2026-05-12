CREATE OR REPLACE VIEW service_delivery.v_reservation_details AS
SELECT
  r.id AS reservation_id,
  c.document_number AS customer_document,
  c.name || ' ' || c.last_name AS customer,
  h.number AS room,
  s.name AS branch,
  r.start_date,
  r.end_date,
  r.guest_count,
  r.reservation_status,
  r.estimated_amount,
  r.status
FROM service_delivery.room_reservation r
JOIN configuration.customer c ON c.id = r.customer_id
JOIN distribution.room h ON h.id = r.room_id
JOIN distribution.branch s ON s.id = h.branch_id;
