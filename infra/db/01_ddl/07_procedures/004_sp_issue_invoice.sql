CREATE OR REPLACE PROCEDURE billing.sp_issue_invoice(
  p_stay_id UUID,
  p_invoice_number VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
  v_pre_invoice billing.pre_invoice%ROWTYPE;
BEGIN
  SELECT * INTO v_pre_invoice
  FROM billing.pre_invoice
  WHERE stay_id = p_stay_id AND status = 'ACTIVE';

  IF v_pre_invoice.id IS NULL THEN
    RAISE EXCEPTION 'No active pre-invoice exists for stay %', p_stay_id;
  END IF;

  INSERT INTO billing.invoice (
    customer_id, stay_id, invoice_number, subtotal, tax, discount, total, invoice_status
  )
  VALUES (
    v_pre_invoice.customer_id, v_pre_invoice.stay_id, p_invoice_number,
    v_pre_invoice.subtotal, v_pre_invoice.tax, v_pre_invoice.discount,
    v_pre_invoice.total, 'ISSUED'
  );
END;
$$;
