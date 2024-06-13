ALTER TABLE `custody_address`
    ADD `network` varchar(255) DEFAULT '';

ALTER TABLE `custody_vault`
    ADD `network` varchar(255) DEFAULT '';

ALTER TABLE `user_transfer_in`
    ADD `network` varchar(255) DEFAULT '';

ALTER TABLE `mn_fee_master`
	ADD `network` varchar (255) DEFAULT '';

ALTER TABLE `user_wd`
	ADD `network` varchar (255) DEFAULT '';



# Run This Command on BEMN
# php artisan custody:seed-address-network
# php artisan custody:seed-vault

INSERT INTO custody_vault (custody_id, coin_id, custody_vault_id, vault_name, active, asset_id, vault_type, created_at,
                           updated_at, created_by, updated_by, network)
VALUES (1, 913, '181', 'DEV_PL_TRX_HOT', 1, 'USDT_TRX_TEST4', 2, NOW(), NOW(), 1, 1, 'TRX');

INSERT INTO custody_asset (coin_id, ticker, custody_id, asset_id, name, type, contractAddress, nativeAsset, decimals,
                           created_at, updated_at, created_by, updated_by)
VALUES (913, 'USDT', 1, 'USDT_TRX_TEST4', 'Tether (Tron)', '2', 'TG3XXyExBkPp9nzdajDZsozEu4BkaSJozs', 'TRX_TEST', 6,
        NOW(), NOW(), 1, 1);

INSERT INTO mn_fee_master (coin_id, fixed_fee_amount, float_fee_percent, fee, fee_type, hnst_fixed_fee_amount,
                           hnst_float_fee_percent, hnst_percent_discount, fee_text, disallow_hnst_fee, created_by,
                           updated_by, created_at, updated_at, network)
VALUES (913, 1.00000000, 0.00, 0.00000000, 5, 0.00000000, 0.00, 0.00, '', 0, 1, 1, '2022-07-18 07:21:29',
        '2023-11-01 02:45:06', 'TRX');


create table custody_gas_station
(
    id         int auto_increment,
    network    varchar(255)           null,
    asset_id   varchar(255)           null,
    address    varchar(255)           null,
    active     int      default 1     null,
    created_at datetime default NOW() null,
    updated_at datetime default NOW() null,
    constraint custody_gas_station_pk
        primary key (id)
);

INSERT INTO custody_gas_station (id, network, asset_id, address, active, created_at, updated_at)
VALUES (1, 'ETH', 'ETH_TEST3', '0x626F095aB6C053E7a4053C80409e23925aa92f77', 1, '2023-11-05 07:06:41',
        '2023-11-05 07:06:41');
INSERT INTO custody_gas_station (id, network, asset_id, address, active, created_at, updated_at)
VALUES (2, 'TRX', 'TRX_TEST', 'TPvNGSsjUp4yL8cbc13e9WJrJpW6JpFpoG', 1, '2023-11-05 07:07:11', '2023-11-05 07:07:11');

-- THIS IS NOT EXECUTED YET ON DEV
ALTER TABLE `mn_balance`
	ADD `network` varchar (255) DEFAULT '';