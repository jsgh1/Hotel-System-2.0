-- Active: 1778598769166@@127.0.0.1@5445@sistema_hotelero
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'record_status' AND typnamespace = 'configuration'::regnamespace) THEN
    CREATE TYPE configuration.record_status AS ENUM ('ACTIVE', 'INACTIVE', 'DELETED');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'reservation_status' AND typnamespace = 'service_delivery'::regnamespace) THEN
    CREATE TYPE service_delivery.reservation_status AS ENUM ('PENDING', 'CONFIRMED', 'CANCELED', 'CHECKED_IN', 'COMPLETED');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'stay_status' AND typnamespace = 'service_delivery'::regnamespace) THEN
    CREATE TYPE service_delivery.stay_status AS ENUM ('ACTIVE', 'COMPLETED', 'CANCELED');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'invoice_status' AND typnamespace = 'billing'::regnamespace) THEN
    CREATE TYPE billing.invoice_status AS ENUM ('DRAFT', 'ISSUED', 'PAID', 'VOID');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'inventory_movement_type' AND typnamespace = 'inventory'::regnamespace) THEN
    CREATE TYPE inventory.inventory_movement_type AS ENUM ('INBOUND', 'OUTBOUND', 'ADJUSTMENT');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'notification_channel' AND typnamespace = 'notification'::regnamespace) THEN
    CREATE TYPE notification.notification_channel AS ENUM ('EMAIL', 'SMS', 'WHATSAPP', 'SYSTEM');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'maintenance_status' AND typnamespace = 'maintenance'::regnamespace) THEN
    CREATE TYPE maintenance.maintenance_status AS ENUM ('PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELED');
  END IF;
END $$;

