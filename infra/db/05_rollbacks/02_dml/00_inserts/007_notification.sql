SET search_path TO notification, public;

-- Rollback customer loyalty records
DELETE FROM notification.customer_loyalty WHERE id IN (
  '77777777-7777-7777-7777-777777777775',
  '77777777-7777-7777-7777-777777777776'
)::uuid;

-- Rollback terms and conditions
DELETE FROM notification.terms_condition WHERE id = '77777777-7777-7777-7777-777777777774'::uuid;

-- Rollback alerts
DELETE FROM notification.alert WHERE id = '77777777-7777-7777-7777-777777777773'::uuid;

-- Rollback promotions
DELETE FROM notification.promotion WHERE id IN (
  '77777777-7777-7777-7777-777777777771',
  '77777777-7777-7777-7777-777777777772'
)::uuid;
