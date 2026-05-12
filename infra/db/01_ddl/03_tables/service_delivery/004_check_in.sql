SET search_path TO service_delivery, public;

CREATE TABLE IF NOT EXISTS check_in (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_reservation_id UUID NOT NULL,
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
  CONSTRAINT fk_check_in_reservation FOREIGN KEY (room_reservation_id) REFERENCES service_delivery.room_reservation(id),
  CONSTRAINT fk_check_in_employee FOREIGN KEY (employee_id) REFERENCES configuration.employee(id)
);

