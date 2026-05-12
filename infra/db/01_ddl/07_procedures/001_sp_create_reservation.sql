CREATE OR REPLACE PROCEDURE service_delivery.sp_create_reservation(
  p_customer_id UUID,
  p_room_id UUID,
  p_start_date TIMESTAMPTZ,
  p_end_date TIMESTAMPTZ,
  p_guest_count SMALLINT
)
LANGUAGE plpgsql
AS $$
DECLARE
  v_room_type_id UUID;
  v_estimated_amount NUMERIC(12,2);
BEGIN
  SELECT room_type_id INTO v_room_type_id
  FROM distribution.room
  WHERE id = p_room_id AND status = 'ACTIVE';

  IF v_room_type_id IS NULL THEN
    RAISE EXCEPTION 'Room % does not exist or is not active', p_room_id;
  END IF;

  v_estimated_amount := configuration.fn_calculate_reservation_price(v_room_type_id, p_start_date, p_end_date);

  INSERT INTO service_delivery.room_reservation (
    customer_id, room_id, start_date, end_date, guest_count, estimated_amount, reservation_status
  )
  VALUES (
    p_customer_id, p_room_id, p_start_date, p_end_date, p_guest_count, v_estimated_amount, 'PENDING'
  );
END;
$$;
