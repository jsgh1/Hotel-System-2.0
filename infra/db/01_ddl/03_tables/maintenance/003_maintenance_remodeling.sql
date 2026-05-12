SET search_path TO maintenance, public;

CREATE TABLE IF NOT EXISTS maintenance_remodeling (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_maintenance_id UUID NOT NULL,
  remodeling_description TEXT NOT NULL,
  estimated_budget NUMERIC(12,2),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_maintenance_presupuesto CHECK (estimated_budget IS NULL OR estimated_budget >= 0),
  CONSTRAINT fk_maintenance_remodeling_maintenance FOREIGN KEY (room_maintenance_id) REFERENCES maintenance.room_maintenance(id)
);

