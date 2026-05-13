SET search_path TO billing, public;

-- Rollback purchase detail records
DELETE FROM billing.purchase_detail WHERE id IN (
  '66666666-6666-6666-6666-666666666664',
  '66666666-6666-6666-6666-666666666665'
)::uuid;

-- Rollback partial payments
DELETE FROM billing.partial_payment WHERE id = '66666666-6666-6666-6666-666666666663'::uuid;

-- Rollback invoices
DELETE FROM billing.invoice WHERE id = '66666666-6666-6666-6666-666666666662'::uuid;

-- Rollback pre invoices
DELETE FROM billing.pre_invoice WHERE id = '66666666-6666-6666-6666-666666666661'::uuid;
