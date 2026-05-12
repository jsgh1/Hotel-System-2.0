SET search_path TO service_delivery, public;

CREATE TABLE IF NOT EXISTS room_reservation (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_id UUID NOT NULL,
  room_id UUID NOT NULL,
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ NOT NULL,
  guest_count SMALLINT NOT NULL,
  reservation_status service_delivery.reservation_status NOT NULL DEFAULT 'PENDING',
  estimated_amount NUMERIC(12,2) NOT NULL DEFAULT 0,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_reservation_date_values CHECK (end_date > start_date),
  CONSTRAINT ck_reservation_persons CHECK (guest_count > 0),
  CONSTRAINT ck_reservation_amount CHECK (estimated_amount >= 0),
  CONSTRAINT fk_reservation_customer FOREIGN KEY (customer_id) REFERENCES configuration.customer(id),
  CONSTRAINT fk_room_reservation FOREIGN KEY (room_id) REFERENCES distribution.room(id)
);

