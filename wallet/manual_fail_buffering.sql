update `broker_bf_crypto_request` set `status` = 5, `updated_at` = NOW() where `id` = 472;

INSERT INTO `broker_bf_request_history` ( `type`, `request_id`, `admin_id`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(	'crypto',	472,	18,	5,	'Request has been rejected',	NOW(),	NOW());