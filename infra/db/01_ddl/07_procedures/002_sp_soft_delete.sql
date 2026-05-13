CREATE OR REPLACE PROCEDURE security.sp_soft_delete(
  p_schema TEXT,
  p_table TEXT,
  p_id UUID,
  p_deleted_by UUID DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
  EXECUTE format(
    'UPDATE %I.%I SET status = %L, deleted_at = now(), deleted_by = $1 WHERE id = $2',
    p_schema,
    p_table,
    'DELETED'
  )
  USING p_deleted_by, p_id;
END;
$$;
