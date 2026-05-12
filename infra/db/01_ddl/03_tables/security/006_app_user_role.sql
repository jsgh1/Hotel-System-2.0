SET search_path TO security, public;

CREATE TABLE IF NOT EXISTS app_user_role (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  app_user_id UUID NOT NULL,
  role_id UUID NOT NULL,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_app_user_role_app_user FOREIGN KEY (app_user_id) REFERENCES security.app_user(id),
  CONSTRAINT fk_app_user_role_role FOREIGN KEY (role_id) REFERENCES security.role(id)
);

