INSERT INTO maintenance.room_maintenance (
    id,
    room_id,
    employee_id,
    maintenance_type,
    start_date,
    end_date,
    maintenance_status,
    note,
    status
)
SELECT
    '88888888-8888-8888-8888-888888888881'::uuid,
    r.id,
    e.id,
    'PLUMBING'::maintenance.maintenance_type,
    now(),
    now() + interval '2 days',
    'IN_PROGRESS'::maintenance.maintenance_status,
    'Plumbing inspection',
    'ACTIVE'::configuration.record_status
FROM distribution.room r
JOIN configuration.employee e
    ON e.work_email = 'ariel5253@hotel.local'
WHERE r.number = '201'
AND NOT EXISTS (
    SELECT 1
    FROM maintenance.room_maintenance rm
    WHERE rm.id = '88888888-8888-8888-8888-888888888881'::uuid
);