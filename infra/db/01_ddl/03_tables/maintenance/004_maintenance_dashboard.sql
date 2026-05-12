SET search_path TO maintenance, public;

CREATE TABLE IF NOT EXISTS maintenance_dashboard (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  branch_id UUID NOT NULL,
  total_rooms INTEGER NOT NULL DEFAULT 0,
  available_rooms INTEGER NOT NULL DEFAULT 0,
  occupied_rooms INTEGER NOT NULL DEFAULT 0,
  maintenance_rooms INTEGER NOT NULL DEFAULT 0,
  snapshot_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_maintenance_dashboard_amounts CHECK (
    total_rooms >= 0
    AND available_rooms >= 0
    AND occupied_rooms >= 0
    AND maintenance_rooms >= 0
  ),
  CONSTRAINT fk_maintenance_dashboard_branch FOREIGN KEY (branch_id) REFERENCES distribution.branch(id)
);

