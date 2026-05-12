-- Active: 1778598769166@@127.0.0.1@5445@sistema_hotelero
SET search_path TO billing, public;

CREATE TABLE IF NOT EXISTS pre_invoice (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stay_id UUID NOT NULL,
  room_reservation_id UUID NOT NULL,
  customer_id UUID NOT NULL,
  subtotal NUMERIC(12,2) NOT NULL DEFAULT 0,
  tax NUMERIC(12,2) NOT NULL DEFAULT 0,
  discount NUMERIC(12,2) NOT NULL DEFAULT 0,
  total NUMERIC(12,2) NOT NULL DEFAULT 0,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_pre_invoice_amounts CHECK (subtotal >= 0 AND tax >= 0 AND discount >= 0 AND total >= 0),
  CONSTRAINT fk_pre_invoice_stay FOREIGN KEY (stay_id) REFERENCES service_delivery.stay(id),
  CONSTRAINT fk_pre_invoice_reservation FOREIGN KEY (room_reservation_id) REFERENCES service_delivery.room_reservation(id),
  CONSTRAINT fk_pre_invoice_customer FOREIGN KEY (customer_id) REFERENCES configuration.customer(id)
);

