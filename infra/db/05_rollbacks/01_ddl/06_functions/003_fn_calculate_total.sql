CREATE OR REPLACE FUNCTION billing.fn_calculate_total(
  p_subtotal NUMERIC,
  p_tax NUMERIC,
  p_discount NUMERIC
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
BEGIN
  IF p_subtotal < 0 OR p_tax < 0 OR p_discount < 0 THEN
    RAISE EXCEPTION 'Subtotal, tax, and discount cannot be negative';
  END IF;

  RETURN GREATEST(0, p_subtotal + p_tax - p_discount);
END;
$$;
