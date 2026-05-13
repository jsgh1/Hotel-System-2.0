CREATE OR REPLACE FUNCTION billing.fn_normalize_billing_total()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.total := billing.fn_calculate_total(NEW.subtotal, NEW.tax, NEW.discount);
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_pre_invoice_total ON billing.pre_invoice;
CREATE TRIGGER trg_pre_invoice_total
BEFORE INSERT OR UPDATE OF subtotal, tax, discount
ON billing.pre_invoice
FOR EACH ROW
EXECUTE FUNCTION billing.fn_normalize_billing_total();
