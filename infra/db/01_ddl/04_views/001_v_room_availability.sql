CREATE OR REPLACE VIEW distribution.v_room_availability AS
SELECT
  h.id AS room_id,
  s.name AS branch,
  h.number,
  h.floor,
  th.name AS room_type,
  h.capacity,
  eh.name AS room_status,
  eh.allows_reservation,
  eh.allows_check_in,
  h.status
FROM distribution.room h
JOIN distribution.branch s ON s.id = h.branch_id
JOIN distribution.room_type th ON th.id = h.room_type_id
JOIN distribution.room_status eh ON eh.id = h.room_status_id
WHERE h.status = 'ACTIVE';
