SET search_path TO security, public;

CREATE TABLE IF NOT EXISTS screen (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  module_id UUID NOT NULL,
  name VARCHAR(120) NOT NULL,
  description VARCHAR(255),
  path VARCHAR(180) NOT NULL,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_screen_module FOREIGN KEY (module_id) REFERENCES security.module(id)
);

