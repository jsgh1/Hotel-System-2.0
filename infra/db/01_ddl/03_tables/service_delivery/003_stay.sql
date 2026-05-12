SET search_path TO service_delivery, public;

CREATE TABLE IF NOT EXISTS stay (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_reservation_id UUID NOT NULL,
  customer_id UUID NOT NULL,
  room_id UUID NOT NULL,
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ,
  stay_status service_delivery.stay_status NOT NULL DEFAULT 'ACTIVE',
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_stay_date_values CHECK (end_date IS NULL OR end_date > start_date),
  CONSTRAINT fk_stay_reservation FOREIGN KEY (room_reservation_id) REFERENCES service_delivery.room_reservation(id),
  CONSTRAINT fk_stay_customer FOREIGN KEY (customer_id) REFERENCES configuration.customer(id),
  CONSTRAINT fk_stay_room FOREIGN KEY (room_id) REFERENCES distribution.room(id)
);

