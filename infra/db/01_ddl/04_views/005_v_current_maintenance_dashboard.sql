CREATE OR REPLACE VIEW maintenance.v_current_maintenance_dashboard AS
SELECT DISTINCT ON (dm.branch_id)
  dm.branch_id,
  s.name AS branch,
  dm.total_rooms,
  dm.available_rooms,
  dm.occupied_rooms,
  dm.maintenance_rooms,
  dm.snapshot_at
FROM maintenance.maintenance_dashboard dm
JOIN distribution.branch s ON s.id = dm.branch_id
ORDER BY dm.branch_id, dm.snapshot_at DESC;
