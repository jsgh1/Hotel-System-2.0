SET search_path TO inventory, public;

CREATE TABLE IF NOT EXISTS product_sale (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stay_id UUID NOT NULL,
  product_id UUID NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price NUMERIC(12,2) NOT NULL,
  total_amount NUMERIC(12,2) NOT NULL,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_product_sale_amounts CHECK (quantity > 0 AND unit_price >= 0 AND total_amount >= 0),
  CONSTRAINT fk_product_sale_stay FOREIGN KEY (stay_id) REFERENCES service_delivery.stay(id),
  CONSTRAINT fk_product_sale_product FOREIGN KEY (product_id) REFERENCES inventory.product(id)
);

