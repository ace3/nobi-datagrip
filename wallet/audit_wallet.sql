select *,total_ledger-calcamount as difference from (
    select A.user_id,B.id as walletid, A.coin_id,B.amount_total,B.amount_available,B.amount_wd,B.amount_mn ,
    COALESCE(SUM(case when activity in (0,1,2,8,12,13,14,20,22,25,29,30,31,32,33,34,41,42,53,55,56,62,63) then amount
	    when activity in (6,15,16,17,18,19,21,28,45,48,51,52,54,58) then -amount END),0) as total_ledger,
		B.amount_wd+B.amount_available+B.amount_mn+B.amount_pending as calcamount
		from user_ledger A
		INNER JOIN (
			select y.* from user_wallet y
			where y.id != 1
		) B ON A.user_id = B.user_id and A.coin_id = B.coin_id
		group by A.user_id,B.id,A.coin_id,B.amount_total,B.amount_available,B.amount_wd,B.amount_mn,B.amount_pending
HAVING B.amount_wd+B.amount_available+B.amount_mn+B.amount_pending != total_ledger
) z
order by user_id 	;


select *,total_ledger-calcamount as difference from (
    select A.user_id,B.id as walletid, A.coin_id,B.amount_total,B.amount_available,B.amount_wd ,
    COALESCE(SUM(case when activity in (49,53,60,64,65,66,68) then amount
	    when activity in (50,54,58,59,61,67,69) then -amount END),0) as total_ledger,
		B.amount_wd+B.amount_available as calcamount
		from user_ledger A
		INNER JOIN (
			select y.* from user_wallet_fiat y
			where y.id != 1
		) B ON A.user_id = B.user_id and A.coin_id = B.coin_id
		group by A.user_id,B.id,A.coin_id,B.amount_total,B.amount_available,B.amount_wd
				HAVING B.amount_wd+B.amount_available != total_ledger
) z
order by user_id 	;





