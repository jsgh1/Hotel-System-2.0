SET search_path TO configuration, public;

CREATE TABLE IF NOT EXISTS day_type (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(80) NOT NULL,
  description VARCHAR(255),
  date_value DATE,
  applies_season BOOLEAN NOT NULL DEFAULT false,
  applies_holiday BOOLEAN NOT NULL DEFAULT false,
  applies_special BOOLEAN NOT NULL DEFAULT false,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE'
);

