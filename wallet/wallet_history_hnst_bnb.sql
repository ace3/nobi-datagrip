
SELECT
                                                CASE
                                                WHEN uth.activity = 4 THEN IF(false, 'Remove', 'Remove Earn')
                                                WHEN uth.activity = 7 THEN IF(false, 'Add', 'Add Earn')
                                                WHEN uth.activity = 26 THEN IF(false, 'Follow Pro', 'Add')
                                                WHEN uth.activity = 27 THEN IF(false, 'Exit Pro', 'Remove')
                                                WHEN uth.activity = 30 THEN 'Referral Bonus'
                                                WHEN uth.activity = 31 THEN 'Cashback Bonus'
                                                WHEN uth.activity = 35 THEN IF(false, 'Add', 'Add Earn')
                                                WHEN uth.activity = 36 THEN IF(false, 'Remove', 'Remove Earn')
                                                WHEN uth.activity = 37 THEN 'Cashback Bonus'
                                                WHEN uth.activity = 38 THEN 'Referral Bonus'
                                                WHEN uth.activity = 39 THEN IF(false, 'Performance Fee Pro', 'Performance Fee')
                                                WHEN uth.activity = 40 THEN IF(false, 'Performance Fee Earn', 'Performance Fee')
                                                WHEN uth.activity = 43 THEN IF(false, 'Add', 'Add Earn')
                                                WHEN uth.activity = 44 THEN IF(false, 'Remove', 'Remove Earn')
                                                WHEN uth.activity = 45 THEN IF(false, 'Performance Fee Earn', 'Performance Fee')
                                                WHEN uth.activity = 55 THEN 'Cashback Bonus'
                                                WHEN uth.activity = 56 THEN 'Referral Bonus'
                                                ELSE uth.name
                                        END as name,

                                        uth.sku,
                                        uw.coin_id  as uw_coin_id,
                                        uth.coin_id as uth_coin_id,
                                        uth.note,
                                        uth.activity,
                                        mm.decimal_precision,
                                        uth.amount_usd,
                                        uth.amount_idr,

                                        CASE
                                                WHEN uth.ticker = 'XZC' THEN 'FIRO'
                                                ELSE uth.ticker
                                        END as ticker,

                                        IF(uth.activity = 6,
                                                ROUND(COALESCE(uth.amount, 0) + COALESCE(uth.fee, 0) + COALESCE(uth.fee_performance, 0), 8),
                                                ROUND(uth.amount, 8)
                                        ) as amount,

                                        CASE
                                                WHEN uth.activity = 6
                                                        THEN ROUND(COALESCE(uth.amount, 0), 8)
                                                WHEN uth.activity = 19
                                                        THEN ROUND(COALESCE(uth.amount, 0), 8)
                                                WHEN uth.activity in (50, 57, 59)
                                                        THEN ROUND(COALESCE(uth.amount, 0), 8)
                                                WHEN uth.activity in (39, 40, 45) AND uth.amount != 0 AND uth.fee_performance !=0
                                                        THEN ROUND(uth.fee_performance, 8)
                                                ELSE
                                                        IF(uth.fee_performance > 0,
                                                                IF(uth.fee_performance_ticker = 'HNST',
                                                                        ROUND(uth.amount - uth.fee, 8),
                                                                        ROUND(uth.amount - uth.fee - uth.fee_performance, 8)
                                                                ),
                                                                ROUND(uth.amount, 8)
                                                        )
                                        END as amount_received,

                                        coalesce(IF(uth.trx_id != "" AND uth.trx_id != "0", uth.trx_id,
                                        IF(uth.activity = 16, uw.trxid, NULL)), uth.id) as transaction_id,
                                        coalesce(
                                                IF(uth.tx_id != "" AND uth.tx_id != "0",
                                                        uth.tx_id,
                                                        IF(uth.activity IN (0,1,25,6,19,23) AND uth.trx_id != "" AND uth.trx_id != "0", uth.trx_id, null)
                                                )
                                        , null) as tx_id,
                                        coalesce(
                                                iF(uth.address != "" AND uth.address != "0" AND uth.address IS NOT NULL,
                                                        uth.address,
                                                        IF(uth.activity IN (1), "Internal Transfer", null)
                                                )
                                        , null) as address,
                                        CASE
                                                WHEN uth.activity = 6 THEN
                                                        CASE
                                                                WHEN uw.is_fee_HNST = 1 THEN uw.amount_fee_hnst
                                                                ELSE uw.amount_fee
                                                        END
                                                WHEN uth.activity = 19 THEN
                                                        CASE
                                                                WHEN uw.is_fee_HNST = 1 THEN uw.amount_fee_hnst
                                                                ELSE uw.amount_fee
                                                        END
                                                ELSE
                                                uth.fee
                                        END as fee,

                                        CASE
                                                WHEN uth.activity = 6 THEN
                                                        CASE
                                                                WHEN uw.is_fee_HNST = 1 THEN 'HNST'
                                                                ELSE uth.ticker
                                                        END
                                                WHEN uth.activity = 19 THEN
                                                        CASE
                                                                WHEN uw.is_fee_HNST = 1 THEN 'HNST'
                                                                ELSE uth.ticker
                                                        END
                                                ELSE
                                                uth.ticker
                                        END as fee_ticker,
                                        uth.fee_performance,
                                        uth.memo,
                                        uth.est_processing_time,
                                        UNIX_TIMESTAMP(uth.created_at) as transaction_time,
                                        CASE
                                                WHEN uth.ticker = 'IDR' THEN 'Rp'
                                                ELSE null
                                        END as symbol,

                                        CASE
                                                WHEN coalesce(uts.status, "completed") in ('request', 'approved') THEN 'processing'
                                                WHEN coalesce(uts.status, "completed") in ('rejected', 'canceled', 'refund') THEN 'failed'
                                        ELSE
                                                coalesce(uts.status, "completed")
                                        END as status,

                                        CASE
                                                WHEN uth.activity = 0 THEN 'Deposit'
                                                WHEN uth.activity = 1 THEN 'Deposit'
                                                WHEN uth.activity = 6 THEN 'Withdrawal'
                                                WHEN uth.activity = 4 THEN 'Remove'
                                                WHEN uth.activity = 5 THEN 'Reject'
                                                WHEN uth.activity = 7 THEN 'Add'
                                                WHEN uth.activity = 8 THEN 'Voucher Received'
                                                WHEN uth.activity = 23 THEN 'Withdrawal'
                                                WHEN uth.activity = 19 THEN 'Withdrawal'
                                                WHEN uth.activity = 25 THEN 'Deposit'
                                                WHEN uth.activity = 26 THEN 'Add'
                                                WHEN uth.activity = 27 THEN 'Remove'
                                                WHEN uth.activity = 30 THEN 'Referral Bonus'
                                                WHEN uth.activity = 31 THEN 'Cashback Bonus'
                                                WHEN uth.activity = 32 THEN 'Following Commission'
                                                WHEN uth.activity = 33 THEN 'Service Commission'
                                                WHEN uth.activity = 34 THEN 'Perform Commission'
                                                WHEN uth.activity = 35 THEN 'Add'
                                                WHEN uth.activity = 36 THEN 'Remove'
                                                WHEN uth.activity = 37 THEN 'Cashback Bonus'
                                                WHEN uth.activity = 38 THEN 'Referral Bonus'
                                                WHEN uth.activity = 39 THEN 'Performance Fee'
                                                WHEN uth.activity = 40 THEN 'Performance Fee'
                                                WHEN uth.activity = 43 THEN 'Add'
                                                WHEN uth.activity = 44 THEN 'Remove'
                                                WHEN uth.activity = 45 THEN 'Performance Fee'
                                                WHEN uth.activity = 55 THEN 'Cashback Bonus'
                                                WHEN uth.activity = 56 THEN 'Referral Bonus'
                                                WHEN uth.activity = 49 THEN 'Deposit IDR'
                                                WHEN uth.activity = 50 THEN 'Withdraw IDR'
                                                WHEN uth.activity = 52 THEN 'Voucher Sent'
                                                WHEN uth.activity = 53 THEN 'Buy'
                                                WHEN uth.activity = 54 THEN 'Sell'
                                                WHEN uth.activity = 57 THEN 'Withdraw IDR'
                                                WHEN uth.activity = 59 THEN 'Withdraw IDR'
                                                WHEN uth.activity = 60 THEN 'Voucher Sent'
                                                WHEN uth.activity = 61 THEN 'Voucher Sent'
                                                WHEN uth.activity = 62 THEN 'Voucher Canceled'
                                                WHEN uth.activity = 63 THEN 'Voucher Expired'
                                                WHEN uth.activity = 64 THEN 'Voucher Received'
                                                WHEN uth.activity = 65 THEN 'Voucher Canceled'
                                                WHEN uth.activity = 66 THEN 'Voucher Expired'
                                                WHEN uth.activity = 67 THEN 'Voucher Sent'
                                                WHEN uth.activity = 16 AND uw.coin_id != uth.coin_id AND uw.coin_id != 531 THEN 'Withdrawal Fee'
                                                WHEN uth.activity = 16 AND uw.coin_id IS NULL AND uth.coin_id = 531 THEN 'HNST Withdrawal Fee'
                                                ELSE "unknown"
                                        END as type,
                                        CASE
                                        WHEN uth.activity = 0 THEN 'wallet'
                                                WHEN uth.activity = 1 THEN 'wallet'
                                                WHEN uth.activity = 6 THEN 'wallet'
                                                WHEN uth.activity = 4 THEN 'wallet'
                                                WHEN uth.activity = 5 THEN 'wallet'
                                                WHEN uth.activity = 7 THEN 'staking'
                                                WHEN uth.activity = 8 THEN 'voucher'
                                                WHEN uth.activity = 23 THEN 'wallet'
                                                WHEN uth.activity = 19 THEN 'wallet'
                                                WHEN uth.activity = 25 THEN 'walet'
                                                WHEN uth.activity = 26 THEN 'fund'
                                                WHEN uth.activity = 27 THEN 'fund'
                                                WHEN uth.activity = 30 THEN 'wallet'
                                                WHEN uth.activity = 31 THEN 'wallet'
                                                WHEN uth.activity = 32 THEN 'wallet'
                                                WHEN uth.activity = 33 THEN 'wallet'
                                                WHEN uth.activity = 34 THEN 'wallet'
                                                WHEN uth.activity = 35 THEN 'saving'
                                                WHEN uth.activity = 36 THEN 'saving'
                                                WHEN uth.activity = 37 THEN 'wallet'
                                                WHEN uth.activity = 38 THEN 'wallet'
                                                WHEN uth.activity = 39 THEN 'wallet'
                                                WHEN uth.activity = 40 THEN 'wallet'
                                                WHEN uth.activity = 43 THEN 'staking'
                                                WHEN uth.activity = 44 THEN 'staking'
                                                WHEN uth.activity = 45 THEN 'wallet'
                                                WHEN uth.activity = 49 THEN 'fiat_deposit'
                                                WHEN uth.activity = 50 THEN 'fiat_wd'
                                                WHEN uth.activity = 52 THEN 'voucher'
                                                WHEN uth.activity = 53 THEN 'fiat_trade_plus'
                                                WHEN uth.activity = 54 THEN 'fiat_trade_minus'
                                                WHEN uth.activity = 55 THEN 'wallet'
                                                WHEN uth.activity = 56 THEN 'wallet'
                                                WHEN uth.activity = 57 THEN 'fiat_wd'
                                                WHEN uth.activity = 59 THEN 'fiat_wd'
                                                WHEN uth.activity = 60 THEN 'voucher'
                                                WHEN uth.activity = 61 THEN 'voucher'
                                                WHEN uth.activity = 62 THEN 'voucher'
                                                WHEN uth.activity = 63 THEN 'voucher'
                                                WHEN uth.activity = 64 THEN 'voucher'
                                                WHEN uth.activity = 65 THEN 'voucher'
                                                WHEN uth.activity = 66 THEN 'voucher'
                                                WHEN uth.activity = 67 THEN 'voucher'
                                                WHEN uth.activity = 16 THEN 'wd_fee'
                                                ELSE "unknown"
                                        END as category,
                                        CASE
                                                WHEN uth.activity = 0 THEN '+'
                                                WHEN uth.activity = 1 THEN '+'
                                                WHEN uth.activity = 4 THEN IF(false, '-', '+')
                                                WHEN uth.activity = 6 THEN '-'
                                                WHEN uth.activity = 7 THEN IF(false, '+', '-')
                                                WHEN uth.activity = 8 THEN '+'
                                                WHEN uth.activity = 23 THEN '-'
                                                WHEN uth.activity = 19 THEN '-'
                                                WHEN uth.activity = 25 THEN '+'
                                                WHEN uth.activity = 26 THEN IF(false, '-', '+')
                                                WHEN uth.activity = 27 THEN IF(false, '+', '-')
                                                WHEN uth.activity = 30 THEN '+'
                                                WHEN uth.activity = 31 THEN '+'
                                                WHEN uth.activity = 32 THEN '+'
                                                WHEN uth.activity = 33 THEN '+'
                                                WHEN uth.activity = 34 THEN '+'
                                                WHEN uth.activity = 35 THEN IF(false, '+', '-')
                                                WHEN uth.activity = 36 THEN IF(false, '-', '+')
                                                WHEN uth.activity = 37 THEN '+'
                                                WHEN uth.activity = 38 THEN '+'
                                                WHEN uth.activity = 39 THEN '-'
                                                WHEN uth.activity = 40 THEN '-'
                                                WHEN uth.activity = 43 THEN IF(false, '+', '-')
                                                WHEN uth.activity = 44 THEN IF(false, '-', '+')
                                                WHEN uth.activity = 45 THEN '-'
                                                WHEN uth.activity = 49 THEN '+'
                                                WHEN uth.activity = 50 THEN '-'
                                                WHEN uth.activity = 52 THEN '-'
                                                WHEN uth.activity = 53 THEN '+'
                                                WHEN uth.activity = 54 THEN '-'
                                                WHEN uth.activity = 55 THEN '+'
                                                WHEN uth.activity = 56 THEN '+'
                                                WHEN uth.activity = 60 THEN '+'
                                                WHEN uth.activity = 61 THEN '-'
                                                WHEN uth.activity = 62 THEN '+'
                                                WHEN uth.activity = 63 THEN '+'
                                                WHEN uth.activity = 64 THEN '+'
                                                WHEN uth.activity = 65 THEN '+'
                                                WHEN uth.activity = 66 THEN '+'
                                                WHEN uth.activity = 67 THEN '-'
                                                WHEN uth.activity = 16 THEN '-'
                                                ELSE NULL
                                        END as sign,
                                        COALESCE(uth.price_usd, 0) as price,
                                        COALESCE(uth.price_idr, 0) as price_idr
         FROM user_trx_history uth
                left join user_trx_history_status uts
                        on uth.id = uts.user_trx_history_id
                        and uts.id = (
                                select
                                        max(uths.id)
                                from
                                        user_trx_history_status uths
                                where
                                        uths.user_trx_history_id = uth.id
                        )

                left join mn_master mm
                        on uth.coin_id = mm.id
                 left join user_wd uw on uth.reference_id = uw.id and uth.trx_id = uw.trxid  WHERE  uth.note != 'fraud' AND uth.amount >= 0 AND uth.user_id = '51160' AND ( uth.sku = '531' OR uth.coin_id = '531' ) AND uth.activity IN (26,27,39,0,1,5,6,8,19,23,25,30,31,32,33,34,37,38,55,56,49,50,53,54,52,57,59,60,61,62,63,64,65,66,67,26,27,39,35,36,40,43,44,45,4,7,45,0,1,5,6,8,19,23,25,30,31,32,33,34,37,38,55,56,49,50,53,54,52,57,59,60,61,62,63,64,65,66,67,16) AND uth.id >= 2345518 ORDER BY uth.created_at DESC, uth.id DESC LIMIT 20 OFFSET 0


