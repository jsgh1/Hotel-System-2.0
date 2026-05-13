SET search_path TO inventory, public;

INSERT INTO inventory.supplier (id, name, tax_id, phone, email, address, status)
VALUES
  ('55555555-5555-5555-5555-555555555551'::uuid, 'Clean Supply SAS', '901000001-1', '3015550001', 'ventas@cleansupply.local', 'Industrial zone 1', 'ACTIVE'::configuration.record_status),
  ('55555555-5555-5555-5555-555555555552'::uuid, 'Food Service SAS', '901000002-2', '3015550002', 'ventas@foodservice.local', 'Industrial zone 2', 'ACTIVE'::configuration.record_status)
ON CONFLICT DO NOTHING;

INSERT INTO inventory.product (id, supplier_id, name, description, sale_price, current_stock, minimum_stock, status)
SELECT '55555555-5555-5555-5555-555555555561'::uuid, s.id, 'Water Bottle', 'Bottled water for rooms', 5000, 200, 40, 'ACTIVE'::configuration.record_status
FROM inventory.supplier s WHERE s.tax_id = '901000001-1'
  AND NOT EXISTS (SELECT 1 FROM inventory.product p WHERE p.id = '55555555-5555-5555-5555-555555555561'::uuid);

INSERT INTO inventory.product (id, supplier_id, name, description, sale_price, current_stock, minimum_stock, status)
SELECT '55555555-5555-5555-5555-555555555562'::uuid, s.id, 'Toiletries Pack', 'Hotel toiletries package', 12000, 100, 20, 'ACTIVE'::configuration.record_status
FROM inventory.supplier s WHERE s.tax_id = '901000001-1'
  AND NOT EXISTS (SELECT 1 FROM inventory.product p WHERE p.id = '55555555-5555-5555-5555-555555555562'::uuid);

INSERT INTO inventory.service (id, name, description, sale_price, available, status)
VALUES
  ('55555555-5555-5555-5555-555555555571'::uuid, 'Laundry Service', 'Same day laundry service', 25000, true, 'ACTIVE'::configuration.record_status),
  ('55555555-5555-5555-5555-555555555572'::uuid, 'Airport Shuttle', 'Transportation to the airport', 80000, true, 'ACTIVE'::configuration.record_status)
ON CONFLICT DO NOTHING;

INSERT INTO inventory.inventory_availability (id, product_id, available_quantity, available, note, status)
SELECT '55555555-5555-5555-5555-555555555581'::uuid, p.id, 200, true, 'Initial stock', 'ACTIVE'::configuration.record_status
FROM inventory.product p WHERE p.name = 'Water Bottle'
  AND NOT EXISTS (SELECT 1 FROM inventory.inventory_availability ia WHERE ia.id = '55555555-5555-5555-5555-555555555581'::uuid);

INSERT INTO inventory.inventory_availability (id, product_id, available_quantity, available, note, status)
SELECT '55555555-5555-5555-5555-555555555582'::uuid, p.id, 100, true, 'Initial stock', 'ACTIVE'::configuration.record_status
FROM inventory.product p WHERE p.name = 'Toiletries Pack'
  AND NOT EXISTS (SELECT 1 FROM inventory.inventory_availability ia WHERE ia.id = '55555555-5555-5555-5555-555555555582'::uuid);

INSERT INTO inventory.inventory_availability (id, service_id, available_quantity, available, note, status)
SELECT '55555555-5555-5555-5555-555555555583'::uuid, s.id, 50, true, 'Laundry capacity', 'ACTIVE'::configuration.record_status
FROM inventory.service s WHERE s.name = 'Laundry Service'
  AND NOT EXISTS (SELECT 1 FROM inventory.inventory_availability ia WHERE ia.id = '55555555-5555-5555-5555-555555555583'::uuid);

INSERT INTO inventory.product_tracking (id, product_id, movement_type, quantity, movement_at, note, status)
SELECT '55555555-5555-5555-5555-555555555591'::uuid, p.id, 'INBOUND'::inventory.inventory_movement_type, 200, now(), 'Initial product load', 'ACTIVE'::configuration.record_status
FROM inventory.product p WHERE p.name = 'Water Bottle'
  AND NOT EXISTS (SELECT 1 FROM inventory.product_tracking pt WHERE pt.id = '55555555-5555-5555-5555-555555555591'::uuid);

INSERT INTO inventory.product_tracking (id, product_id, movement_type, quantity, movement_at, note, status)
SELECT '55555555-5555-5555-5555-555555555592'::uuid, p.id, 'INBOUND'::inventory.inventory_movement_type, 100, now(), 'Initial product load', 'ACTIVE'::configuration.record_status
FROM inventory.product p WHERE p.name = 'Toiletries Pack'
  AND NOT EXISTS (SELECT 1 FROM inventory.product_tracking pt WHERE pt.id = '55555555-5555-5555-5555-555555555592'::uuid);
