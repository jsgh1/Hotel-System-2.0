SET search_path TO configuration, public;

CREATE TABLE IF NOT EXISTS company (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(160) NOT NULL,
  tax_id VARCHAR(40) NOT NULL,
  legal_name VARCHAR(180) NOT NULL,
  phone VARCHAR(40),
  email CITEXT,
  address VARCHAR(255),
  website VARCHAR(180),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE'
);

