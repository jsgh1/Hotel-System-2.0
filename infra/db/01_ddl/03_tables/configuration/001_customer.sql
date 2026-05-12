SET search_path TO configuration, public;

CREATE TABLE IF NOT EXISTS customer (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  document_type VARCHAR(30) NOT NULL,
  document_number VARCHAR(40) NOT NULL,
  name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  phone VARCHAR(40),
  email CITEXT,
  address VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE'
);

