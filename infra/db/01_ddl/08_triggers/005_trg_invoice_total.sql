DROP TRIGGER IF EXISTS trg_invoice_total ON billing.invoice;
CREATE TRIGGER trg_invoice_total
BEFORE INSERT OR UPDATE OF subtotal, tax, discount
ON billing.invoice
FOR EACH ROW
EXECUTE FUNCTION billing.fn_normalize_billing_total();
