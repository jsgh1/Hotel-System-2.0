CREATE OR REPLACE FUNCTION configuration.fn_calculate_reservation_price(
  p_room_type_id UUID,
  p_start_date TIMESTAMPTZ,
  p_end_date TIMESTAMPTZ
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
  v_total NUMERIC(12,2);
BEGIN
  SELECT COALESCE(SUM(px.amount), 0)
  INTO v_total
  FROM generate_series(
    p_start_date::DATE,
    (p_end_date::DATE - INTERVAL '1 day')::DATE,
    INTERVAL '1 day'
  ) AS d(dia)
  LEFT JOIN LATERAL (
    SELECT p.amount
    FROM configuration.price p
    JOIN configuration.day_type td ON td.id = p.day_type_id
    WHERE p.room_type_id = p_room_type_id
      AND p.status = 'ACTIVE'
      AND p.start_date <= d.dia::DATE
      AND (p.end_date IS NULL OR p.end_date >= d.dia::DATE)
    ORDER BY p.start_date DESC
    LIMIT 1
  ) px ON true;

  RETURN v_total;
END;
$$;
