SET search_path TO notification, public;

CREATE TABLE IF NOT EXISTS terms_condition (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(160) NOT NULL,
  content TEXT NOT NULL,
  version VARCHAR(40) NOT NULL,
  effective_date DATE NOT NULL,
  mandatory BOOLEAN NOT NULL DEFAULT true,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE'
);

