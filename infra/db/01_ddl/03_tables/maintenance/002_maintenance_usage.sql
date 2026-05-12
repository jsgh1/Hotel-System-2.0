SET search_path TO maintenance, public;

CREATE TABLE IF NOT EXISTS maintenance_usage (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_maintenance_id UUID NOT NULL,
  usage_reason VARCHAR(160) NOT NULL,
  activity_detail TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_maintenance_usage_maintenance FOREIGN KEY (room_maintenance_id) REFERENCES maintenance.room_maintenance(id)
);

