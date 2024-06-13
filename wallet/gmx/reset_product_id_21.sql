update eg_gmx_glps
set glp_amount=0,
    glp_amount_usd = 0,
    glp_amount_debit = 0,
    glp_amount_debit_usd = 0,
    glp_amount_credit = 0,
    glp_amount_credit_usd = 0,
    reward_balance = 0,
    reward_amount = 0,
    reward_amount_usd = 0,
    total_usd = 0,
    gas_used_amount = 0,
    gas_used_amount_usd = 0
where id = 1
limit 1;



delete
from eg_gmx_glp_buys
where gmx_glp_id = 1;

delete
from eg_gmx_glp_sells
where gmx_glp_id = 1;

delete
from eg_gmx_glp_movements
where gmx_glp_id = 1;

delete
from eg_gmx_glp_rewards
where gmx_glp_id = 1;

delete
from eg_gmx_glp_redeems
where gmx_glp_id = 1;

delete
from eg_gainlosses
where product_id = 21;
delete
from eg_deposits
where product_id = 21;
delete
from eg_withdraws
where product_id = 21;
delete
from eg_journals
where product_id = 21;

delete
from eg_assets
where product_id = 21;