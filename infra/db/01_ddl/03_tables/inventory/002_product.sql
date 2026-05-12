SET search_path TO inventory, public;

CREATE TABLE IF NOT EXISTS product (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  supplier_id UUID,
  name VARCHAR(160) NOT NULL,
  description VARCHAR(255),
  sale_price NUMERIC(12,2) NOT NULL DEFAULT 0,
  current_stock INTEGER NOT NULL DEFAULT 0,
  minimum_stock INTEGER NOT NULL DEFAULT 0,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_product_amounts CHECK (sale_price >= 0 AND current_stock >= 0 AND minimum_stock >= 0),
  CONSTRAINT fk_product_supplier FOREIGN KEY (supplier_id) REFERENCES inventory.supplier(id)
);

