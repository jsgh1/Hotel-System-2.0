SET search_path TO maintenance, public;

CREATE TABLE IF NOT EXISTS room_maintenance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_id UUID NOT NULL,
  employee_id UUID,
  maintenance_type VARCHAR(60) NOT NULL,
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ,
  maintenance_status maintenance.maintenance_status NOT NULL DEFAULT 'PENDING',
  note TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_maintenance_date_values CHECK (end_date IS NULL OR end_date >= start_date),
  CONSTRAINT fk_room_maintenance_room FOREIGN KEY (room_id) REFERENCES distribution.room(id),
  CONSTRAINT fk_room_maintenance_employee FOREIGN KEY (employee_id) REFERENCES configuration.employee(id)
);

