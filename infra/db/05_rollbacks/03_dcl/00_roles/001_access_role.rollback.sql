-- Rollback instructor database roles
DO $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_roles
    WHERE rolname = 'ariel5253'
  ) THEN
    DROP ROLE IF EXISTS ariel5253;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_roles
    WHERE rolname = 'hotel_instructor_rw'
  ) THEN
    DROP ROLE IF EXISTS hotel_instructor_rw;
  END IF;
END $$;
