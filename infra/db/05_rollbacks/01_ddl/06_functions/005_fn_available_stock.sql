CREATE OR REPLACE FUNCTION inventory.fn_available_stock(p_product_id UUID)
RETURNS INTEGER
LANGUAGE sql
STABLE
AS $$
  SELECT COALESCE(current_stock, 0)
  FROM inventory.product
  WHERE id = p_product_id
    AND status = 'ACTIVE';
$$;
