truncate table dbmaster.fund_exchange_ledger;
truncate table dbmaster.fund_strategy_ledger;

update `saving_market` set `saving_market_ledger_id` = 0  where id <999;
truncate table dbmaster.saving_market_ledger;