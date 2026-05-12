SET search_path TO notification, public;

CREATE TABLE IF NOT EXISTS alert (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_id UUID,
  room_reservation_id UUID,
  title VARCHAR(160) NOT NULL,
  message TEXT NOT NULL,
  channel notification.notification_channel NOT NULL,
  sent_at TIMESTAMPTZ,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_alert_customer FOREIGN KEY (customer_id) REFERENCES configuration.customer(id),
  CONSTRAINT fk_alert_reservation FOREIGN KEY (room_reservation_id) REFERENCES service_delivery.room_reservation(id)
);

