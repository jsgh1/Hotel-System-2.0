SET search_path TO configuration, public;

CREATE TABLE IF NOT EXISTS employee (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  person_id UUID NOT NULL,
  position VARCHAR(100) NOT NULL,
  hire_date DATE NOT NULL,
  work_phone VARCHAR(40),
  work_email CITEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_employee_person FOREIGN KEY (person_id) REFERENCES configuration.person(id)
);

