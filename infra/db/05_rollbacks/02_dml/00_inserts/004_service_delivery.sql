SET search_path TO service_delivery, public;

-- Rollback check out records
DELETE FROM service_delivery.check_out WHERE id = '44444444-4444-4444-4444-444444444446'::uuid;

-- Rollback check in records
DELETE FROM service_delivery.check_in WHERE id = '44444444-4444-4444-4444-444444444445'::uuid;

-- Rollback stays
DELETE FROM service_delivery.stay WHERE id = '44444444-4444-4444-4444-444444444444'::uuid;

-- Rollback room cancellations
DELETE FROM service_delivery.room_cancellation WHERE id = '44444444-4444-4444-4444-444444444443'::uuid;

-- Rollback room reservations
DELETE FROM service_delivery.room_reservation WHERE id IN (
  '44444444-4444-4444-4444-444444444441',
  '44444444-4444-4444-4444-444444444442'
)::uuid;
