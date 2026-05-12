SET search_path TO distribution, public;

CREATE TABLE IF NOT EXISTS room_type (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(80) NOT NULL,
  description VARCHAR(255),
  base_capacity SMALLINT NOT NULL,
  max_capacity SMALLINT NOT NULL,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_room_type_capacity CHECK (base_capacity > 0 AND max_capacity >= base_capacity)
);

