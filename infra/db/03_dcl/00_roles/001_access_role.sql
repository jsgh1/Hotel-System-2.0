-- Instructor database role for DDL and DML only.
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_roles
    WHERE rolname = 'hotel_instructor_rw'
  ) THEN
    CREATE ROLE hotel_instructor_rw NOLOGIN;
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_roles
    WHERE rolname = 'ariel5253'
  ) THEN
    CREATE ROLE ariel5253 LOGIN PASSWORD 'ariel5253';
  END IF;
END $$;

GRANT hotel_instructor_rw TO ariel5253;
