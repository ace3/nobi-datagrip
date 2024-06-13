

SELECT
    user_wallet_2023.user_id,
    MAX(CASE WHEN dbmaster.mn_master.ticker = 'HNST' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'HNST',
    MAX(CASE WHEN dbmaster.mn_master.ticker = 'DASH' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'DASH',
    MAX(CASE WHEN dbmaster.mn_master.ticker = 'ONE' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'ONE',
    MAX(CASE WHEN dbmaster.mn_master.ticker = 'VEX' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'VEX',
    MAX(CASE WHEN dbmaster.mn_master.ticker = 'DAI' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'DAI',
    MAX(CASE WHEN dbmaster.mn_master.ticker = 'BTC' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'BTC',
    MAX(CASE WHEN dbmaster.mn_master.ticker = 'USDT' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'USDT',
    MAX(CASE WHEN dbmaster.mn_master.ticker = 'UNI' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'UNI',
    MAX(CASE WHEN dbmaster.mn_master.ticker = 'USDC' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'USDC',
    MAX(CASE WHEN dbmaster.mn_master.ticker = 'ETH' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'ETH',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'COMP' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'COMP',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'XZC' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'XZC',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'BNB' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'BNB',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'ADA' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'ADA',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'MATIC' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'MATIC',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'SOL' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'SOL',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'DOT' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'DOT',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'AVAX' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'AVAX',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'DOGE' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'DOGE',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'ATOM' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'ATOM',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'PEPE' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'PEPE',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'FTM' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'FTM',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'FTM' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'FTM',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'ALGO' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'ALGO',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'OP' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'OP',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'ARB' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'ARB',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'XRP' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'XRP',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'SHIB' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'SHIB',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'LINK' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'LINK',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'PENDLE' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'PENDLE',
MAX(CASE WHEN dbmaster.mn_master.ticker = '1INCH' THEN user_wallet_2023.amount_available ELSE 0 END) AS '1INCH',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'SNX' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'SNX',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'ICP' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'ICP',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'SUI' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'SUI',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'ARKM' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'ARKM',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'XNO' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'XNO',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'PENDLE' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'PENDLE',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'STX' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'STX',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'RNDR' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'RNDR',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'DYDX' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'DYDX',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'APE' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'APE',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'TRX' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'TRX',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'CRV' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'CRV',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'XLM' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'XLM',
MAX(CASE WHEN dbmaster.mn_master.ticker = 'GALA' THEN user_wallet_2023.amount_available ELSE 0 END) AS 'GALA'
    -- Add more ticker symbols here as needed
FROM
    hmlog.user_wallet_2023
    INNER JOIN dbmaster.mn_master ON hmlog.user_wallet_2023.coin_id = mn_master.id
WHERE
    dbmaster.mn_master.ticker NOT IN ('HNSTERC20', 'PIVX', 'RPD', 'IDRT', 'SMART')
    AND hmlog.user_wallet_2023.user_id IN (
        28, 57262, 73210, 19169, 17394, 21, 24688, 151, 21980, 47548, 773,
        11437, 20707, 34295, 5065, 24888, 16622, 72934, 24003, 20796, 23874,
        73133, 35433, 18452, 21122, 20896, 63659, 35426, 41660, 28338, 60739,
        21717, 19691, 25206, 26475, 32885
    )
GROUP BY
    hmlog.user_wallet_2023.user_id;


-- selected tickers
SELECT hmlog.user_wallet_2023.user_id,
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'ADA' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'ADA',
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'BNB' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'BNB',
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'BTC' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'BTC',
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'DAI' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'DAI',
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'DASH' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'DASH',
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'DOT' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'DOT',
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'ETH' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'ETH',
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'MATIC' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'MATIC',
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'ONE' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'ONE',
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'SOL' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'SOL',
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'UNI' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'UNI',
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'USDC' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'USDC',
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'USDT' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'USDT',
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'VEX' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'VEX',
       MAX(CASE
               WHEN dbmaster.mn_master.ticker = 'XZC' THEN hmlog.user_wallet_2023.amount_available
               ELSE 0 END)                                                                                        AS 'XZC'
-- Add more ticker symbols here as needed
FROM hmlog.user_wallet_2023
         INNER JOIN mn_master ON hmlog.user_wallet_2023.coin_id = mn_master.id
WHERE dbmaster.mn_master.ticker NOT IN ('HNSTERC20', 'PIVX', 'RPD', 'IDRT', 'SMART')
#   AND hmlog.user_wallet_2023.user_id IN (
#                                          28, 57262, 73210, 19169, 17394, 21, 24688, 151, 21980, 47548, 773,
#                                          11437, 20707, 34295, 5065, 24888, 16622, 72934, 24003, 20796, 23874,
#                                          73133, 35433, 18452, 21122, 20896, 63659, 35426, 41660, 28338, 60739,
#                                          21717, 19691, 25206, 26475, 32885
#     )
GROUP BY hmlog.user_wallet_2023.user_id;

