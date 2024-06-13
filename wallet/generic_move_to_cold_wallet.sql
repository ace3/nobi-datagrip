select `custody_address`.`address`,
       `custody_vault_accountbased`.`base_coin_id`,
       `mn_master_option`.`coin_id`,
       `mn_master_option`.`cw_balance_id`,
       `mn_master_option`.`treshold_balance`,
       COALESCE(SUM(amount), 0) as amount_total
from `user_transfer_in`
         inner join `mn_master_option` on
    `user_transfer_in`.`coin_id` = `mn_master_option`.`coin_id`
         inner join `custody_address` on `user_transfer_in`.`user_id`
    = `custody_address`.`user_id`
         inner join `custody_vault_accountbased` on `custody_address`.`user_id` =
                                                    `custody_vault_accountbased`.`user_id` and
                                                    `custody_address`.`external_vault_id` =
                                                    `custody_vault_accountbased`.`custody_vault_id`
where `custody_address`.`coin_id` = 922
  and `mn_master_option`.`active` =
      1
  and `mn_master_option`.`is_eth_token` = 1
  and `is_sendtocw` = 0
  and `user_transfer_in`.`user_id` > 0
  and amount >=
      mn_master_option.min_transfer
  and unix_timestamp(user_transfer_in.created_at) < 1689585507
  and `mn_master_option`.`ticker` = 'DOT'
group by `custody_address`.`address`, `mn_master_option`.`coin_id`,
         `mn_master_option`.`cw_balance_id`, `mn_master_option`.`treshold_balance`
having amount_total >= treshold_balance