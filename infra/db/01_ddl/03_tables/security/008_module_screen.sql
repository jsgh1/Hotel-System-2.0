SET search_path TO security, public;

CREATE TABLE IF NOT EXISTS module_screen (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  module_id UUID NOT NULL,
  screen_id UUID NOT NULL,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_module_screen_module FOREIGN KEY (module_id) REFERENCES security.module(id),
  CONSTRAINT fk_module_screen_screen FOREIGN KEY (screen_id) REFERENCES security.screen(id)
);

