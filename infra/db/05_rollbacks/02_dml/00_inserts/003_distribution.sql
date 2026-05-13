SET search_path TO distribution, public;

-- Rollback branches
DELETE FROM distribution.branch WHERE id IN (
  '33333333-3333-3333-3333-333333333331',
  '33333333-3333-3333-3333-333333333332'
)::uuid;

-- Rollback room types
DELETE FROM distribution.room_type WHERE name IN ('SINGLE', 'DOUBLE', 'SUITE');

-- Rollback room statuses
DELETE FROM distribution.room_status WHERE name IN ('AVAILABLE', 'OCCUPIED', 'MAINTENANCE');