##

SELECT
                                                CASE
                                                WHEN uth.activity = 4 THEN IF(false, 'Remove', 'Remove Earn')
                                                WHEN uth.activity = 7 THEN IF(false, 'Add', 'Add Earn')
                                                WHEN uth.activity = 26 THEN IF(false, 'Follow Pro', 'Add')
                                                WHEN uth.activity = 27 THEN IF(false, 'Exit Pro', 'Remove')
                                                WHEN uth.activity = 30 THEN 'Referral Bonus'
                                                WHEN uth.activity = 31 THEN 'Cashback Bonus'
                                                WHEN uth.activity = 35 THEN IF(false, 'Add', 'Add Earn')
                                                WHEN uth.activity = 36 THEN IF(false, 'Remove', 'Remove Earn')
                                                WHEN uth.activity = 37 THEN 'Cashback Bonus'
                                                WHEN uth.activity = 38 THEN 'Referral Bonus'
                                                WHEN uth.activity = 39 THEN IF(false, 'Performance Fee Pro', 'Performance Fee')
                                                WHEN uth.activity = 40 THEN IF(false, 'Performance Fee Earn', 'Performance Fee')
                                                WHEN uth.activity = 43 THEN IF(false, 'Add', 'Add Earn')
                                                WHEN uth.activity = 44 THEN IF(false, 'Remove', 'Remove Earn')
                                                WHEN uth.activity = 45 THEN IF(false, 'Performance Fee Earn', 'Performance Fee')
                                                WHEN uth.activity = 55 THEN 'Cashback Bonus'
                                                WHEN uth.activity = 56 THEN 'Referral Bonus'
                                                ELSE uth.name
                                        END as name,

                                        uth.sku,
                                        uth.note,
                                        uth.activity,
                                        mm.decimal_precision,
                                        uth.amount_usd,
                                        uth.amount_idr,

                                        CASE
                                                WHEN uth.ticker = 'XZC' THEN 'FIRO'
                                                ELSE uth.ticker
                                        END as ticker,

                                        IF(uth.activity = 6,
                                                ROUND(COALESCE(uth.amount, 0) + COALESCE(uth.fee, 0) + COALESCE(uth.fee_performance, 0), 8),
                                                ROUND(uth.amount, 8)
                                        ) as amount,

                                        CASE
                                                WHEN uth.activity = 6
                                                        THEN ROUND(COALESCE(uth.amount, 0), 8)
                                                WHEN uth.activity = 19
                                                        THEN ROUND(COALESCE(uth.amount, 0), 8)
                                                WHEN uth.activity in (50, 57, 59)
                                                        THEN ROUND(COALESCE(uth.amount, 0), 8)
                                                WHEN uth.activity in (39, 40, 45) AND uth.amount != 0 AND uth.fee_performance !=0
                                                        THEN ROUND(uth.fee_performance, 8)
                                                ELSE
                                                        IF(uth.fee_performance > 0,
                                                                IF(uth.fee_performance_ticker = 'HNST',
                                                                        ROUND(uth.amount - uth.fee, 8),
                                                                        ROUND(uth.amount - uth.fee - uth.fee_performance, 8)
                                                                ),
                                                                ROUND(uth.amount, 8)
                                                        )
                                        END as amount_received,

                                        coalesce(IF(uth.trx_id != "" AND uth.trx_id != "0", uth.trx_id,
                                        IF(uth.activity = 16, uw.trxid, NULL)), uth.id) as transaction_id,
                                        coalesce(
                                                IF(uth.tx_id != "" AND uth.tx_id != "0",
                                                        uth.tx_id,
                                                        IF(uth.activity IN (0,1,25,6,19,23) AND uth.trx_id != "" AND uth.trx_id != "0", uth.trx_id, null)
                                                )
                                        , null) as tx_id,
                                        coalesce(
                                                iF(uth.address != "" AND uth.address != "0" AND uth.address IS NOT NULL,
                                                        uth.address,
                                                        IF(uth.activity IN (1), "Internal Transfer", null)
                                                )
                                        , null) as address,
                                        CASE
                                                WHEN uth.activity = 6 THEN
                                                        CASE
                                                                WHEN uw.is_fee_HNST = 1 THEN uw.amount_fee_hnst
                                                                ELSE uw.amount_fee
                                                        END
                                                WHEN uth.activity = 19 THEN
                                                        CASE
                                                                WHEN uw.is_fee_HNST = 1 THEN uw.amount_fee_hnst
                                                                ELSE uw.amount_fee
                                                        END
                                                ELSE
                                                uth.fee
                                        END as fee,

                                        CASE
                                                WHEN uth.activity = 6 THEN
                                                        CASE
                                                                WHEN uw.is_fee_HNST = 1 THEN 'HNST'
                                                                ELSE uth.ticker
                                                        END
                                                WHEN uth.activity = 19 THEN
                                                        CASE
                                                                WHEN uw.is_fee_HNST = 1 THEN 'HNST'
                                                                ELSE uth.ticker
                                                        END
                                                ELSE
                                                uth.ticker
                                        END as fee_ticker,
                                        uth.fee_performance,
                                        uth.memo,
                                        uth.est_processing_time,
                                        UNIX_TIMESTAMP(uth.created_at) as transaction_time,
                                        CASE
                                                WHEN uth.ticker = 'IDR' THEN 'Rp'
                                                ELSE null
                                        END as symbol,

                                        CASE
                                                WHEN coalesce(uts.status, "completed") in ('request', 'approved') THEN 'processing'
                                                WHEN coalesce(uts.status, "completed") in ('rejected', 'canceled', 'refund') THEN 'failed'
                                        ELSE
                                                coalesce(uts.status, "completed")
                                        END as status,

                                        CASE
                                                WHEN uth.activity = 0 THEN 'Deposit'
                                                WHEN uth.activity = 1 THEN 'Deposit'
                                                WHEN uth.activity = 6 THEN 'Withdrawal'
                                                WHEN uth.activity = 4 THEN 'Remove'
                                                WHEN uth.activity = 5 THEN 'Reject'
                                                WHEN uth.activity = 7 THEN 'Add'
                                                WHEN uth.activity = 8 THEN 'Voucher Received'
                                                WHEN uth.activity = 23 THEN 'Withdrawal'
                                                WHEN uth.activity = 19 THEN 'Withdrawal'
                                                WHEN uth.activity = 25 THEN 'Deposit'
                                                WHEN uth.activity = 26 THEN 'Add'
                                                WHEN uth.activity = 27 THEN 'Remove'
                                                WHEN uth.activity = 30 THEN 'Referral Bonus'
                                                WHEN uth.activity = 31 THEN 'Cashback Bonus'
                                                WHEN uth.activity = 32 THEN 'Following Commission'
                                                WHEN uth.activity = 33 THEN 'Service Commission'
                                                WHEN uth.activity = 34 THEN 'Perform Commission'
                                                WHEN uth.activity = 35 THEN 'Add'
                                                WHEN uth.activity = 36 THEN 'Remove'
                                                WHEN uth.activity = 37 THEN 'Cashback Bonus'
                                                WHEN uth.activity = 38 THEN 'Referral Bonus'
                                                WHEN uth.activity = 39 THEN 'Performance Fee'
                                                WHEN uth.activity = 40 THEN 'Performance Fee'
                                                WHEN uth.activity = 43 THEN 'Add'
                                                WHEN uth.activity = 44 THEN 'Remove'
                                                WHEN uth.activity = 45 THEN 'Performance Fee'
                                                WHEN uth.activity = 55 THEN 'Cashback Bonus'
                                                WHEN uth.activity = 56 THEN 'Referral Bonus'
                                                WHEN uth.activity = 49 THEN 'Deposit IDR'
                                                WHEN uth.activity = 50 THEN 'Withdraw IDR'
                                                WHEN uth.activity = 52 THEN 'Voucher Sent'
                                                WHEN uth.activity = 53 THEN 'Buy'
                                                WHEN uth.activity = 54 THEN 'Sell'
                                                WHEN uth.activity = 57 THEN 'Withdraw IDR'
                                                WHEN uth.activity = 59 THEN 'Withdraw IDR'
                                                WHEN uth.activity = 60 THEN 'Voucher Sent'
                                                WHEN uth.activity = 61 THEN 'Voucher Sent'
                                                WHEN uth.activity = 62 THEN 'Voucher Canceled'
                                                WHEN uth.activity = 63 THEN 'Voucher Expired'
                                                WHEN uth.activity = 64 THEN 'Voucher Received'
                                                WHEN uth.activity = 65 THEN 'Voucher Canceled'
                                                WHEN uth.activity = 66 THEN 'Voucher Expired'
                                                WHEN uth.activity = 67 THEN 'Voucher Sent'
                                                WHEN uth.activity = 16 AND uw.coin_id != uth.coin_id AND uw.coin_id != 531 THEN 'Withdrawal Fee'
                                                WHEN uth.activity = 16 AND uw.coin_id IS NULL AND uth.coin_id = 531 THEN 'HNST Withdrawal Fee'
                                                ELSE "unknown"
                                        END as type,
                                        CASE
                                        WHEN uth.activity = 0 THEN 'wallet'
                                                WHEN uth.activity = 1 THEN 'wallet'
                                                WHEN uth.activity = 6 THEN 'wallet'
                                                WHEN uth.activity = 4 THEN 'wallet'
                                                WHEN uth.activity = 5 THEN 'wallet'
                                                WHEN uth.activity = 7 THEN 'staking'
                                                WHEN uth.activity = 8 THEN 'voucher'
                                                WHEN uth.activity = 23 THEN 'wallet'
                                                WHEN uth.activity = 19 THEN 'wallet'
                                                WHEN uth.activity = 25 THEN 'walet'
                                                WHEN uth.activity = 26 THEN 'fund'
                                                WHEN uth.activity = 27 THEN 'fund'
                                                WHEN uth.activity = 30 THEN 'wallet'
                                                WHEN uth.activity = 31 THEN 'wallet'
                                                WHEN uth.activity = 32 THEN 'wallet'
                                                WHEN uth.activity = 33 THEN 'wallet'
                                                WHEN uth.activity = 34 THEN 'wallet'
                                                WHEN uth.activity = 35 THEN 'saving'
                                                WHEN uth.activity = 36 THEN 'saving'
                                                WHEN uth.activity = 37 THEN 'wallet'
                                                WHEN uth.activity = 38 THEN 'wallet'
                                                WHEN uth.activity = 39 THEN 'wallet'
                                                WHEN uth.activity = 40 THEN 'wallet'
                                                WHEN uth.activity = 43 THEN 'staking'
                                                WHEN uth.activity = 44 THEN 'staking'
                                                WHEN uth.activity = 45 THEN 'wallet'
                                                WHEN uth.activity = 49 THEN 'fiat_deposit'
                                                WHEN uth.activity = 50 THEN 'fiat_wd'
                                                WHEN uth.activity = 52 THEN 'voucher'
                                                WHEN uth.activity = 53 THEN 'fiat_trade_plus'
                                                WHEN uth.activity = 54 THEN 'fiat_trade_minus'
                                                WHEN uth.activity = 55 THEN 'wallet'
                                                WHEN uth.activity = 56 THEN 'wallet'
                                                WHEN uth.activity = 57 THEN 'fiat_wd'
                                                WHEN uth.activity = 59 THEN 'fiat_wd'
                                                WHEN uth.activity = 60 THEN 'voucher'
                                                WHEN uth.activity = 61 THEN 'voucher'
                                                WHEN uth.activity = 62 THEN 'voucher'
                                                WHEN uth.activity = 63 THEN 'voucher'
                                                WHEN uth.activity = 64 THEN 'voucher'
                                                WHEN uth.activity = 65 THEN 'voucher'
                                                WHEN uth.activity = 66 THEN 'voucher'
                                                WHEN uth.activity = 67 THEN 'voucher'
                                                WHEN uth.activity = 16 THEN 'wd_fee'
                                                ELSE "unknown"
                                        END as category,
                                        CASE
                                                WHEN uth.activity = 0 THEN '+'
                                                WHEN uth.activity = 1 THEN '+'
                                                WHEN uth.activity = 4 THEN IF(false, '-', '+')
                                                WHEN uth.activity = 6 THEN '-'
                                                WHEN uth.activity = 7 THEN IF(false, '+', '-')
                                                WHEN uth.activity = 8 THEN '+'
                                                WHEN uth.activity = 23 THEN '-'
                                                WHEN uth.activity = 19 THEN '-'
                                                WHEN uth.activity = 25 THEN '+'
                                                WHEN uth.activity = 26 THEN IF(false, '-', '+')
                                                WHEN uth.activity = 27 THEN IF(false, '+', '-')
                                                WHEN uth.activity = 30 THEN '+'
                                                WHEN uth.activity = 31 THEN '+'
                                                WHEN uth.activity = 32 THEN '+'
                                                WHEN uth.activity = 33 THEN '+'
                                                WHEN uth.activity = 34 THEN '+'
                                                WHEN uth.activity = 35 THEN IF(false, '+', '-')
                                                WHEN uth.activity = 36 THEN IF(false, '-', '+')
                                                WHEN uth.activity = 37 THEN '+'
                                                WHEN uth.activity = 38 THEN '+'
                                                WHEN uth.activity = 39 THEN '-'
                                                WHEN uth.activity = 40 THEN '-'
                                                WHEN uth.activity = 43 THEN IF(false, '+', '-')
                                                WHEN uth.activity = 44 THEN IF(false, '-', '+')
                                                WHEN uth.activity = 45 THEN '-'
                                                WHEN uth.activity = 49 THEN '+'
                                                WHEN uth.activity = 50 THEN '-'
                                                WHEN uth.activity = 52 THEN '-'
                                                WHEN uth.activity = 53 THEN '+'
                                                WHEN uth.activity = 54 THEN '-'
                                                WHEN uth.activity = 55 THEN '+'
                                                WHEN uth.activity = 56 THEN '+'
                                                WHEN uth.activity = 60 THEN '+'
                                                WHEN uth.activity = 61 THEN '-'
                                                WHEN uth.activity = 62 THEN '+'
                                                WHEN uth.activity = 63 THEN '+'
                                                WHEN uth.activity = 64 THEN '+'
                                                WHEN uth.activity = 65 THEN '+'
                                                WHEN uth.activity = 66 THEN '+'
                                                WHEN uth.activity = 67 THEN '-'
                                                WHEN uth.activity = 16 THEN '-'
                                                ELSE NULL
                                        END as sign,
                                        COALESCE(uth.price_usd, 0) as price,
                                        COALESCE(uth.price_idr, 0) as price_idr
         FROM user_trx_history uth
                left join user_trx_history_status uts
                        on uth.id = uts.user_trx_history_id
                        and uts.id = (
                                select
                                        max(uths.id)
                                from
                                        user_trx_history_status uths
                                where
                                        uths.user_trx_history_id = uth.id
                        )

                left join mn_master mm
                        on uth.coin_id = mm.id
                 left join user_wd uw on uth.reference_id = uw.id and uth.trx_id = uw.trxid  WHERE  uth.note != 'fraud' AND uth.amount >= 0 AND uth.user_id = '51160' AND ( uth.sku = '920' OR uth.coin_id = '920' ) AND uth.activity IN (26,27,39,0,1,5,6,8,19,23,25,30,31,32,33,34,37,38,55,56,49,50,53,54,52,57,59,60,61,62,63,64,65,66,67,26,27,39,35,36,40,43,44,45,4,7,45,0,1,5,6,8,19,23,25,30,31,32,33,34,37,38,55,56,49,50,53,54,52,57,59,60,61,62,63,64,65,66,67) AND uth.id >= 2345518 ORDER BY uth.created_at DESC, uth.id DESC LIMIT 20 OFFSET 0
