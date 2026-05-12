SET search_path TO service_delivery, public;

CREATE TABLE IF NOT EXISTS room_cancellation (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_reservation_id UUID NOT NULL,
  reason VARCHAR(255) NOT NULL,
  cancellation_date TIMESTAMPTZ NOT NULL DEFAULT now(),
  applies_penalty BOOLEAN NOT NULL DEFAULT false,
  penalty_amount NUMERIC(12,2) NOT NULL DEFAULT 0,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_cancellation_penalty CHECK (penalty_amount >= 0),
  CONSTRAINT fk_cancellation_reservation FOREIGN KEY (room_reservation_id) REFERENCES service_delivery.room_reservation(id)
);

