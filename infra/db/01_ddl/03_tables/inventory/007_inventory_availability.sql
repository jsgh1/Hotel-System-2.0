SET search_path TO inventory, public;

CREATE TABLE IF NOT EXISTS inventory_availability (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID,
  service_id UUID,
  available_quantity INTEGER NOT NULL DEFAULT 0,
  available BOOLEAN NOT NULL DEFAULT true,
  note VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_inventory_availability_item CHECK (product_id IS NOT NULL OR service_id IS NOT NULL),
  CONSTRAINT ck_inventory_availability_quantity CHECK (available_quantity >= 0),
  CONSTRAINT fk_inventory_availability_product FOREIGN KEY (product_id) REFERENCES inventory.product(id),
  CONSTRAINT fk_inventory_availability_service FOREIGN KEY (service_id) REFERENCES inventory.service(id)
);

