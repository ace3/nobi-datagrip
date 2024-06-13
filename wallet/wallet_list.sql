SELECT user_transfer_in.user_id as user_id,custody_vault_accountbased.custody_vault_id as custody_vault_id, custody_vault_accountbased.vault_name as vault_name,custody_asset.asset_id
FROM user_transfer_in as user_transfer_in
INNER JOIN custody_asset as custody_asset
ON user_transfer_in.coin_id = custody_asset.coin_id
LEFT JOIN custody_vault_accountbased as custody_vault_accountbased
ON user_transfer_in.user_id = custody_vault_accountbased.user_id

WHERE user_transfer_in.user_id != '0' AND user_transfer_in.custody_id = '1'
AND user_transfer_in.coin_id NOT IN (3,5,906,925,926)
group by user_transfer_in.user_id, user_transfer_in.coin_id

