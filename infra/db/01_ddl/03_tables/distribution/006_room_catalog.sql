SET search_path TO distribution, public;

CREATE TABLE IF NOT EXISTS room_catalog (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_id UUID NOT NULL,
  title VARCHAR(160) NOT NULL,
  description TEXT,
  base_price NUMERIC(12,2) NOT NULL DEFAULT 0,
  visible BOOLEAN NOT NULL DEFAULT true,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_catalog_price CHECK (base_price >= 0),
  CONSTRAINT fk_room_catalog_room FOREIGN KEY (room_id) REFERENCES distribution.room(id)
);

