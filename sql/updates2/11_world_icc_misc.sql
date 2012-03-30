UPDATE creature_template SET AIName = "" WHERE entry IN (36725, 36724, 37012, 37007, 36811, 36807, 36829, 36805, 36808, 37098, 37022, 37038, 37023, 10404, 36880, 37664, 37595, 37663, 37901, 37571, 37662, 37665, 37666, 38125, 37127, 37132, 37134, 37133); 
UPDATE `creature_template` SET `ScriptName` = 'npc_NerubarBroodkeeper' WHERE `entry` = 36725;
UPDATE `creature_template` SET `ScriptName` = 'npc_ServantoftheThrone' WHERE `entry` = 36724;
UPDATE `creature_template` SET `ScriptName` = 'npc_AncientSkeletalSoldier' WHERE `entry` = 37012;
UPDATE `creature_template` SET `ScriptName` = 'npc_DeathboundWard' WHERE `entry` = 37007;
UPDATE `creature_template` SET `ScriptName` = 'npc_DeathspeakerAttedant' WHERE `entry` = 36811;
UPDATE `creature_template` SET `ScriptName` = 'npc_DeathspeakerDisciple' WHERE `entry` = 36807;
UPDATE `creature_template` SET `ScriptName` = 'npc_DeathspeakerHighPriest' WHERE `entry` = 36829;
UPDATE `creature_template` SET `ScriptName` = 'npc_DeathspeakerServant' WHERE `entry` = 36805;
UPDATE `creature_template` SET `ScriptName` = 'npc_DeathspeakerZealot' WHERE `entry` = 36808;
UPDATE creature_template SET scriptname = "npc_valkyr_herald" WHERE entry = 37098;
UPDATE creature_template SET scriptname = "npc_blighted_abomination" WHERE entry = 37022;
UPDATE creature_template SET scriptname = "npc_vengeful_fleshreapert" WHERE entry = 37038;
UPDATE creature_template SET scriptname = "npc_plague_scientist" WHERE entry = 37023;
UPDATE creature_template SET scriptname = "npc_pustulating_horror" WHERE entry = 10404;
UPDATE creature_template SET scriptname = "npc_decaying_colossus" WHERE entry = 36880;
UPDATE creature_template SET scriptname = "npc_darkfallen_archmage" WHERE entry = 37664;
UPDATE creature_template SET scriptname = "npc_darkfallen_blood_knight" WHERE entry = 37595;
UPDATE creature_template SET scriptname = "npc_darkfallen_noble" WHERE entry = 37663;
UPDATE creature_template SET scriptname = "npc_vampiric_fiend" WHERE entry = 37901;
UPDATE creature_template SET scriptname = "npc_darkfallen_advisor" WHERE entry = 37571;
UPDATE creature_template SET scriptname = "npc_darkfallen_commander" WHERE entry = 37662;
UPDATE creature_template SET scriptname = "npc_darkfallen_lieutenant" WHERE entry = 37665;
UPDATE creature_template SET scriptname = "npc_darkfallen_tactician" WHERE entry = 37666;
UPDATE creature_template SET scriptname = "npc_ymirjar_deathbringer" WHERE entry = 38125;
UPDATE creature_template SET scriptname = "npc_ymirjar_frostbinder" WHERE entry = 37127;
UPDATE creature_template SET scriptname = "npc_ymirjar_battlemaiden" WHERE entry = 37132;
UPDATE creature_template SET scriptname = "npc_ymirjar_huntress" WHERE entry = 37134;
UPDATE creature_template SET scriptname = "npc_ymirjar_warlord" WHERE entry = 37133;

-- AreaTrigger
DELETE FROM `areatrigger_scripts` WHERE `entry` = 5623;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(5623, 'at_icc_start_sindragosa_gauntlet');

-- Template
DELETE FROM `creature_template` WHERE `entry` = 37503;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES
(37503, 0, 0, 0, 0, 0, 19725, 25455, 0, 0, 'Sindragosa\'s Ward', '', '', 0, 83, 83, 2, 35, 35, 0, 1, 1.14286, 1, 0, 496, 674, 0, 783, 1, 0, 0, 2, 33555200, 8, 0, 0, 0, 0, 0, 365, 529, 98, 10, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128, 'npc_sindragosa_ward', 12340);

-- Spawn
SET @GUID = 14570086;
DELETE FROM `creature` WHERE `id` = 37503;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@GUID, 37503, 631, 1, 1, 0, 0, 4181.18, 2484.12, 242.349, 0.0117905, 300, 0, 0, 27890000, 8516000, 0, 0, 0, 0);

-- Equip for darkfallen blood knight
DELETE FROM creature_equip_template WHERE entry = 37595;
INSERT INTO creature_equip_template VALUES (37595, 51028, 0, 0);
UPDATE creature_template SET equipment_id = 37595 WHERE entry = 37595;

-- Equip for darkfallen tactician
DELETE FROM creature_equip_template WHERE entry = 37666;
INSERT INTO creature_equip_template VALUES (37666, 51029, 51029, 0);
UPDATE creature_template SET equipment_id = 37666 WHERE entry = 37666;

-- Equip for darkfallen commander
DELETE FROM creature_equip_template WHERE entry = 37662;
INSERT INTO creature_equip_template VALUES (37662, 51322, 0, 0);
UPDATE creature_template SET equipment_id = 37662 WHERE entry = 37662;

-- Equip for darkfallen lieutenant
DELETE FROM creature_equip_template WHERE entry = 37665;
INSERT INTO creature_equip_template VALUES (37665, 51323, 51324, 0);
UPDATE creature_template SET equipment_id = 37662 WHERE entry = 37665;
