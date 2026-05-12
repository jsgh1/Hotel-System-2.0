DO $$
DECLARE
  r RECORD;
BEGIN
  FOR r IN
    SELECT table_schema, table_name
    FROM information_schema.columns
    WHERE column_name = 'updated_at'
      AND table_schema IN (
        'configuration',
        'distribution',
        'service_delivery',
        'billing',
        'inventory',
        'notification',
        'security',
        'maintenance'
      )
    GROUP BY table_schema, table_name
  LOOP
    EXECUTE format('DROP TRIGGER IF EXISTS trg_set_updated_at ON %I.%I', r.table_schema, r.table_name);
    EXECUTE format(
      'CREATE TRIGGER trg_set_updated_at BEFORE UPDATE ON %I.%I FOR EACH ROW EXECUTE FUNCTION configuration.fn_set_updated_at()',
      r.table_schema,
      r.table_name
    );
  END LOOP;
END $$;
