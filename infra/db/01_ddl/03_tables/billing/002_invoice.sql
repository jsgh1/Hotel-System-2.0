-- Active: 1778598769166@@127.0.0.1@5445@sistema_hotelero
SET search_path TO billing, public;

CREATE TABLE IF NOT EXISTS invoice (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_id UUID NOT NULL,
  stay_id UUID NOT NULL,
  invoice_number VARCHAR(60) NOT NULL,
  issued_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  subtotal NUMERIC(12,2) NOT NULL DEFAULT 0,
  tax NUMERIC(12,2) NOT NULL DEFAULT 0,
  discount NUMERIC(12,2) NOT NULL DEFAULT 0,
  total NUMERIC(12,2) NOT NULL DEFAULT 0,
  invoice_status billing.invoice_status NOT NULL DEFAULT 'ISSUED',
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_invoice_amounts CHECK (subtotal >= 0 AND tax >= 0 AND discount >= 0 AND total >= 0),
  CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES configuration.customer(id),
  CONSTRAINT fk_invoice_stay FOREIGN KEY (stay_id) REFERENCES service_delivery.stay(id)
);

