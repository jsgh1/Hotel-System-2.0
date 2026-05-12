CREATE OR REPLACE PROCEDURE maintenance.sp_close_maintenance(
  p_maintenance_id UUID,
  p_note TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
  v_room_id UUID;
  v_status_available UUID;
BEGIN
  SELECT room_id INTO v_room_id
  FROM maintenance.room_maintenance
  WHERE id = p_maintenance_id;

  SELECT id INTO v_status_available
  FROM distribution.room_status
  WHERE name = 'AVAILABLE'
  LIMIT 1;

  UPDATE maintenance.room_maintenance
  SET maintenance_status = 'COMPLETED',
      end_date = COALESCE(end_date, now()),
      note = COALESCE(p_note, note)
  WHERE id = p_maintenance_id;

  IF v_status_available IS NOT NULL THEN
    UPDATE distribution.room
    SET room_status_id = v_status_available
    WHERE id = v_room_id;
  END IF;
END;
$$;
