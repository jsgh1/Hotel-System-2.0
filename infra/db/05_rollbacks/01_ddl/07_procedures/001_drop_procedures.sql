DROP PROCEDURE IF EXISTS maintenance.sp_close_maintenance(UUID, TEXT);
DROP PROCEDURE IF EXISTS billing.sp_issue_invoice(UUID, VARCHAR);
DROP PROCEDURE IF EXISTS inventory.sp_register_product_entry(UUID, INTEGER, TEXT);
DROP PROCEDURE IF EXISTS security.sp_soft_delete(TEXT, TEXT, UUID, UUID);
DROP PROCEDURE IF EXISTS service_delivery.sp_create_reservation(UUID, UUID, TIMESTAMPTZ, TIMESTAMPTZ, SMALLINT);
