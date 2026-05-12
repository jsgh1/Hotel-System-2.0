CREATE MATERIALIZED VIEW IF NOT EXISTS billing.mv_monthly_revenue AS
SELECT
  date_trunc('month', issued_at)::DATE AS month,
  COUNT(*) AS issued_invoices,
  SUM(total) AS total_invoiced
FROM billing.invoice
WHERE status = 'ACTIVE'
GROUP BY date_trunc('month', issued_at)::DATE
WITH NO DATA;
