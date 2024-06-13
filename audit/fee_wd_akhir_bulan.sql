SELECT `user_id`, `coin_id`, `blockchain_fee`, `amount_fee`, ticker
FROM `user_wd`
INNER JOIN `mn_master` on user_wd.coin_id = mn_master.id
WHERE user_wd.`created_at` > '2024-03-31 17:00:00' AND user_wd.`created_at` < '2024-04-30 17:00:00'