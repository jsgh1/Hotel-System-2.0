CREATE OR REPLACE PROCEDURE inventory.sp_register_product_entry(
  p_product_id UUID,
  p_quantity INTEGER,
  p_note TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
  IF p_quantity <= 0 THEN
    RAISE EXCEPTION 'Inbound quantity must be greater than zero';
  END IF;

  UPDATE inventory.product
  SET current_stock = current_stock + p_quantity
  WHERE id = p_product_id;

  INSERT INTO inventory.product_tracking (product_id, movement_type, quantity, note)
  VALUES (p_product_id, 'INBOUND', p_quantity, p_note);
END;
$$;
