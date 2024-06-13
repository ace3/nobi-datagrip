INSERT INTO user_ledger (user_id, activity, related_id, amount, notes, coin_id, created_at, updated_at,
                         created_by, updated_by)
VALUES (46598, '6', 1694, 1.00000000, null, 906, NOW(), NOW(), 0, null);
INSERT INTO user_ledger (user_id, activity, related_id, amount, notes, coin_id, created_at, updated_at,
                         created_by, updated_by)
VALUES (46598, '16', 1694, 0.10000000, null, 906, NOW(), NOW(), 0, null);


UPDATE user_wallet
set amount_total = amount_total - 1.10000000,
    amount_wd    = amount_wd - 1.10000000
where user_id = 46598
  and coin_id = 906
LIMIT 1;