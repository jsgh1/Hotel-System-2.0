CREATE OR REPLACE FUNCTION distribution.fn_validate_room_capacity()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
  v_max_capacity SMALLINT;
BEGIN
  SELECT max_capacity INTO v_max_capacity
  FROM distribution.room_type
  WHERE id = NEW.room_type_id;

  IF NEW.capacity > v_max_capacity THEN
    RAISE EXCEPTION 'Capacity % exceeds the maximum capacity % for the room type', NEW.capacity, v_max_capacity;
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_room_capacity ON distribution.room;
CREATE TRIGGER trg_room_capacity
BEFORE INSERT OR UPDATE OF room_type_id, capacity
ON distribution.room
FOR EACH ROW
EXECUTE FUNCTION distribution.fn_validate_room_capacity();
