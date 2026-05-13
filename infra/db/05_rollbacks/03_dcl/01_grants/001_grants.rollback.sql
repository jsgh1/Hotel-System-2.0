-- Rollback database grants for instructor role
DO $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_roles
    WHERE rolname = 'hotel_instructor_rw'
  ) THEN
    REVOKE SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA configuration, security, distribution, service_delivery, inventory, billing, notification, maintenance FROM hotel_instructor_rw;
    REVOKE USAGE, SELECT ON ALL SEQUENCES IN SCHEMA configuration, security, distribution, service_delivery, inventory, billing, notification, maintenance FROM hotel_instructor_rw;
    REVOKE USAGE ON SCHEMA configuration, security, distribution, service_delivery, inventory, billing, notification, maintenance FROM hotel_instructor_rw;
    ALTER DEFAULT PRIVILEGES IN SCHEMA configuration, security, distribution, service_delivery, inventory, billing, notification, maintenance REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLES FROM hotel_instructor_rw;
    ALTER DEFAULT PRIVILEGES IN SCHEMA configuration, security, distribution, service_delivery, inventory, billing, notification, maintenance REVOKE USAGE, SELECT ON SEQUENCES FROM hotel_instructor_rw;
  END IF;
END $$;
