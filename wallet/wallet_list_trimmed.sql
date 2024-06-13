SELECT
	user_transfer_in.user_id AS user_id,
	custody_asset.asset_id 
FROM
	user_transfer_in AS user_transfer_in
	INNER JOIN custody_asset AS custody_asset ON user_transfer_in.coin_id = custody_asset.coin_id 
WHERE
	user_transfer_in.user_id != '0' 
	AND user_transfer_in.custody_id = '1' 
	AND user_transfer_in.coin_id NOT IN ( 3, 5, 906, 925, 926 ) 
GROUP BY
	user_transfer_in.user_id,
	custody_asset.asset_id