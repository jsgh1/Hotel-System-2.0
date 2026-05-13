SET search_path TO inventory, public;

-- Rollback product tracking records
DELETE FROM inventory.product_tracking WHERE id IN (
  '55555555-5555-5555-5555-555555555591',
  '55555555-5555-5555-5555-555555555592'
)::uuid;

-- Rollback inventory availability records
DELETE FROM inventory.inventory_availability WHERE id IN (
  '55555555-5555-5555-5555-555555555581',
  '55555555-5555-5555-5555-555555555582',
  '55555555-5555-5555-5555-555555555583'
)::uuid;

-- Rollback services
DELETE FROM inventory.service WHERE id IN (
  '55555555-5555-5555-5555-555555555571',
  '55555555-5555-5555-5555-555555555572'
)::uuid;

-- Rollback products
DELETE FROM inventory.product WHERE id IN (
  '55555555-5555-5555-5555-555555555561',
  '55555555-5555-5555-5555-555555555562'
)::uuid;

-- Rollback suppliers
DELETE FROM inventory.supplier WHERE id IN (
  '55555555-5555-5555-5555-555555555551',
  '55555555-5555-5555-5555-555555555552'
)::uuid;
