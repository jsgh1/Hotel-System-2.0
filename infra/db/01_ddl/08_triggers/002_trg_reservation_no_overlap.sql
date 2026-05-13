CREATE OR REPLACE FUNCTION service_delivery.fn_validate_room_reservation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
  v_allows_reservation BOOLEAN;
BEGIN
  SELECT eh.allows_reservation INTO v_allows_reservation
  FROM distribution.room h
  JOIN distribution.room_status eh ON eh.id = h.room_status_id
  WHERE h.id = NEW.room_id;

  IF COALESCE(v_allows_reservation, false) = false THEN
    RAISE EXCEPTION 'Room % does not allow reservations in its current status', NEW.room_id;
  END IF;

  IF EXISTS (
    SELECT 1
    FROM service_delivery.room_reservation r
    WHERE r.room_id = NEW.room_id
      AND r.id IS DISTINCT FROM NEW.id
      AND r.status = 'ACTIVE'
      AND r.reservation_status NOT IN ('CANCELED', 'COMPLETED')
      AND tstzrange(r.start_date, r.end_date, '[)') && tstzrange(NEW.start_date, NEW.end_date, '[)')
  ) THEN
    RAISE EXCEPTION 'Room % already has an active reservation in the requested range', NEW.room_id;
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_reservation_no_overlap ON service_delivery.room_reservation;
CREATE TRIGGER trg_reservation_no_overlap
BEFORE INSERT OR UPDATE OF room_id, start_date, end_date, reservation_status, status
ON service_delivery.room_reservation
FOR EACH ROW
EXECUTE FUNCTION service_delivery.fn_validate_room_reservation();

