SET search_path TO service_delivery, public;

CREATE TABLE IF NOT EXISTS check_out (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stay_id UUID NOT NULL,
  employee_id UUID NOT NULL,
  event_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  note TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_check_out_stay FOREIGN KEY (stay_id) REFERENCES service_delivery.stay(id),
  CONSTRAINT fk_check_out_employee FOREIGN KEY (employee_id) REFERENCES configuration.employee(id)
);

