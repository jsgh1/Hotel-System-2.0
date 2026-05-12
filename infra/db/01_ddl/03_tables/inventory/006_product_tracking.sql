SET search_path TO inventory, public;

CREATE TABLE IF NOT EXISTS product_tracking (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID NOT NULL,
  movement_type inventory.inventory_movement_type NOT NULL,
  quantity INTEGER NOT NULL,
  movement_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  note TEXT,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_seguimiento_quantity CHECK (quantity > 0),
  CONSTRAINT fk_product_tracking_product FOREIGN KEY (product_id) REFERENCES inventory.product(id)
);

