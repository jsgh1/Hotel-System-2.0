SET search_path TO notification, public;

CREATE TABLE IF NOT EXISTS customer_loyalty (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_id UUID NOT NULL,
  level VARCHAR(60) NOT NULL DEFAULT 'BASIC',
  points INTEGER NOT NULL DEFAULT 0,
  last_interaction_at TIMESTAMPTZ,
  note TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_customer_loyalty_points CHECK (points >= 0),
  CONSTRAINT fk_customer_loyalty FOREIGN KEY (customer_id) REFERENCES configuration.customer(id)
);

