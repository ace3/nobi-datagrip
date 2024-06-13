SELECT *,STR_TO_DATE(REPLACE(JSON_EXTRACT(information, '$.last_updated'),'"',''), '%Y-%m-%dT%H:%i:%s.%fZ')
FROM gecko_gecko_informations
WHERE STR_TO_DATE(REPLACE(JSON_EXTRACT(information, '$.last_updated'),'"',''), '%Y-%m-%dT%H:%i:%s.%fZ') < DATE_SUB(NOW(), INTERVAL 1 HOUR);

select JSON_EXTRACT(information, '$.last_updated') from gecko_gecko_informations;
select STR_TO_DATE(REPLACE(JSON_EXTRACT(information, '$.last_updated'),'"',''), '%Y-%m-%dT%H:%i:%s.%fZ') from gecko_gecko_informations;


SELECT *,STR_TO_DATE(REPLACE(JSON_EXTRACT(information, '$.last_updated'),'"',''), '%Y-%m-%dT%H:%i:%s.%fZ') as last_sync
FROM gecko_gecko_informations
WHERE updated_at < DATE_SUB(NOW(), INTERVAL 60 MINUTE)
order by updated_at ASC;
