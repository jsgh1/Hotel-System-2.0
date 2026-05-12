SET search_path TO distribution, public;

CREATE TABLE IF NOT EXISTS room_status (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(80) NOT NULL,
  description VARCHAR(255),
  allows_reservation BOOLEAN NOT NULL DEFAULT false,
  allows_check_in BOOLEAN NOT NULL DEFAULT false,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE'
);

