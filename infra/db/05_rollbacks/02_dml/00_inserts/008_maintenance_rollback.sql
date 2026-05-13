SET search_path TO maintenance, public;

-- Rollback maintenance dashboard records
DELETE FROM maintenance_dashboard
WHERE id = '88888888-8888-8888-8888-888888888884'::uuid;

-- Rollback maintenance remodeling records
DELETE FROM maintenance_remodeling
WHERE id = '88888888-8888-8888-8888-888888888883'::uuid;

-- Rollback maintenance usage records
DELETE FROM maintenance_usage
WHERE id = '88888888-8888-8888-8888-888888888882'::uuid;

-- Rollback room maintenance records
DELETE FROM room_maintenance
WHERE id = '88888888-8888-8888-8888-888888888881'::uuid;