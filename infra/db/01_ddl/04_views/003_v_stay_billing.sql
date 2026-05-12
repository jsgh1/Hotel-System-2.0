CREATE OR REPLACE VIEW billing.v_stay_billing AS
SELECT
  e.id AS stay_id,
  c.document_number AS customer_document,
  c.name || ' ' || c.last_name AS customer,
  pf.total AS total_pre_invoice,
  f.invoice_number,
  f.total AS total_invoice,
  f.invoice_status,
  COALESCE(SUM(pp.amount), 0) AS total_pagado
FROM service_delivery.stay e
JOIN configuration.customer c ON c.id = e.customer_id
LEFT JOIN billing.pre_invoice pf ON pf.stay_id = e.id
LEFT JOIN billing.invoice f ON f.stay_id = e.id
LEFT JOIN billing.partial_payment pp ON pp.invoice_id = f.id
GROUP BY e.id, c.document_number, c.name, c.last_name, pf.total, f.invoice_number, f.total, f.invoice_status;
