SET NAMES 'latin1';

DELETE FROM `gameobject` WHERE `id`=186267;
DELETE FROM `game_event_gameobject` WHERE `guid`=54947;
DELETE FROM `gameobject_questrelation` WHERE `id`=186267;

UPDATE `gameobject_template` SET `ScriptName`='go_pumpkin_shrine' WHERE `entry`=186267;
UPDATE `creature_template` SET `ScriptName`='npc_horseman_head' WHERE `entry`=23775;

-- heal body
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=43306;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13, 43306, 18, 1, 23682);

-- set lfg flag
UPDATE `quest_template` SET `SpecialFlags`=9 WHERE `id`=25482;

-- temporary
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry` IN (23686, 24034, 23694);

-- immunitys
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|1|2|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (23682,23775);

-- loot
DELETE FROM `creature_loot_template` WHERE `entry`=23682 AND `item` IN (33154,33292,37012,49126,49128,37011);

DELETE FROM `item_loot_template` WHERE `entry`=54516;
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(54516,33154, 25,1,0, 1, 1),
(54516,33292, 33,1,0, 1, 1),
(54516,37012,  3,1,0, 1, 1),
(54516,49126,  5,1,0, 1, 1),
(54516,49128,  8,1,0, 1, 1),
(54516,37011, 25,1,0, 1, 1),
(54516,40753,100,1,0, 2, 2),
(54516,34068, 33,1,0, 3, 6),
(54516,33226,100,1,0,20,20);

-- spawn
SET @guid := 303110;

DELETE FROM `creature` WHERE `id`=23682;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@guid,'23682','189','1','1','0','0','1763.1','1347.73','17.5602','6.20833','10','0','0','126000','3994','0','0','0','0');

-- tricky or treat
DELETE FROM `spell_script_names` WHERE `spell_id`=44436;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(44436, 'spell_gen_tricky_treat');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (42965,42966);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(42965,42919,0, 'Hallows End - Tricky Treat'),
(42966,-42965,0, 'Hallows End - Upset Tummy removes Tricky Treat'),
(42966,-42919,0, 'Hallows End - Upset Tummy removes Tricky Treat');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=44436;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`) VALUES
(17, 44436, 11, 42966);

-- Script texts
DELETE FROM script_texts WHERE entry IN (-1189100, -1189101, -1189103, -1189102, -1189104, -1189105, -1189106, -1189107);
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (23682, -1189100, "Ihr sied am Ziel, die Suche ist vorbei. Das Schicksal soll entscheiden, wer der Sieger sei.", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11961, 0, 0, 0, 'headless horseman SAY_ENTRANCE');
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (23775, -1189102, "Komm hier her du Idiot!", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12569, 0, 0, 0, 'headless horseman SAY_LOST_HEAD');
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (23775, -1189103, "Hier drüben bin ich, schwachsinniger Körper", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12568, 0, 0, 0, 'headless horseman SAY_LOST_HEAD');
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (23682, -1189101, "Hier bin ich, mein Körper rein! Eure Seelen sind bald mein!", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12567, 0, 0, 0, 'headless horseman SAY_REJOINED');
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (23682, -1189105, "Soldaten erhebt Euch und kämpft immer weiter! Bringt endlich den Sieg zum gefallenen Reiter!", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11963, 0, 0, 0, 'headless horseman SAY_SPROUTING_PUMPKINS');
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (23682, -1189104, "Hört her Ihr Hunde! Mein Hass ist Euer! Und nun... spürt das Feuer!", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12574, 0, 0, 0, 'headless horseman SAY_CONFLAGRATION');
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (23682, -1189107, "Dieses Ende ist mir schon bekannt. Welch neue Abenteuer hat das Schicksal zur Hand?", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11964, 0, 0, 0, 'headless horseman SAY_DEATH');
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (23682, -1189106, "Euer Körper ist geschlagen, gemartert, gebrochen. Mein Fluch ruhe auf Euch, das Schicksal hat gesprochen.", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11962, 0, 0, 0, 'headless horseman SAY_PLAYER_DEATH');

-- Correct equip template
REPLACE INTO `creature_equip_template` (`entry`, `itemEntry1`, `itemEntry2`, `itemEntry3`) VALUES (3001, 49128, 0, 0);

UPDATE creature_template SET equipment_id = 3001 WHERE entry = 23682;

UPDATE `creature_template` SET `ScriptName`='mob_pulsing_pumpkin' WHERE `entry` = 23694;
UPDATE `creature_template` SET `ScriptName`='mob_wisp_invis', `faction_A`=35, `faction_H`=35, `unit_flags`='33554434' WHERE `entry`='23686';
UPDATE `creature_template` SET `ScriptName`='mob_wisp_invis', `unit_flags`='33554434' WHERE `entry`='24034';
UPDATE creature_template SET faction_a= 14, faction_h= 14 WHERE entry =23545;
UPDATE creature_template SET minlevel= 80, maxlevel= 80 WHERE entry = 23545;

-- Fix Loot-Filled Pumpkin's loot`creature_template_addon`
DELETE FROM `item_loot_template` WHERE `entry` = 54516;
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 33292, 0, 1, 1, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 33154, 0, 1, 1, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 33176, 0, 1, 1, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 49128, 0, 1, 1, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 49126, 0, 1, 1, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 37012, 0, 1, 1, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20569, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 34003, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20572, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20567, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20391, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20570, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20573, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 34000, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20562, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20392, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20565, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20563, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20571, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20574, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20561, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20564, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 34001, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20568, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 20566, 0, 1, 2, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (54516, 34002, 0, 1, 2, 1, 1);