SET search_path TO distribution, public;

CREATE TABLE IF NOT EXISTS room_availability (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_id UUID NOT NULL,
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ NOT NULL,
  available BOOLEAN NOT NULL DEFAULT true,
  unavailable_reason VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_availability_date_values CHECK (end_date > start_date),
  CONSTRAINT fk_room_availability_room FOREIGN KEY (room_id) REFERENCES distribution.room(id)
);

