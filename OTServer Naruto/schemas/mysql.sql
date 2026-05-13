select * from accounts;

select * from server_config;
INSERT INTO `nbbot`.`server_config` (`config`, `value`) 
VALUES ('db_version', '2');

DROP TABLE job_batches;

DELETE FROM player_storage 
WHERE player_id = (SELECT id FROM players WHERE name = 'AAAAAAA') 
AND `key` >= 34090 AND `key` <= 34100;

##isac mission
DELETE FROM player_storage 
WHERE player_id = (SELECT id FROM players WHERE name = 'AAAAAAA') 
AND `key` IN (2701, 2705, 2706, 2707, 2708, 9851, 88888);

-- reset sagas
UPDATE player_storage 
SET value = 1 
WHERE `key` = 11000 
AND player_id = (SELECT id FROM players WHERE name = 'AAAAAAA');

-- voltar para antes dos demon brothers
UPDATE `player_storage` 
SET `value` = CASE 
    WHEN `key` = 11000 THEN 9 -- Volta SAGA_STORAGE para SAGA_STAGE_FIRST_MISSION
    WHEN `key` = 11003 THEN 0 -- Reseta SAGA_AUX_DEMON_BROS_EVENT
    WHEN `key` = 11004 THEN 0 -- Reseta SAGA_AUX_DEMON_BROS_KILLCOUNT
    WHEN `key` = 11006 THEN 0 -- Reseta SAGA_AUX_WAVES_ROAD_TALKSTATE
    ELSE `value` 
END
WHERE `player_id` = (SELECT `id` FROM `players` WHERE `name` = 'AAAAAAA')
AND `key` IN (11000, 11003, 11004, 11006);

DELETE FROM `player_storage` WHERE `player_id` = (SELECT `id` FROM `players` WHERE `name` = 'AAAAAAA') 
AND `key` IN (12001, 12002, 12003, 12004, 12005, 12006, 12007, 12008, 12010, 12011, 12030, 12036);

INSERT INTO `accounts` (`id`, `name`, `password`, `premdays`, `type`) 
VALUES (NULL, 'jhonjhon', '123456789', 30, 1);

ALTER TABLE `players` ADD `attribute_points` INT(11) NOT NULL DEFAULT 0;

SHOW TRIGGERS;
DROP TRIGGER IF EXISTS `oncreate_players`;

DELETE FROM `players`
WHERE id=1;

select * from accounts;
select * from players;
select * from player_storage;
select * from player_skills;
select * from player_akamarus;
select * from player_akamaru_outfits;

select * from account_viplist;
select * from bans;

select * from killers;
select * from player_deaths;
select * from environment_killers;

select * from failed_jobs;
select * from global_storage;

select * from guilds;
select * from guild_ranks;
select * from guild_invites;

select * from houses;
select * from house_lists;
select * from house_data;
select * from house_auctions;

select * from jobs;
select * from job_batches;

select * from player_akamarus;

select * from player_depotitems;
select * from player_items;
select * from player_namelocks;
select * from player_skills;
select * from player_spells;

select * from player_storage;
select * from player_viplist;
select * from server_config;
select * from server_motd;
select * from server_record;
select * from server_reports;
select * from tile_items;
select * from tiles;




