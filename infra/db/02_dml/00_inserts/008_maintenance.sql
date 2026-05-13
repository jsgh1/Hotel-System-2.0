SET search_path TO maintenance, public;

INSERT INTO maintenance.room_maintenance (id, room_id, employee_id, maintenance_type, start_date, end_date, maintenance_status, note, status)
SELECT '88888888-8888-8888-8888-888888888881'::uuid, r.id, e.id, 'PLUMBING', now(), now() + interval '2 days', 'IN_PROGRESS'::maintenance.maintenance_status, 'Plumbing inspection', 'ACTIVE'::configuration.record_status
FROM distribution.room r
JOIN configuration.employee e ON e.work_email = 'ariel5253@hotel.local'
WHERE r.number = '201'
  AND NOT EXISTS (SELECT 1 FROM maintenance.room_maintenance rm WHERE rm.id = '88888888-8888-8888-8888-888888888881'::uuid);

INSERT INTO maintenance.maintenance_usage (id, room_maintenance_id, usage_reason, activity_detail, status)
SELECT '88888888-8888-8888-8888-888888888882'::uuid, rm.id, 'Water leak', 'Repairing the bathroom sink.', 'ACTIVE'::configuration.record_status
FROM maintenance.room_maintenance rm
WHERE rm.id = '88888888-8888-8888-8888-888888888881'::uuid
  AND NOT EXISTS (SELECT 1 FROM maintenance.maintenance_usage mu WHERE mu.id = '88888888-8888-8888-8888-888888888882'::uuid);

INSERT INTO maintenance.maintenance_remodeling (id, room_maintenance_id, remodeling_description, estimated_budget, status)
SELECT '88888888-8888-8888-8888-888888888883'::uuid, rm.id, 'Replace bathroom fixtures and paint walls', 1500000, 'ACTIVE'::configuration.record_status
FROM maintenance.room_maintenance rm
WHERE rm.id = '88888888-8888-8888-8888-888888888881'::uuid
  AND NOT EXISTS (SELECT 1 FROM maintenance.maintenance_remodeling mr WHERE mr.id = '88888888-8888-8888-8888-888888888883'::uuid);

INSERT INTO maintenance.maintenance_dashboard (id, branch_id, total_rooms, available_rooms, occupied_rooms, maintenance_rooms, snapshot_at, status)
SELECT '88888888-8888-8888-8888-888888888884'::uuid, b.id, 4, 2, 1, 1, now(), 'ACTIVE'::configuration.record_status
FROM distribution.branch b
WHERE b.name = 'Central Branch'
  AND NOT EXISTS (SELECT 1 FROM maintenance.maintenance_dashboard md WHERE md.id = '88888888-8888-8888-8888-888888888884'::uuid);
