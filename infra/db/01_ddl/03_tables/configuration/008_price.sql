SET search_path TO configuration, public;

CREATE TABLE IF NOT EXISTS price (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_type_id UUID NOT NULL,
  day_type_id UUID NOT NULL,
  amount NUMERIC(12,2) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE,
  condition_text VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_price_amount CHECK (amount >= 0),
  CONSTRAINT ck_price_date_values CHECK (end_date IS NULL OR end_date >= start_date),
  CONSTRAINT fk_price_day_type FOREIGN KEY (day_type_id) REFERENCES configuration.day_type(id)
);

