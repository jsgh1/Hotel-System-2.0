CREATE UNIQUE INDEX IF NOT EXISTS ux_customer_document ON configuration.customer (document_type, document_number);
CREATE UNIQUE INDEX IF NOT EXISTS ux_customer_email ON configuration.customer (email) WHERE email IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_person_document ON configuration.person (document_type, document_number);
CREATE UNIQUE INDEX IF NOT EXISTS ux_person_email ON configuration.person (email) WHERE email IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_company_tax_id ON configuration.company (tax_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_day_type_name_date_value ON configuration.day_type (name, date_value);
CREATE UNIQUE INDEX IF NOT EXISTS ux_payment_method_name ON configuration.payment_method (name);
CREATE UNIQUE INDEX IF NOT EXISTS ux_employee_person ON configuration.employee (person_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_employee_work_email ON configuration.employee (work_email) WHERE work_email IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_price_day_type_start_date ON configuration.price (room_type_id, day_type_id, start_date);

CREATE UNIQUE INDEX IF NOT EXISTS ux_role_name ON security.role (name);
CREATE UNIQUE INDEX IF NOT EXISTS ux_permission_name_action ON security.permission (name, action);
CREATE UNIQUE INDEX IF NOT EXISTS ux_module_name ON security.module (name);
CREATE UNIQUE INDEX IF NOT EXISTS ux_module_base_path ON security.module (base_path);
CREATE UNIQUE INDEX IF NOT EXISTS ux_screen_module_path ON security.screen (module_id, path);
CREATE UNIQUE INDEX IF NOT EXISTS ux_app_user_person ON security.app_user (person_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_app_user_username ON security.app_user (username);
CREATE UNIQUE INDEX IF NOT EXISTS ux_app_user_role ON security.app_user_role (app_user_id, role_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_role_permission ON security.role_permission (role_id, permission_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_module_screen ON security.module_screen (module_id, screen_id);

CREATE UNIQUE INDEX IF NOT EXISTS ux_branch_company_name ON distribution.branch (company_id, name);
CREATE UNIQUE INDEX IF NOT EXISTS ux_room_type_name ON distribution.room_type (name);
CREATE UNIQUE INDEX IF NOT EXISTS ux_room_status_name ON distribution.room_status (name);
CREATE UNIQUE INDEX IF NOT EXISTS ux_room_branch_number ON distribution.room (branch_id, number);
CREATE UNIQUE INDEX IF NOT EXISTS ux_room_catalog ON distribution.room_catalog (room_id);
CREATE INDEX IF NOT EXISTS ix_room_availability_date_value ON distribution.room_availability (room_id, start_date, end_date);

CREATE INDEX IF NOT EXISTS ix_reservation_customer ON service_delivery.room_reservation (customer_id);
CREATE INDEX IF NOT EXISTS ix_room_reservation_date_value ON service_delivery.room_reservation (room_id, start_date, end_date);
CREATE UNIQUE INDEX IF NOT EXISTS ux_cancellation_reservation ON service_delivery.room_cancellation (room_reservation_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_stay_reservation ON service_delivery.stay (room_reservation_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_check_in_reservation ON service_delivery.check_in (room_reservation_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_check_out_stay ON service_delivery.check_out (stay_id);

CREATE UNIQUE INDEX IF NOT EXISTS ux_supplier_tax_id ON inventory.supplier (tax_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_product_name ON inventory.product (name);
CREATE UNIQUE INDEX IF NOT EXISTS ux_service_name ON inventory.service (name);
CREATE INDEX IF NOT EXISTS ix_product_sale_stay ON inventory.product_sale (stay_id);
CREATE INDEX IF NOT EXISTS ix_service_sale_stay ON inventory.service_sale (stay_id);
CREATE INDEX IF NOT EXISTS ix_product_tracking_date_value ON inventory.product_tracking (product_id, movement_at);
CREATE INDEX IF NOT EXISTS ix_inventory_availability_product ON inventory.inventory_availability (product_id);
CREATE INDEX IF NOT EXISTS ix_inventory_availability_service ON inventory.inventory_availability (service_id);

CREATE UNIQUE INDEX IF NOT EXISTS ux_pre_invoice_stay ON billing.pre_invoice (stay_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_invoice_number ON billing.invoice (invoice_number);
CREATE UNIQUE INDEX IF NOT EXISTS ux_invoice_stay ON billing.invoice (stay_id);
CREATE INDEX IF NOT EXISTS ix_payment_reservation ON billing.partial_payment (room_reservation_id);
CREATE INDEX IF NOT EXISTS ix_payment_invoice ON billing.partial_payment (invoice_id);
CREATE INDEX IF NOT EXISTS ix_purchase_detail_invoice ON billing.purchase_detail (invoice_id);

CREATE INDEX IF NOT EXISTS ix_promotion_date_value ON notification.promotion (start_date, end_date);
CREATE INDEX IF NOT EXISTS ix_alert_customer ON notification.alert (customer_id);
CREATE INDEX IF NOT EXISTS ix_alert_reservation ON notification.alert (room_reservation_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_terms_version ON notification.terms_condition (version);
CREATE UNIQUE INDEX IF NOT EXISTS ux_customer_loyalty ON notification.customer_loyalty (customer_id);

CREATE INDEX IF NOT EXISTS ix_room_maintenance_date_value ON maintenance.room_maintenance (room_id, start_date, end_date);
CREATE INDEX IF NOT EXISTS ix_maintenance_employee ON maintenance.room_maintenance (employee_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_maintenance_usage ON maintenance.maintenance_usage (room_maintenance_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_maintenance_remodeling ON maintenance.maintenance_remodeling (room_maintenance_id);
CREATE INDEX IF NOT EXISTS ix_maintenance_dashboard_branch_date_value ON maintenance.maintenance_dashboard (branch_id, snapshot_at);

CREATE UNIQUE INDEX IF NOT EXISTS ux_mv_monthly_revenue ON billing.mv_monthly_revenue (month);
CREATE UNIQUE INDEX IF NOT EXISTS ux_mv_branch_occupancy ON distribution.mv_branch_occupancy (branch_id);



