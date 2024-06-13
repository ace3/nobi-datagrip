SELECT DISTINCT
	user_id,
	round(COUNT(*) / 2) AS occurance
FROM
	`user_trx_history`
WHERE
	`activity` IN(53, 54)
	AND `created_at` BETWEEN '2021-12-31 17:00:00'
	AND '2022-12-31 17:00:00'
GROUP BY
	user_id
HAVING
	occurance > 50
ORDER BY
	occurance DESC;