-- Rollback manual recovery after refresh
-- No explicit rollback needed as materialized views will maintain their previous state
-- This is a recovery operation helper, not a creation or modification
DO $$
BEGIN
  NULL;
END $$;
