CREATE OR REPLACE FUNCTION service_delivery.fn_calculate_nights(
  p_start_date TIMESTAMPTZ,
  p_end_date TIMESTAMPTZ
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF p_end_date <= p_start_date THEN
    RAISE EXCEPTION 'The end date must be greater than the start date';
  END IF;

  RETURN GREATEST(1, CEIL(EXTRACT(EPOCH FROM (p_end_date - p_start_date)) / 86400.0)::INTEGER);
END;
$$;
