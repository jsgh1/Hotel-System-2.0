-- Active: 1778598769166@@127.0.0.1@5445@sistema_hotelero
SET search_path TO billing, public;

CREATE TABLE IF NOT EXISTS partial_payment (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_reservation_id UUID,
  invoice_id UUID,
  payment_method_id UUID NOT NULL,
  amount NUMERIC(12,2) NOT NULL,
  paid_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  payment_reference VARCHAR(120),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_payment_amount CHECK (amount > 0),
  CONSTRAINT ck_payment_source CHECK (room_reservation_id IS NOT NULL OR invoice_id IS NOT NULL),
  CONSTRAINT fk_payment_reservation FOREIGN KEY (room_reservation_id) REFERENCES service_delivery.room_reservation(id),
  CONSTRAINT fk_payment_invoice FOREIGN KEY (invoice_id) REFERENCES billing.invoice(id),
  CONSTRAINT fk_payment_payment_method FOREIGN KEY (payment_method_id) REFERENCES configuration.payment_method(id)
);

