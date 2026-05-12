-- Active: 1778598769166@@127.0.0.1@5445@sistema_hotelero
SET search_path TO billing, public;

CREATE TABLE IF NOT EXISTS purchase_detail (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  invoice_id UUID NOT NULL,
  product_id UUID,
  service_id UUID,
  description VARCHAR(255) NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price NUMERIC(12,2) NOT NULL,
  total_amount NUMERIC(12,2) NOT NULL,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_purchase_detail_amounts CHECK (quantity > 0 AND unit_price >= 0 AND total_amount >= 0),
  CONSTRAINT ck_purchase_detail_item CHECK (product_id IS NOT NULL OR service_id IS NOT NULL),
  CONSTRAINT fk_purchase_detail_invoice FOREIGN KEY (invoice_id) REFERENCES billing.invoice(id),
  CONSTRAINT fk_purchase_detail_product FOREIGN KEY (product_id) REFERENCES inventory.product(id),
  CONSTRAINT fk_purchase_detail_service FOREIGN KEY (service_id) REFERENCES inventory.service(id)
);

