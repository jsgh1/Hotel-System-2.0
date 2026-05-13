DO $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_roles
    WHERE rolname = 'hotel_instructor_rw'
  ) THEN
    GRANT USAGE ON SCHEMA configuration, security, distribution, service_delivery, inventory, billing, notification, maintenance TO hotel_instructor_rw;
    GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA configuration, security, distribution, service_delivery, inventory, billing, notification, maintenance TO hotel_instructor_rw;
    GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA configuration, security, distribution, service_delivery, inventory, billing, notification, maintenance TO hotel_instructor_rw;
    ALTER DEFAULT PRIVILEGES IN SCHEMA configuration, security, distribution, service_delivery, inventory, billing, notification, maintenance GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO hotel_instructor_rw;
    ALTER DEFAULT PRIVILEGES IN SCHEMA configuration, security, distribution, service_delivery, inventory, billing, notification, maintenance GRANT USAGE, SELECT ON SEQUENCES TO hotel_instructor_rw;
  END IF;
END $$;
