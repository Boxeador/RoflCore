-- Add some missing guids
SET @GUID := 42153;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+4;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES 
(@GUID,32666,530,1,0,0,0,9830.201,-7389.711,13.68803,5.532694,120,0,0,1,0,0),
(@GUID+1,32667,530,1,0,0,0,9859.044,-7406.975,13.7113,1.658063,120,0,0,1,0,0),
(@GUID+2,31144,530,1,0,0,0,9869.401,-7389.657,13.69022,3.90953755,120,0,0,1,0,0),
(@GUID+3,31144,530,1,0,0,0,9871.973,-7392.763,13.6818113,3.35103226,120,0,0,1,0,0),
(@GUID+4,31146,530,1,0,0,0,9850.529,-7395.442,13.72216,4.694936,120,0,0,1,0,0);
-- Addons
DELETE FROM `creature_addon` WHERE `guid` BETWEEN @GUID AND @GUID+4;
DELETE FROM `creature_addon` WHERE `guid`=66686;
INSERT INTO `creature_addon` (`guid`,`bytes2`,`auras`) VALUES
(@GUID,1, '7056 61573'),
(@GUID+1,1, '7056 61573'),
(@GUID+2,1, '7056 61573'),
(@GUID+3,1, '7056 61573'),
(@GUID+4,1, '7056 61573'),
(66686,1, '7056');
-- convert npc to trigger
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry`=18504;


-- SAI for Champion Vranesh
SET @ENTRY=18146;
UPDATE `creature` SET `position_x`=9834.044,`position_y`=-7480.845,`position_z`=14.93467 WHERE `id`=@ENTRY;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
UPDATE `creature_template_addon` SET `mount`=0 WHERE `entry`=@ENTRY; -- 19085
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid` IN (@ENTRY*100,@ENTRY*100+1,@ENTRY*100+2,@ENTRY*100+3,@ENTRY*100+4);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- AI
(@ENTRY,0,0,0,11,0,100,1,0,0,0,0,53,0,@ENTRY,1,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On respawn - load path'),
(@ENTRY,0,1,2,40,0,100,0,7,@ENTRY,0,0,54,6000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Pause Path'),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,80,@ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Run Script'),
(@ENTRY,0,3,4,40,0,100,0,11,@ENTRY,0,0,54,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Pause Path'),
(@ENTRY,0,4,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Run Script'),
(@ENTRY,0,5,6,40,0,100,0,25,@ENTRY,0,0,54,8000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Pause Path'),
(@ENTRY,0,6,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Run Script'),
(@ENTRY,0,7,8,40,0,100,0,34,@ENTRY,0,0,54,8000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Pause Path'),
(@ENTRY,0,8,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Run Script'),
(@ENTRY,0,9,10,40,0,100,0,50,@ENTRY,0,0,54,7000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Pause Path'),
(@ENTRY,0,10,0,61,0,100,0,0,0,0,0,80,@ENTRY*100+4,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Run Script'),
(@ENTRY,0,11,0,40,0,100,0,57,@ENTRY,0,0,54,600000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - On waypoint reached - Pause Path'),
-- Script 0
(@ENTRY*100,9,0,0,0,0,100,0,3500,3500,3500,3500,5,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - Script 0 - emote bow'),
-- Script 1
(@ENTRY*100+1,9,0,0,0,0,100,0,100,100,100,100,43,0,19085,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - Script 1 - mount horse'),
(@ENTRY*100+1,9,1,0,0,0,100,0,100,100,100,100,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - Script 1 - say 0'),
(@ENTRY*100+1,9,2,0,0,0,100,0,100,100,100,100,5,16,0,0,0,0,0,11,16222,10,0,0,0,0,0,'Champion Vranesh - Script 1 - Silvermoon City Guardian emote bow'),
(@ENTRY*100+1,9,3,0,0,0,100,0,100,100,100,100,1,0,0,0,0,0,0,19,16222,10,0,0,0,0,0,'Champion Vranesh - Script 1 - Silvermoon City Guardian say 0'),
-- Script 2
(@ENTRY*100+2,9,0,0,0,0,100,0,3000,3000,3000,3000,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - Script 2 - say 1'),
(@ENTRY*100+2,9,1,0,0,0,100,0,100,100,100,100,5,16,0,0,0,0,0,11,16222,18,0,0,0,0,0,'Champion Vranesh - Script 2 - Silvermoon City Guardian emote bow'),
(@ENTRY*100+2,9,2,0,0,0,100,0,100,100,100,100,1,1,0,0,0,0,0,19,16222,18,0,0,0,0,0,'Champion Vranesh - Script 2 - Silvermoon City Guardian say 1'),
-- Script 3
(@ENTRY*100+3,9,0,0,0,0,100,0,3000,3000,3000,3000,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - Script 3 - say 2'),
(@ENTRY*100+3,9,1,0,0,0,100,0,100,100,100,100,5,16,0,0,0,0,0,11,16222,30,0,0,0,0,0,'Champion Vranesh - Script 3 - Silvermoon City Guardian emote bow'),
-- Script 4
(@ENTRY*100+4,9,0,0,0,0,100,0,1000,1000,1000,1000,43,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - Script 4 - dismount horse'),
(@ENTRY*100+4,9,1,0,0,0,100,0,1000,1000,1000,1000,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Champion Vranesh - Script 3 - say 3');

-- NPC talk text for Champion Vranesh and Silvermoon City Guardian
DELETE FROM `creature_text` WHERE `entry` IN (@ENTRY,16222);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0, 'Champion Vranesh inclines his head slightly to the pair of guardians in greeting.',16,1,100,0,0,0, 'Champion Vranesh'),
(@ENTRY,1,0, 'Champion Vranesh arches a scrulpled brow at the guards. a disapproving scowl on his face',16,1,100,0,0,0, 'Champion Vranesh'),
(@ENTRY,2,0, 'Champion Vranesh glances from guard to guard.',16,1,100,0,0,0, 'Champion Vranesh'),
(@ENTRY,3,0, 'Champion Vranesh surveys the small ranger practice ground with a condescending smirk.',16,1,100,0,0,0, 'Champion Vranesh'),
(16222,0,0, 'Glory to the Sun K-- ah... Silvermoon!',12,1,100,0,0,0, 'Silvermoon City Guardian'),
(16222,1,0, 'Our lives are yours, Blood Knight.',12,1,100,0,0,0, 'Silvermoon City Guardian');

-- Pathing for Champion Vranesh
DELETE FROM `waypoints` WHERE `entry`=@ENTRY;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@ENTRY,1,9834.044,-7480.845,14.93467, 'Champion Vranesh'),
(@ENTRY,2,9829.106,-7493.609,14.93653, 'Champion Vranesh'),
(@ENTRY,3,9826.172,-7516.15,19.73714, 'Champion Vranesh'),
(@ENTRY,4,9841.332,-7518.849,19.70547, 'Champion Vranesh'),
(@ENTRY,5,9845.063,-7512.885,19.68096, 'Champion Vranesh'),
(@ENTRY,6,9850.942,-7512.470,19.71548, 'Champion Vranesh'),
(@ENTRY,7,9850.934,-7513.604,19.71813, 'Champion Vranesh'), -- pause 6000
(@ENTRY,8,9872.733,-7517.256,19.75283, 'Champion Vranesh'),
(@ENTRY,9,9872.419,-7489.979,14.91272, 'Champion Vranesh'),
(@ENTRY,10,9851.401,-7490.209,14.93464, 'Champion Vranesh'),
(@ENTRY,11,9850.948,-7470.096,14.91403, 'Champion Vranesh'), -- pause 1000
(@ENTRY,12,9851.16,-7469.154,14.91319, 'Champion Vranesh'),
(@ENTRY,13,9849.688,-7442.579,13.50931, 'Champion Vranesh'),
(@ENTRY,14,9848.726,-7423.561,13.31949, 'Champion Vranesh'),
(@ENTRY,15,9816.583,-7423.817,13.30332, 'Champion Vranesh'),
(@ENTRY,16,9794.673,-7424.877,13.50989, 'Champion Vranesh'),
(@ENTRY,17,9794.48,-7442.293,14.40225, 'Champion Vranesh'),
(@ENTRY,18,9767.989,-7442.611,14.39258, 'Champion Vranesh'),
(@ENTRY,19,9767.406,-7422.982,13.35852, 'Champion Vranesh'),
(@ENTRY,20,9739.563,-7422.83,13.28878, 'Champion Vranesh'),
(@ENTRY,21,9736.46,-7440.873,13.53963, 'Champion Vranesh'),
(@ENTRY,22,9740.345,-7464.682,13.57483, 'Champion Vranesh'),
(@ENTRY,23,9746.739,-7482.594,13.55744, 'Champion Vranesh'),
(@ENTRY,24,9748.767,-7486.576,13.54981, 'Champion Vranesh'),
(@ENTRY,25,9753.25,-7486.52,13.5461, 'Champion Vranesh'), -- pause 8000
(@ENTRY,26,9720.037,-7486.478,13.52865, 'Champion Vranesh'),
(@ENTRY,27,9681.502,-7475.868,13.52783, 'Champion Vranesh'),
(@ENTRY,28,9666.59,-7479.547,13.53783, 'Champion Vranesh'),
(@ENTRY,29,9638.033,-7492.629,13.50889, 'Champion Vranesh'),
(@ENTRY,30,9620.123,-7488.486,13.53853, 'Champion Vranesh'),
(@ENTRY,31,9605.795,-7475.276,13.55774, 'Champion Vranesh'),
(@ENTRY,32,9597.921,-7460.307,13.54336, 'Champion Vranesh'),
(@ENTRY,33,9594.605,-7450.369,13.5353, 'Champion Vranesh'),
(@ENTRY,34,9592.944,-7450.381,13.53116, 'Champion Vranesh'), -- pause 8000
(@ENTRY,35,9594.605,-7450.369,13.5353, 'Champion Vranesh'),
(@ENTRY,36,9615.793,-7419.515,13.30549, 'Champion Vranesh'),
(@ENTRY,37,9654.939,-7420.383,13.29342, 'Champion Vranesh'),
(@ENTRY,38,9673.072,-7429.818,13.2933, 'Champion Vranesh'),
(@ENTRY,39,9689.373,-7431.429,13.2933, 'Champion Vranesh'),
(@ENTRY,40,9709.577,-7422.25,13.2933, 'Champion Vranesh'),
(@ENTRY,41,9722.3,-7415.217,13.39988, 'Champion Vranesh'),
(@ENTRY,42,9748.049,-7414.597,13.32135, 'Champion Vranesh'),
(@ENTRY,43,9766.792,-7413.542,13.38617, 'Champion Vranesh'),
(@ENTRY,44,9767.26,-7396.828,14.43101, 'Champion Vranesh'),
(@ENTRY,45,9793.145,-7395.393,14.3936, 'Champion Vranesh'),
(@ENTRY,46,9794.217,-7415.122,13.48684, 'Champion Vranesh'),
(@ENTRY,47,9817.575,-7415.299,13.30596, 'Champion Vranesh'),
(@ENTRY,48,9837.021,-7414.861,13.30863, 'Champion Vranesh'),
(@ENTRY,49,9848.048,-7414.794,13.31137, 'Champion Vranesh'),
(@ENTRY,50,9848.199,-7414.07,13.31068, 'Champion Vranesh'), -- pause 7000
(@ENTRY,51,9847.695,-7415.903,13.31243, 'Champion Vranesh'),
(@ENTRY,52,9848.259,-7428.576,13.33225, 'Champion Vranesh'),
(@ENTRY,53,9846.748,-7446.964,13.56501, 'Champion Vranesh'),
(@ENTRY,54,9850.373,-7465.03,14.9097, 'Champion Vranesh'),
(@ENTRY,55,9850.84,-7480.409,14.93768, 'Champion Vranesh'),
(@ENTRY,56,9840.165,-7480.267,14.92917, 'Champion Vranesh'),
(@ENTRY,57,9843.284,-7480.133,14.92655, 'Champion Vranesh'); -- pause 60000

-- SAI for Silvermoon Farstrider
SET @ENTRY=18507;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,25,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Farstrider - Reset - Set Phase 1'),
(@ENTRY,0,1,2,1,1,100,0,3000,3000,5000,5000,11,36802,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Farstrider - OOC - Cast Spell (Phase 1)'),
(@ENTRY,0,2,0,61,1,100,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Farstrider - OOC - Set Phase 2 (Phase 1)'),
(@ENTRY,0,3,4,1,2,100,0,3000,3000,5000,5000,11,36803,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Farstrider - OOC - Cast Spell (Phase 2)'),
(@ENTRY,0,4,0,61,2,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Farstrider - OOC - Set Phase 1 (Phase 2)');
-- SAI for Silvermoon Ranger
SET @ENTRY=18147;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (-64950,-64951,-64952,-64953);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(-64950,0,0,0,1,0,100,0,18000,22000,18000,22000,11,29121,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Ranger - OOC - Cast Spell'),
(-64951,0,0,0,1,0,100,0,18000,22000,18000,22000,11,29121,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Ranger - OOC - Cast Spell'),
(-64952,0,0,0,1,0,100,0,18000,22000,18000,22000,11,29120,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Ranger - OOC - Cast Spell'),
(-64953,0,0,0,1,0,100,0,18000,22000,18000,22000,11,29122,0,0,0,0,0,1,0,0,0,0,0,0,0,'Silvermoon Ranger - OOC - Cast Spell');

-- Silvermoon City Guardian pathing
SET @NPC := 56902;
SET @PATH := @NPC*10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=9595.755,`position_y`=-7366.754,`position_z`=13.50131 WHERE `guid`=@NPC;
UPDATE `creature_addon` SET `path_id`=@PATH WHERE `guid`=@NPC;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9595.755,-7366.754,13.50131,0,0,0,100,0),
(@PATH,2,9594.553,-7336.536,14.15131,0,0,0,100,0),
(@PATH,3,9586.897,-7325.241,14.1312,0,0,0,100,0),
(@PATH,4,9561.705,-7326.179,14.05934,0,0,0,100,0),
(@PATH,5,9519.901,-7327.064,14.12175,0,0,0,100,0),
(@PATH,6,9508.228,-7352.014,14.33403,0,0,0,100,0),
(@PATH,7,9505.697,-7394.406,14.32095,0,0,0,100,0),
(@PATH,8,9535.751,-7396.176,16.8303,0,0,0,100,0),
(@PATH,9,9564.451,-7396.184,16.84703,0,0,0,100,0),
(@PATH,10,9563.777,-7415.961,19.47212,0,0,0,100,0),
(@PATH,11,9559.149,-7418.953,19.47643,0,0,0,100,0),
(@PATH,12,9563.34,-7432.895,15.4851,0,0,0,100,0),
(@PATH,13,9564.645,-7464.229,15.51088,0,0,0,100,0),
(@PATH,14,9588.409,-7464.643,13.52051,0,0,0,100,0),
(@PATH,15,9603.896,-7430.126,13.30448,0,0,0,100,0),
(@PATH,16,9595.137,-7387.862,13.52731,0,0,0,100,0),
(@PATH,17,9572.599,-7384.971,14.39343,0,0,0,100,0),
(@PATH,18,9573.106,-7369.531,14.40827,0,0,0,100,0);

SET @GUID := 72707; -- need 62;
SET @NPC_WILDSPAWN_SATYR = 11451;
SET @NPC_WILDSPAWN_ROGUE := 11452;
SET @NPC_WILDSPAWN_BETRAYER := 11454;
SET @NPC_WILDSPAWN_FELSWORN := 11455;
SET @NPC_WILDSPAWN_SHADOWSTALKER := 11456;
SET @NPC_WILDSPAWN_HELLCALLER := 11457;
SET @NPC_WARPWOOD_TREANT = 11462;
SET @NPC_WARPWOOD_CRUSHER := 13021;
SET @NPC_WHIP_LASHER := 13022;
SET @NPC_PHASE_LASHER := 13196;
SET @NPC_FEL_LASH := 13197;

-- add movement
SET @ENTRY  := 56992; -- single Wildspawn Felsworn instance
UPDATE creature SET `MovementType`=2 WHERE `guid`=@ENTRY;
DELETE FROM `creature_addon` WHERE `guid`=@ENTRY;
INSERT INTO `creature_addon`(`guid`,`path_id`) VALUES
(@ENTRY,@ENTRY*10);

-- Add waypoints to Wildspawn Felsworn instance
DELETE FROM `waypoint_data` WHERE `id`=@ENTRY*10;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@ENTRY*10,1,57.4000,-737.329,-25.1524,0,0,0,100,0),
(@ENTRY*10,2,26.45,-682.69,-24.98,0,0,0,100,0);

-- Smart AI for Wildspawn Shadowstalker
SET @ENTRY := @NPC_WILDSPAWN_SHADOWSTALKER;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
UPDATE creature SET `MovementType`=1,`spawndist`=3 WHERE `id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,0,0,0,0,0,11,22766,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wildspawn Shadowstalker - On Spawn - cast Sneak on self'),
(@ENTRY,0,1,0,0,0,100,0,4000,8000,5000,8000,11,22416,0,0,0,0,0,2,0,0,0,0,0,0,0,'Wildspawn Shadowstalker - In Combat - Cast Backstab'),
(@ENTRY,0,2,0,0,0,100,0,6000,7000,8000,9000,11,7992,0,0,0,0,0,2,0,0,0,0,0,0,0,'Wildspawn Shadowstalker - In Combat - Cast Slowing Posion');

-- add movement
SET @ENTRY  := 56967; -- single Wildspawn Shadowstalker instance
UPDATE creature SET `MovementType`=2 WHERE `guid`=@ENTRY;
DELETE FROM `creature_addon` WHERE `guid`=@ENTRY;
INSERT INTO `creature_addon`(`guid`,`path_id`) VALUES
(@ENTRY,@ENTRY*10);

-- Add waypoints to Wildspawn Shadowstalker instance
DELETE FROM `waypoint_data` WHERE `id`=@ENTRY*10;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@ENTRY*10,1,45.4305,-675.9378,-25.1612,0,0,0,100,0),
(@ENTRY*10,2,36.5939,-646.3212,-25.1506,0,0,0,100,0),
(@ENTRY*10,3,58.3292,-605.7308,-25.0700,0,0,0,100,0),
(@ENTRY*10,4,52.3244,-584.9519,-23.3673,0,0,0,100,0),
(@ENTRY*10,5,52.1407,-565.7738,-19.4151,0,0,0,100,0),
(@ENTRY*10,6,56.5794,-558.3062,-19.2307,0,0,0,100,0),
(@ENTRY*10,7,76.8705,-545.9866,-15.2457,0,0,0,100,0),
(@ENTRY*10,8,97.9787,-544.0214,-11.0777,0,0,0,100,0),
(@ENTRY*10,9,76.8705,-545.9866,-15.2457,0,0,0,100,0),
(@ENTRY*10,10,56.5794,-558.3062,-19.2307,0,0,0,100,0),
(@ENTRY*10,11,52.1407,-565.7738,-19.4151,0,0,0,100,0),
(@ENTRY*10,12,52.3244,-584.9519,-23.3673,0,0,0,100,0),
(@ENTRY*10,13,58.3292,-605.7308,-25.0700,0,0,0,100,0),
(@ENTRY*10,14,36.5939,-646.3212,-25.1506,0,0,0,100,0),
(@ENTRY*10,15,45.4305,-675.9378,-25.1612,0,0,0,100,0),
(@ENTRY*10,16,62.53,-681.04,-24.98,0,0,0,100,0);

-- Spawn the mobs
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+62;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
(@GUID+1,@NPC_WARPWOOD_TREANT,429,1,1,0,0,72.5524,-197.561,-4.14211,3.13356,7200,0,0,7842,0,2),
(@GUID+2,@NPC_WARPWOOD_TREANT,429,1,1,0,0,20.3687,-203.068,-4.0968,3.10349,7200,0,0,7842,0,2),
(@GUID+3,@NPC_WARPWOOD_TREANT,429,1,1,0,0,30.1582,-195.841,-4.12466,3.01317,7200,0,0,7599,0,2),
(@GUID+4,@NPC_WARPWOOD_TREANT,429,1,1,0,0,25.8537,-206.521,-4.06996,3.01317,7200,0,0,7599,0,2),
(@GUID+5,@NPC_WARPWOOD_TREANT,429,1,1,0,0,-107.769,-200.032,-4.10429,0.153016,7200,0,0,7842,0,2),
(@GUID+6,@NPC_WARPWOOD_TREANT,429,1,1,0,0,-113.89,-195.466,-4.14424,0.0626954,7200,0,0,7842,0,2),
(@GUID+7,@NPC_WARPWOOD_TREANT,429,1,1,0,0,-117.388,-207.58,-4.06716,0.0476419,7200,0,0,7842,0,2),
(@GUID+8,@NPC_WARPWOOD_TREANT,429,1,1,0,0,-142.675,-350.105,-4.11237,1.70352,7200,0,0,7599,0,2),
(@GUID+9,@NPC_WARPWOOD_TREANT,429,1,1,0,0,-145.689,-356.994,-4.13712,1.66338,7200,0,0,7599,0,2),
(@GUID+10,@NPC_WARPWOOD_TREANT,429,1,1,0,0,-138.62,-360.106,-4.13313,1.66338,7200,0,0,7599,0,2),
(@GUID+11,@NPC_WARPWOOD_TREANT,429,1,1,0,0,-115.225,-347.295,-4.05097,6.26559,7200,0,0,7599,0,2),
(@GUID+12,@NPC_WARPWOOD_TREANT,429,1,1,0,0,-109.451,-350.449,-4.07628,6.28064,7200,0,0,7599,0,2),
(@GUID+13,@NPC_WARPWOOD_TREANT,429,1,1,0,0,-120.637,-353.502,-4.10136,6.26747,7200,0,0,7842,0,2),
(@GUID+14,@NPC_WARPWOOD_TREANT,429,1,1,0,0,-46.8699,-355.781,-4.11898,0.109725,7200,0,0,7599,0,2),
(@GUID+15,@NPC_WARPWOOD_TREANT,429,1,1,0,0,-57.5391,-352.691,-4.09353,0.121943,7200,0,0,7842,0,2),
(@GUID+16,@NPC_WARPWOOD_TREANT,429,1,1,0,0,-60.9243,-359.466,-4.14508,0.0617289,7200,0,0,7842,0,2),
(@GUID+17,@NPC_WARPWOOD_TREANT,429,1,1,0,0,54.2367,-348.114,-4.05781,6.25459,7200,0,0,7599,0,2),
(@GUID+18,@NPC_WARPWOOD_TREANT,429,1,1,0,0,43.279,-352.861,-4.0973,0.0633858,7200,0,0,7842,0,2),
(@GUID+19,@NPC_WARPWOOD_TREANT,429,1,1,0,0,39.8267,-343.521,-4.02135,6.18098,7200,0,0,7842,0,2),
(@GUID+20,@NPC_WARPWOOD_TREANT,429,1,1,0,0,111.859,-366.456,-4.14992,1.56459,7200,0,0,7842,0,2),
(@GUID+21,@NPC_WARPWOOD_TREANT,429,1,1,0,0,116.012,-372.374,-4.09262,1.52947,7200,0,0,7842,0,2),
(@GUID+22,@NPC_WARPWOOD_TREANT,429,1,1,0,0,107.625,-377.033,-4.07882,1.53449,7200,0,0,7842,0,2),
(@GUID+23,@NPC_WARPWOOD_CRUSHER,429,1,1,0,0,141.391,-355.109,-4.15258,3.22692,7200,0,0,16194,0,0),
(@GUID+24,@NPC_PHASE_LASHER,429,1,1,0,0,81.2447,-361.592,-4.14699,1.54781,7200,0,0,15684,0,0),
(@GUID+25,@NPC_WHIP_LASHER,429,1,1,0,0,34.9898,-347.58,-4.05484,0.017372,7200,0,0,1900,0,0),
(@GUID+26,@NPC_WHIP_LASHER,429,1,1,0,0,36.7793,-352.448,-4.09411,0.00231851,7200,0,0,1900,0,0),
(@GUID+27,@NPC_WHIP_LASHER,429,1,1,0,0,41.2793,-352.437,-4.09411,0.00231851,7200,0,0,1900,0,0),
(@GUID+28,@NPC_WHIP_LASHER,429,1,1,0,0,44.3212,-352.43,-4.09411,0.00231851,7200,0,0,1900,0,0),
(@GUID+29,@NPC_WHIP_LASHER,429,1,1,0,0,44.315,-349.742,-4.07234,0.0588672,7200,0,0,1900,0,0),
(@GUID+30,@NPC_WHIP_LASHER,429,1,1,0,0,39.4515,-350.029,-4.0749,0.063885,7200,0,0,1900,0,0),
(@GUID+31,@NPC_WHIP_LASHER,429,1,1,0,0,39.2745,-347.262,-4.05348,0.063885,7200,0,0,1900,0,0),
(@GUID+32,@NPC_WARPWOOD_CRUSHER,429,1,1,0,0,-20.953,-371.52,-4.05577,1.58638,7200,0,0,16194,0,0),
(@GUID+33,@NPC_PHASE_LASHER,429,1,1,0,0,-52.0524,-361.703,-4.14598,1.7679,7200,0,0,15684,0,0),
(@GUID+34,@NPC_WHIP_LASHER,429,1,1,0,0,-62.1186,-349.8,-4.07015,6.09414,7200,0,0,1900,0,0),
(@GUID+35,@NPC_WHIP_LASHER,429,1,1,0,0,-69.5873,-354.282,-4.1069,6.17944,7200,0,0,1900,0,0),
(@GUID+36,@NPC_WHIP_LASHER,429,1,1,0,0,-66.7331,-351.805,-4.08577,6.18948,7200,0,0,1900,0,0),
(@GUID+37,@NPC_WHIP_LASHER,429,1,1,0,0,-73.9811,-351.124,-4.08116,6.18948,7200,0,0,1900,0,0),
(@GUID+38,@NPC_WHIP_LASHER,429,1,1,0,0,-69.8854,-349.117,-4.06468,6.2798,7200,0,0,1900,0,0),
(@GUID+39,@NPC_WHIP_LASHER,429,1,1,0,0,-65.6902,-346.108,-4.0402,6.2798,7200,0,0,1900,0,0),
(@GUID+40,@NPC_WARPWOOD_CRUSHER,429,1,1,0,0,-73.7821,-346.08,-4.0402,6.2798,7200,0,0,1900,0,0),
(@GUID+41,@NPC_WARPWOOD_TREANT,429,1,1,0,0,-93.8011,-363.618,-4.14738,1.65316,7200,0,0,16194,0,0),
(@GUID+42,@NPC_PHASE_LASHER,429,1,1,0,0,-131.311,-365.627,-4.15058,1.51265,7200,0,0,15198,0,0),
(@GUID+43,@NPC_WHIP_LASHER,429,1,1,0,0,-143.839,-340.391,-4.12014,1.83881,7200,0,0,1900,0,0),
(@GUID+44,@NPC_WHIP_LASHER,429,1,1,0,0,-142.296,-336.529,-4.10736,1.85386,7200,0,0,1900,0,0),
(@GUID+45,@NPC_WHIP_LASHER,429,1,1,0,0,-138.49,-341.197,-4.07808,1.73845,7200,0,0,1900,0,0),
(@GUID+46,@NPC_WHIP_LASHER,429,1,1,0,0,-134.462,-337.194,-4.04726,1.70944,7200,0,0,1900,0,0),
(@GUID+47,@NPC_WHIP_LASHER,429,1,1,0,0,-135.424,-330.303,-4.0528,1.70944,7200,0,0,1900,0,0),
(@GUID+48,@NPC_WHIP_LASHER,429,1,1,0,0,-142.163,-331.244,-4.1045,1.71445,7200,0,0,1900,0,0),
(@GUID+49,@NPC_WHIP_LASHER,429,1,1,0,0,-138.62,-333.245,-4.07944,1.71947,7200,0,0,1900,0,0),
(@GUID+50,@NPC_WARPWOOD_CRUSHER,429,1,1,0,0,-138.38,-275.724,-4.07674,3.17049,7200,0,0,16194,0,0),
(@GUID+51,@NPC_PHASE_LASHER,429,1,1,0,0,-162.835,-275.863,-4.14791,6.27238,7200,0,0,15684,0,0),
(@GUID+52,@NPC_WHIP_LASHER,429,1,1,0,0,-158.318,-204.325,-4.15232,0.0694766,7200,0,0,1900,0,0),
(@GUID+53,@NPC_WHIP_LASHER,429,1,1,0,0,-154.646,-204.07,-4.15232,0.0694766,7200,0,0,1900,0,0),
(@GUID+54,@NPC_WHIP_LASHER,429,1,1,0,0,-153.089,-196.695,-4.15243,0.0343519,7200,0,0,1900,0,0),
(@GUID+55,@NPC_WHIP_LASHER,429,1,1,0,0,-160.393,-196.946,-4.15243,0.0343519,7200,0,0,1900,0,0),
(@GUID+56,@NPC_WHIP_LASHER,429,1,1,0,0,-162.052,-201.486,-4.15243,0.0393697,7200,0,0,1900,0,0),
(@GUID+57,@NPC_WHIP_LASHER,429,1,1,0,0,-152.686,-201.117,-4.15243,0.0393697,7200,0,0,1900,0,0),
(@GUID+58,@NPC_WHIP_LASHER,429,1,1,0,0,-156.996,-199.83,-4.15243,0.059441,7200,0,0,1900,0,0),
(@GUID+59,@NPC_PHASE_LASHER,429,1,1,0,0,-86.8965,-210.681,-4.03141,1.56479,7200,0,0,15198,0,0),
(@GUID+60,@NPC_WARPWOOD_CRUSHER,429,1,1,0,0,-87.0174,-180.571,-2.71439,4.76202,7200,0,0,16194,0,0),
(@GUID+61,@NPC_PHASE_LASHER,429,1,1,0,0,-27.3846,-207.58,-4.06107,0.888256,7200,0,0,15684,0,0),
(@GUID+62,@NPC_WARPWOOD_CRUSHER,429,1,1,0,0,-15.3937,-177.684,-2.71439,4.81219,7200,0,0,16194,0,0);

-- Add movement to some mobs
DELETE FROM `creature_addon` WHERE `guid` BETWEEN @GUID+1 AND @GUID+22;
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES
(@GUID+1,(@GUID+1)*10),
(@GUID+2,(@GUID+2)*10),
(@GUID+3,(@GUID+2)*10),
(@GUID+4,(@GUID+2)*10),
(@GUID+5,(@GUID+6)*10),
(@GUID+6,(@GUID+6)*10),
(@GUID+7,(@GUID+6)*10),
(@GUID+8,(@GUID+8)*10),
(@GUID+9,(@GUID+8)*10),
(@GUID+10,(@GUID+8)*10),
(@GUID+11,(@GUID+11)*10),
(@GUID+12,(@GUID+11)*10),
(@GUID+13,(@GUID+11)*10),
(@GUID+14,(@GUID+14)*10),
(@GUID+15,(@GUID+14)*10),
(@GUID+16,(@GUID+14)*10),
(@GUID+17,(@GUID+17)*10),
(@GUID+18,(@GUID+17)*10),
(@GUID+19,(@GUID+17)*10),
(@GUID+20,(@GUID+20)*10),
(@GUID+21,(@GUID+20)*10),
(@GUID+22,(@GUID+20)*10);

-- Add waypoints to mobs
DELETE FROM `waypoint_data` WHERE `id` = (@GUID+1)*10;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
((@GUID+1)*10,1,70.6901,-197.173,-4.14434,0,1,0,100,0),
((@GUID+1)*10,2,-104.169,-199.817,-4.12389,0,1,0,100,0),
((@GUID+2)*10,1,-73.5443,-202.239,-4.10251,0,1,0,100,0),
((@GUID+2)*10,2,35.4205,-201.467,-4.11061,0,1,0,100,0),
((@GUID+6)*10,1,-20.2122,-201.982,-4.11082,0,1,0,100,0),
((@GUID+6)*10,2,-130.665,-201.733,-4.10813,0,1,0,100,0),
((@GUID+8)*10,1,-166.248,-199.501,-4.15228,0,1,0,100,0),
((@GUID+8)*10,2,-131.595,-354.127,-4.10839,0,1,0,100,0),
((@GUID+11)*10,1,-35.5988,-348.525,-4.06037,0,1,0,100,0),
((@GUID+11)*10,2,-21.0353,-356.517,-4.12553,0,1,0,100,0),
((@GUID+11)*10,3,4.10672,-354.436,-4.11233,0,1,0,100,0),
((@GUID+11)*10,4,-62.8668,-351.204,-4.083,0,1,0,100,0),
((@GUID+11)*10,5,-113.908,-346.958,-4.04887,0,1,0,100,0),
((@GUID+14)*10,1,49.0152,-351.975,-4.09131,0,1,0,100,0),
((@GUID+14)*10,2,-68.801,-355.361,-4.11568,0,1,0,100,0),
((@GUID+17)*10,1,140.938,-354.573,-4.15133,0,1,0,100,0),
((@GUID+17)*10,2, -17.9066,-352.038,-4.09042,0,1,0,100,0),
((@GUID+20)*10,1,134.04,-337.362,-4.14977,0,1,0,100,0),
((@GUID+20)*10,2,117.337,-367.835,-4.15199,0,1,0,100,0),
((@GUID+20)*10,3,68.2814,-346.911,-4.04935,0,1,0,100,0),
((@GUID+20)*10,4,111.089,-364.118,-4.14948,0,1,0,100,0);

-- Spawn & Pathing for Horace Alder Entry: 27704 "Not Spawned"
SET @NPC := 1846;
DELETE FROM `creature` WHERE `guid` IN (@NPC);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
(@NPC,27704,1,1,1,0,0,-3738.565,-4442.265,56.23981,0.41887,300,0,0,1,0,2);
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3740.015,-4437.762,56.23981,0,0,0,0,100,0),
(@PATH,2,-3742.823,-4433.892,56.23981,0,0,0,0,100,0),
(@PATH,3,-3746.757,-4431.049,56.23981,0,0,0,0,100,0),
(@PATH,4,-3751.263,-4429.58,56.23981,0,0,0,0,100,0),
(@PATH,5,-3756.035,-4429.627,56.23981,0,0,0,0,100,0),
(@PATH,6,-3760.625,-4431.113,56.23981,0,0,0,0,100,0),
(@PATH,7,-3764.42,-4433.888,56.22611,0,0,0,0,100,0),
(@PATH,8,-3767.252,-4437.716,56.23981,0,0,0,0,100,0),
(@PATH,9,-3768.719,-4442.307,56.23982,0,0,0,0,100,0),
(@PATH,10,-3768.664,-4447.081,56.22474,0,0,0,0,100,0),
(@PATH,11,-3767.221,-4451.627,56.23982,0,0,0,0,100,0),
(@PATH,12,-3764.422,-4455.48,56.23981,0,0,0,0,100,0),
(@PATH,13,-3767.221,-4451.627,56.23982,0,0,0,0,100,0),
(@PATH,14,-3768.664,-4447.081,56.22474,0,0,0,0,100,0),
(@PATH,15,-3768.719,-4442.307,56.23982,0,0,0,0,100,0),
(@PATH,16,-3767.255,-4437.724,56.20177,0,0,0,0,100,0),
(@PATH,17,-3764.42,-4433.888,56.22611,0,0,0,0,100,0),
(@PATH,18,-3760.625,-4431.113,56.23981,0,0,0,0,100,0),
(@PATH,19,-3756.035,-4429.627,56.23981,0,0,0,0,100,0),
(@PATH,20,-3751.263,-4429.58,56.23981,0,0,0,0,100,0),
(@PATH,21,-3746.757,-4431.049,56.23981,0,0,0,0,100,0),
(@PATH,22,-3742.823,-4433.892,56.23981,0,0,0,0,100,0),
(@PATH,23,-3740.015,-4437.762,56.23981,0,0,0,0,100,0),
(@PATH,24,-3738.565,-4442.265,56.23981,0,0,0,0,100,0),
(@PATH,25,-3738.577,-4447.063,56.23981,0,0,0,0,100,0),
(@PATH,26,-3740.03,-4451.584,56.23981,0,0,0,0,100,0),
(@PATH,27,-3742.872,-4455.448,56.23981,0,0,0,0,100,0),
(@PATH,28,-3746.699,-4458.252,56.23982,0,0,0,0,100,0),
(@PATH,29,-3751.217,-4459.749,56.26265,0,0,0,0,100,0),
(@PATH,30,-3756.021,-4459.732,56.23981,0,0,0,0,100,0),
(@PATH,31,-3751.217,-4459.749,56.26265,0,0,0,0,100,0),
(@PATH,32,-3746.699,-4458.252,56.23982,0,0,0,0,100,0),
(@PATH,33,-3742.872,-4455.448,56.23981,0,0,0,0,100,0),
(@PATH,34,-3740.03,-4451.584,56.23981,0,0,0,0,100,0),
(@PATH,35,-3738.577,-4447.063,56.23981,0,0,0,0,100,0),
(@PATH,36,-3738.565,-4442.265,56.23981,0,0,0,0,100,0);

-- Some Hinterlands fixups.

-- Waypoint Script guids
SET @SCRIPTGUID := 55; -- 12 required

-- Fixup Revantusk Watcher add Invisibility and Stealth Detection aura
UPDATE creature SET `modelid`=0,`curhealth`=1 WHERE id=14730;
UPDATE `creature_addon` SET `bytes2`=257,`auras`=18950 WHERE guid IN (SELECT guid FROM creature WHERE id=14730);

-- Revantusk Drummer add emote
DELETE FROM `creature_addon` WHERE `guid` IN (92886,92887,92888);
DELETE FROM `creature_template_addon` WHERE `entry`=14734;
INSERT INTO `creature_template_addon` (`entry`,`bytes2`,`emote`) VALUES (14734,1,36);

-- Pathing for Smith Slagtree Entry: 14737
SET @NPC := 92909;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-589.9536,`position_y`=-4548.458,`position_z`=9.161489 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-591.6767,-4554.789,9.161489,0,0,0,0,100,0),
(@PATH,2,-595.7503,-4559.671,9.161489,0,6000,0,929090,100,0),
(@PATH,3,-589.9536,-4548.458,9.161489,0,29000,0,929091,100,0);
DELETE FROM `waypoint_scripts` WHERE `id` IN (929090,929091);
INSERT INTO `waypoint_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`o`,`guid`) VALUES
(929090,1,30,0,0,3.228859,@SCRIPTGUID),
(929090,2,2,74,8,0,@SCRIPTGUID+1),
(929090,5,2,74,0,0,@SCRIPTGUID+2),
(929091,1,30,0,0,0.6108652,@SCRIPTGUID+3),
(929091,2,15,23488,1,0,@SCRIPTGUID+4),
(929091,5,2,83,233,0,@SCRIPTGUID+5),
(929091,24,2,83,69,0,@SCRIPTGUID+6);

-- Pathing for Mystic Yayo'jin Entry: 14739
SET @NPC := 92911;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-541.7078,`position_y`=-4608.892,`position_z`=13.12271 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-538.0938,-4609.549,13.11275,0,500,0,0,100,0),
(@PATH,2,-538.0938,-4609.549,13.11275,5.986479,8000,0,0,100,0),
(@PATH,3,-539.3364,-4606.846,13.11516,0,500,0,0,100,0),
(@PATH,4,-539.3364,-4606.846,13.11516,0.9773844,10000,0,0,100,0),
(@PATH,5,-542.105,-4606.523,13.12286,0,500,0,0,100,0),
(@PATH,6,-542.105,-4606.523,13.12286,1.815142,9000,0,0,100,0),
(@PATH,7,-543.7079,-4611.147,13.15176,0,0,0,0,100,0),
(@PATH,8,-540.0343,-4611.84,13.11918,0,0,0,0,100,0),
(@PATH,9,-539.916,-4609.014,13.11769,0,0,0,0,100,0),
(@PATH,10,-541.7078,-4608.892,13.12271,0,500,0,0,100,0),
(@PATH,11,-541.7078,-4608.892,13.12271,2.86234,48000,0,929110,100,0);
DELETE FROM `waypoint_scripts` WHERE `id`=929110;
INSERT INTO `waypoint_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`guid`) VALUES
(929110,2,2,74,1,@SCRIPTGUID+7),
(929110,39,2,74,0,@SCRIPTGUID+8),
(929110,41,2,83,133,@SCRIPTGUID+9);

-- Pathing for Revantusk Watcher Entry: 14730
SET @NPC := 92898;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-621.9691,`position_y`=-4670.079,`position_z`=5.061154 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '18950');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-614.1932,-4653.834,5.040805,0,0,0,0,100,0),
(@PATH,2,-620.4515,-4667.109,5.066647,0,0,0,0,100,0),
(@PATH,3,-630.2896,-4686.361,5.086016,0,0,0,0,100,0),
(@PATH,4,-644.1071,-4714.346,5.219747,0,9000,0,928980,100,0);
DELETE FROM `waypoint_scripts` WHERE `id` IN (928980);
INSERT INTO `waypoint_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`x`,`y`,`z`,`o`,`guid`) VALUES
(928980,8,6,0,1,-621.9691,-4670.079,5.061154,1.098353,@SCRIPTGUID+10);

-- Pathing for Revantusk Watcher Entry: 14730
SET @NPC := 92899;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-619.3934,`position_y`=-4664.687,`position_z`=5.057855 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '18950');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-615.9739,-4657.611,5.048162,0,0,0,0,100,0),
(@PATH,2,-617.2744,-4660.37,5.053535,0,0,0,0,100,0),
(@PATH,3,-618.5742,-4663.127,5.058907,0,0,0,0,100,0),
(@PATH,4,-619.8167,-4665.867,5.066616,0,0,0,0,100,0),
(@PATH,5,-621.2051,-4668.584,5.066684,0,0,0,0,100,0),
(@PATH,6,-622.5936,-4671.301,5.066746,0,0,0,0,100,0),
(@PATH,7,-623.9827,-4674.019,5.066799,0,0,0,0,100,0),
(@PATH,8,-625.2844,-4676.566,5.066853,0,0,0,0,100,0),
(@PATH,9,-626.7726,-4679.479,5.060135,0,0,0,0,100,0),
(@PATH,10,-628.1486,-4682.171,5.07026,0,0,0,0,100,0),
(@PATH,11,-629.5447,-4684.852,5.078729,0,0,0,0,100,0),
(@PATH,12,-630.8968,-4687.591,5.091967,0,0,0,0,100,0),
(@PATH,13,-632.2471,-4690.326,5.105191,0,10000,0,928990,100,0);
DELETE FROM `waypoint_scripts` WHERE `id` IN (928990);
INSERT INTO `waypoint_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`x`,`y`,`z`,`o`,`guid`) VALUES
(928990,9,6,0,1,-619.3934,-4664.687,5.057855,1.120319,@SCRIPTGUID+11);

-- Pathing for Revantusk Watcher Entry: 14730
SET @NPC := 92946;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-583.7281,`position_y`=-4567.89,`position_z`=9.120717 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '18950');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-576.5599,-4568.717,9.161489,0,0,0,0,100,0),
(@PATH,2,-570.6282,-4570.051,9.286489,0,0,0,0,100,0),
(@PATH,3,-564.2906,-4571.396,9.480314,0,0,0,0,100,0),
(@PATH,4,-559.9419,-4573.958,9.605314,0,0,0,0,100,0),
(@PATH,5,-554.7994,-4581.686,9.740568,0,0,0,0,100,0),
(@PATH,6,-552.841,-4589.281,9.605314,0,0,0,0,100,0),
(@PATH,7,-555.0905,-4596.873,9.605314,0,0,0,0,100,0),
(@PATH,8,-555.7503,-4601.974,9.614173,0,0,0,0,100,0),
(@PATH,9,-559.4357,-4608.517,9.739173,0,0,0,0,100,0),
(@PATH,10,-563.2764,-4613.221,9.739173,0,0,0,0,100,0),
(@PATH,11,-566.1555,-4615.88,9.739173,0,0,0,0,100,0),
(@PATH,12,-566.157,-4619.973,9.739173,0,0,0,0,100,0),
(@PATH,13,-565.7682,-4621.338,10.5361,0,0,0,0,100,0),
(@PATH,14,-564.9091,-4624.298,12.33652,0,0,0,0,100,0),
(@PATH,15,-564.4247,-4626.619,13.21042,0,0,0,0,100,0),
(@PATH,16,-565.8718,-4628.861,13.21023,0,0,0,0,100,0),
(@PATH,17,-568.9028,-4629.674,13.21105,0,0,0,0,100,0),
(@PATH,18,-571.7204,-4630.63,14.69388,0,0,0,0,100,0),
(@PATH,19,-576.4782,-4631.931,17.15172,0,0,0,0,100,0),
(@PATH,20,-581.1254,-4634.227,19.03236,0,0,0,0,100,0),
(@PATH,21,-585.7308,-4639.775,21.21893,0,0,0,0,100,0),
(@PATH,22,-585.2182,-4645.189,22.94262,0,0,0,0,100,0),
(@PATH,23,-582.2473,-4647.843,24.75424,0,0,0,0,100,0),
(@PATH,24,-576.8602,-4648.417,26.25482,0,0,0,0,100,0),
(@PATH,25,-572.6866,-4646.474,28.46729,0,0,0,0,100,0),
(@PATH,26,-569.6187,-4644.834,30.25781,0,0,0,0,100,0),
(@PATH,27,-565.1738,-4641.978,30.34623,0,0,0,0,100,0),
(@PATH,28,-561.8621,-4639.479,30.34518,0,0,0,0,100,0),
(@PATH,29,-559.1216,-4640.588,30.34381,0,0,0,0,100,0),
(@PATH,30,-561.8621,-4639.479,30.34518,0,0,0,0,100,0),
(@PATH,31,-568.164,-4644.291,30.34578,0,0,0,0,100,0),
(@PATH,32,-572.6866,-4646.474,28.46729,0,0,0,0,100,0),
(@PATH,33,-576.8602,-4648.417,26.25482,0,0,0,0,100,0),
(@PATH,34,-582.2473,-4647.843,24.75424,0,0,0,0,100,0),
(@PATH,35,-585.2182,-4645.189,22.94262,0,0,0,0,100,0),
(@PATH,36,-585.7538,-4639.803,21.22803,0,0,0,0,100,0),
(@PATH,37,-581.134,-4634.237,19.03649,0,0,0,0,100,0),
(@PATH,38,-576.6482,-4631.978,17.23644,0,0,0,0,100,0),
(@PATH,39,-572.6212,-4631.001,15.44738,0,0,0,0,100,0),
(@PATH,40,-568.9028,-4629.674,13.21105,0,0,0,0,100,0),
(@PATH,41,-565.8718,-4628.861,13.21023,0,0,0,0,100,0),
(@PATH,42,-564.4247,-4626.619,13.21042,0,0,0,0,100,0),
(@PATH,43,-564.7512,-4625.108,12.77208,0,0,0,0,100,0),
(@PATH,44,-565.6238,-4622.17,11.06051,0,0,0,0,100,0),
(@PATH,45,-566.157,-4619.973,9.739173,0,0,0,0,100,0),
(@PATH,46,-566.1555,-4615.88,9.739173,0,0,0,0,100,0),
(@PATH,47,-563.2764,-4613.221,9.739173,0,0,0,0,100,0),
(@PATH,48,-559.4357,-4608.517,9.739173,0,0,0,0,100,0),
(@PATH,49,-555.7503,-4601.974,9.614173,0,0,0,0,100,0),
(@PATH,50,-555.0905,-4596.873,9.605314,0,0,0,0,100,0),
(@PATH,51,-552.841,-4589.281,9.605314,0,0,0,0,100,0),
(@PATH,52,-554.7994,-4581.686,9.740568,0,0,0,0,100,0),
(@PATH,53,-559.9419,-4573.958,9.605314,0,0,0,0,100,0),
(@PATH,54,-564.2906,-4571.396,9.480314,0,0,0,0,100,0),
(@PATH,55,-570.6282,-4570.051,9.286489,0,0,0,0,100,0),
(@PATH,56,-576.5599,-4568.717,9.161489,0,0,0,0,100,0),
(@PATH,57,-583.7281,-4567.89,9.120717,0,0,0,0,100,0),
(@PATH,58,-589.5422,-4571.942,9.482045,0,0,0,0,100,0),
(@PATH,59,-595.0231,-4573.951,9.786489,0,0,0,0,100,0),
(@PATH,60,-589.5422,-4571.942,9.482045,0,0,0,0,100,0),
(@PATH,61,-583.7281,-4567.89,9.120717,0,0,0,0,100,0);

-- Pathing for Revantusk Watcher Entry: 14730
SET @NPC := 92903;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-587.9592,`position_y`=-4565.161,`position_z`=9.161489 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '18950');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-589.1211,-4560.011,9.161489,0,0,0,0,100,0),
(@PATH,2,-586.8055,-4558.024,9.161489,0,0,0,0,100,0),
(@PATH,3,-582.1091,-4557.421,9.418232,0,0,0,0,100,0),
(@PATH,4,-563.0848,-4567.083,9.617765,0,0,0,0,100,0),
(@PATH,5,-564.0873,-4565.243,9.636915,0,0,0,0,100,0),
(@PATH,6,-554.4955,-4549.669,10.38081,0,0,0,0,100,0),
(@PATH,7,-551.9146,-4546.659,10.20161,0,0,0,0,100,0),
(@PATH,8,-530.5864,-4534.892,10.88507,0,0,0,0,100,0),
(@PATH,9,-528.0935,-4540.74,10.68414,0,0,0,0,100,0),
(@PATH,10,-548.4247,-4552.033,10.33687,0,0,0,0,100,0),
(@PATH,11,-559.3554,-4571.553,9.605396,0,0,0,0,100,0),
(@PATH,12,-558.353,-4572.357,9.734953,0,0,0,0,100,0),
(@PATH,13,-552.0048,-4585.105,9.830168,0,0,0,0,100,0),
(@PATH,14,-551.9355,-4589.406,9.685699,0,0,0,0,100,0),
(@PATH,15,-559.1077,-4612.717,9.864173,0,0,0,0,100,0),
(@PATH,16,-563.384,-4614.937,9.739216,0,0,0,0,100,0),
(@PATH,17,-587.5415,-4618.487,9.456761,0,0,0,0,100,0),
(@PATH,18,-596.1833,-4629.224,9.796849,0,0,0,0,100,0),
(@PATH,19,-601.0118,-4628.754,9.411202,0,0,0,0,100,0),
(@PATH,20,-592.4224,-4616.147,9.359911,0,0,0,0,100,0),
(@PATH,21,-588.6967,-4613.219,9.55808,0,0,0,0,100,0),
(@PATH,22,-567.4048,-4614.91,9.729955,0,0,0,0,100,0),
(@PATH,23,-566.9582,-4615.76,9.628169,0,0,0,0,100,0),
(@PATH,24,-557.4971,-4586.748,9.730397,0,0,0,0,100,0),
(@PATH,25,-565.1426,-4573.827,9.526945,0,0,0,0,100,0),
(@PATH,26,-587.9592,-4565.161,9.161489,0,0,0,0,100,0);

-- Pathing for Revantusk Watcher Entry: 14730
SET @NPC := 92904;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-563.7853,`position_y`=-4572.203,`position_z`=9.480314 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,257,0, '18950');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-589.0695,-4562.6,9.161489,0,0,0,0,100,0),
(@PATH,2,-584.3304,-4558.535,9.161489,0,0,0,0,100,0),
(@PATH,3,-563.9773,-4568.874,9.527922,0,0,0,0,100,0),
(@PATH,4,-551.5903,-4548.764,10.15376,0,0,0,0,100,0),
(@PATH,5,-529.4497,-4536.548,11.02155,0,0,0,0,100,0),
(@PATH,6,-549.9079,-4550.587,9.985304,0,0,0,0,100,0),
(@PATH,7,-561.3011,-4570.924,9.605314,0,0,0,0,100,0),
(@PATH,8,-553.2903,-4587.01,9.647795,0,0,0,0,100,0),
(@PATH,9,-561.1612,-4612.59,9.864173,0,0,0,0,100,0),
(@PATH,10,-588.2601,-4616.572,9.456761,0,0,0,0,100,0),
(@PATH,11,-599.4961,-4630.079,9.579808,0,0,0,0,100,0),
(@PATH,12,-589.3387,-4615.174,9.456761,0,0,0,0,100,0),
(@PATH,13,-565.2857,-4617.084,9.739173,0,0,0,0,100,0),
(@PATH,14,-555.2867,-4586.42,9.730314,0,0,0,0,100,0),
(@PATH,15,-563.7853,-4572.203,9.480314,0,0,0,0,100,0);

DELETE FROM `creature_formations` WHERE `leaderGUID`=92903;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`) VALUES
(92903,92903,0,0,2),
(92903,92904,2,300,2);

-- Pathing for Vilebranch Headhunter Entry: 2641
SET @NPC := 93747;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-334.7697,`position_y`=-4118.176,`position_z`=152.1513 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-333.2237,-4134.225,152.0622,0,0,0,0,100,0),
(@PATH,2,-339.8373,-4147.746,152.1256,0,0,0,0,100,0),
(@PATH,3,-346.6712,-4160.327,152.1256,0,0,0,0,100,0),
(@PATH,4,-345.9421,-4177.107,152.2871,0,0,0,0,100,0),
(@PATH,5,-346.2449,-4195.276,152.2244,0,0,0,0,100,0),
(@PATH,6,-345.7937,-4206.436,152.1899,0,0,0,0,100,0),
(@PATH,7,-341.1774,-4208.535,152.0649,0,0,0,0,100,0),
(@PATH,8,-337.7476,-4206.129,152.1899,0,1000,0,0,100,0),
(@PATH,9,-341.1774,-4208.535,152.0649,0,0,0,0,100,0),
(@PATH,10,-345.7937,-4206.436,152.1899,0,0,0,0,100,0),
(@PATH,11,-346.2449,-4195.276,152.2244,0,0,0,0,100,0),
(@PATH,12,-345.9421,-4177.107,152.2871,0,0,0,0,100,0),
(@PATH,13,-346.6712,-4160.327,152.1256,0,0,0,0,100,0),
(@PATH,14,-339.8373,-4147.746,152.1256,0,0,0,0,100,0),
(@PATH,15,-333.2237,-4134.225,152.0622,0,0,0,0,100,0),
(@PATH,16,-334.7697,-4118.176,152.1513,0,0,0,0,100,0),
(@PATH,17,-345.4443,-4114.745,151.9538,0,0,0,0,100,0),
(@PATH,18,-358.0292,-4116.998,154.2687,0,0,0,0,100,0),
(@PATH,19,-345.4443,-4114.745,151.9538,0,0,0,0,100,0),
(@PATH,20,-334.7697,-4118.176,152.1513,0,0,0,0,100,0);

-- Pathing for Vilebranch Headhunter Entry: 2641
SET @NPC := 93634;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-304.2423,`position_y`=-4087.691,`position_z`=152.2971 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-295.6881,-4087.868,152.4837,0,0,0,0,100,0),
(@PATH,2,-284.571,-4085.302,152.14,0,0,0,0,100,0),
(@PATH,3,-272.7595,-4092.214,152.5167,0,0,0,0,100,0),
(@PATH,4,-284.571,-4085.302,152.14,0,0,0,0,100,0),
(@PATH,5,-295.6881,-4087.868,152.4837,0,0,0,0,100,0),
(@PATH,6,-304.2423,-4087.691,152.2971,0,0,0,0,100,0),
(@PATH,7,-314.2382,-4088.344,152.2971,0,0,0,0,100,0),
(@PATH,8,-322.7508,-4087.331,152.5894,0,0,0,0,100,0),
(@PATH,9,-331.1907,-4082.108,152.5066,0,0,0,0,100,0),
(@PATH,10,-338.1729,-4086.666,153.3141,0,0,0,0,100,0),
(@PATH,11,-342.3202,-4093.814,152.2581,0,0,0,0,100,0),
(@PATH,12,-338.1729,-4086.666,153.3141,0,0,0,0,100,0),
(@PATH,13,-331.1907,-4082.108,152.5066,0,0,0,0,100,0),
(@PATH,14,-322.7508,-4087.331,152.5894,0,0,0,0,100,0),
(@PATH,15,-314.2382,-4088.344,152.2971,0,0,0,0,100,0),
(@PATH,16,-304.2423,-4087.691,152.2971,0,0,0,0,100,0);

-- Pathing for Vilebranch Headhunter Entry: 2641
SET @NPC := 93755;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-334.7697,`position_y`=-4118.176,`position_z`=152.1513 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-345.4443,-4114.745,151.9538,0,0,0,0,100,0),
(@PATH,2,-334.7697,-4118.176,152.1513,0,0,0,0,100,0),
(@PATH,3,-333.2237,-4134.225,152.0622,0,0,0,0,100,0),
(@PATH,4,-339.8373,-4147.746,152.1256,0,0,0,0,100,0),
(@PATH,5,-345.9421,-4177.107,152.2871,0,0,0,0,100,0),
(@PATH,6,-346.2449,-4195.276,152.2244,0,0,0,0,100,0),
(@PATH,7,-345.7937,-4206.436,152.1899,0,0,0,0,100,0),
(@PATH,8,-341.1774,-4208.535,152.0649,0,0,0,0,100,0),
(@PATH,9,-337.7476,-4206.129,152.1899,0,3000,0,0,100,0),
(@PATH,10,-341.1774,-4208.535,152.0649,0,0,0,0,100,0),
(@PATH,11,-345.7937,-4206.436,152.1899,0,0,0,0,100,0),
(@PATH,12,-346.2449,-4195.276,152.2244,0,7000,0,0,100,0),
(@PATH,13,-345.9421,-4177.107,152.2871,0,0,0,0,100,0),
(@PATH,14,-339.8373,-4147.746,152.1256,0,0,0,0,100,0),
(@PATH,15,-333.2237,-4134.225,152.0622,0,0,0,0,100,0),
(@PATH,16,-334.7697,-4118.176,152.1513,0,0,0,0,100,0);

-- Pathing for Green Sludge Entry: 2655
SET @NPC := 92995;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=367.4861,`position_y`=-3892.534,`position_z`=103.3926 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,362.0923,-3869.861,106.0149,0,0,0,0,100,0),
(@PATH,2,359.729,-3842.23,107.0658,0,0,0,0,100,0),
(@PATH,3,362.0923,-3869.861,106.0149,0,0,0,0,100,0),
(@PATH,4,367.4861,-3892.534,103.3926,0,0,0,0,100,0),
(@PATH,5,388.8041,-3900.64,99.87824,0,0,0,0,100,0),
(@PATH,6,399.8027,-3882.644,97.61748,0,0,0,0,100,0),
(@PATH,7,390.798,-3860.872,95.97817,0,0,0,0,100,0),
(@PATH,8,379.3473,-3843.385,96.72575,0,0,0,0,100,0),
(@PATH,9,389.2842,-3825.799,98.92686,0,0,0,0,100,0),
(@PATH,10,399.2549,-3789.222,102.3659,0,0,0,0,100,0),
(@PATH,11,389.2842,-3825.799,98.92686,0,0,0,0,100,0),
(@PATH,12,379.3473,-3843.385,96.72575,0,0,0,0,100,0),
(@PATH,13,390.7259,-3860.698,95.98909,0,0,0,0,100,0),
(@PATH,14,399.8027,-3882.644,97.61748,0,0,0,0,100,0),
(@PATH,15,388.8041,-3900.64,99.87824,0,0,0,0,100,0),
(@PATH,16,367.4861,-3892.534,103.3926,0,0,0,0,100,0);

-- Pathing for Jade Ooze Entry: 2656
SET @NPC := 93068;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=386.5382,`position_y`=-3767.701,`position_z`=103.1262 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,382.7473,-3754.237,102.4903,0,0,0,0,100,0),
(@PATH,2,376.4646,-3738.252,105.2092,0,0,0,0,100,0),
(@PATH,3,365.8063,-3725.304,105.9001,0,0,0,0,100,0),
(@PATH,4,348.4052,-3720.816,105.9374,0,0,0,0,100,0),
(@PATH,5,319.9912,-3724.497,106.8615,0,0,0,0,100,0),
(@PATH,6,312.3986,-3744.087,106.7072,0,0,0,0,100,0),
(@PATH,7,318.8742,-3761.253,106.802,0,0,0,0,100,0),
(@PATH,8,343.6207,-3757.014,106.9888,0,0,0,0,100,0),
(@PATH,9,318.8742,-3761.253,106.802,0,0,0,0,100,0),
(@PATH,10,312.3907,-3744.138,106.7072,0,0,0,0,100,0),
(@PATH,11,319.9912,-3724.497,106.8615,0,0,0,0,100,0), 
(@PATH,12,348.4052,-3720.816,105.9374,0,0,0,0,100,0),
(@PATH,13,365.8063,-3725.304,105.9001,0,0,0,0,100,0),
(@PATH,14,376.4646,-3738.252,105.2092,0,0,0,0,100,0),
(@PATH,15,382.7473,-3754.237,102.4903,0,0,0,0,100,0),
(@PATH,16,386.5382,-3767.701,103.1262,0,0,0,0,100,0),
(@PATH,17,398.7607,-3775.05,102.3659,0,0,0,0,100,0),
(@PATH,18,403.8524,-3788.918,102.2382,0,0,0,0,100,0),
(@PATH,19,398.7607,-3775.05,102.3659,0,0,0,0,100,0),
(@PATH,20,386.5382,-3767.701,103.1262,0,0,0,0,100,0);

-- Pathing for Green Sludge Entry: 2655
SET @NPC := 93068;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=353.2792,`position_y`=-3775.147,`position_z`=126.7992 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,337.8778,-3781.475,127.0284,0,0,0,0,100,0),
(@PATH,2,348.2281,-3797.657,127.2243,0,0,0,0,100,0),
(@PATH,3,337.8778,-3781.475,127.0284,0,0,0,0,100,0),
(@PATH,4,353.2792,-3775.147,126.7992,0,0,0,0,100,0),
(@PATH,5,360.8041,-3764.615,126.8099,0,0,0,0,100,0),
(@PATH,6,384.1081,-3758.339,126.8203,0,0,0,0,100,0),
(@PATH,7,398.6287,-3760.762,126.0662,0,0,0,0,100,0),
(@PATH,8,421.6737,-3776.188,122.9383,0,0,0,0,100,0),
(@PATH,9,439.5612,-3795.414,120.8122,0,0,0,0,100,0),
(@PATH,10,416.8036,-3816.887,120.3546,0,0,0,0,100,0),
(@PATH,11,400.8517,-3822.608,118.5542,0,0,0,0,100,0),
(@PATH,12,381.2686,-3822.9,114.8412,0,0,0,0,100,0),
(@PATH,13,372.0157,-3806.465,111.9946,0,0,0,0,100,0),
(@PATH,14,363.0406,-3792.427,111.5014,0,0,0,0,100,0),
(@PATH,15,374.681,-3774.967,106.5569,0,0,0,0,100,0),
(@PATH,16,363.0406,-3792.427,111.5014,0,0,0,0,100,0),
(@PATH,17,372.0157,-3806.465,111.9946,0,0,0,0,100,0),
(@PATH,18,381.2686,-3822.9,114.8412,0,0,0,0,100,0),
(@PATH,19,400.8517,-3822.608,118.5542,0,0,0,0,100,0),
(@PATH,20,416.8036,-3816.887,120.3546,0,0,0,0,100,0),
(@PATH,21,439.5612,-3795.414,120.8122,0,0,0,0,100,0),
(@PATH,22,421.6737,-3776.188,122.9383,0,0,0,0,100,0),
(@PATH,23,398.6287,-3760.762,126.0662,0,0,0,0,100,0),
(@PATH,24,384.1081,-3758.339,126.8203,0,0,0,0,100,0),
(@PATH,25,360.8041,-3764.615,126.8099,0,0,0,0,100,0),
(@PATH,26,353.2792,-3775.147,126.7992,0,0,0,0,100,0);

-- Pathing for Vilebranch Warrior Entry: 4465
SET @NPC := 93742;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-300.8814,`position_y`=-4190.363,`position_z`=136.5622 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-299.2402,-4199.432,136.8216,0,0,0,0,100,0),
(@PATH,2,-294.703,-4206.721,136.5972,0,0,0,0,100,0),
(@PATH,3,-284.916,-4203.682,136.7266,0,0,0,0,100,0),
(@PATH,4,-281.4611,-4198.692,136.5716,0,0,0,0,100,0),
(@PATH,5,-278.4128,-4187.48,136.5716,0,0,0,0,100,0),
(@PATH,6,-279.7527,-4179.343,136.4959,0,0,0,0,100,0),
(@PATH,7,-282.9599,-4172.346,136.5655,0,0,0,0,100,0),
(@PATH,8,-291.1088,-4159.861,136.5396,0,0,0,0,100,0),
(@PATH,9,-296.5112,-4150.362,136.5396,0,0,0,0,100,0),
(@PATH,10,-297.4698,-4136.667,136.5396,0,0,0,0,100,0),
(@PATH,11,-296.116,-4127.808,136.4748,0,0,0,0,100,0),
(@PATH,12,-287.9145,-4123.469,136.6125,0,0,0,0,100,0),
(@PATH,13,-276.8211,-4123.947,137.0688,0,0,0,0,100,0),
(@PATH,14,-268.0964,-4124.016,135.5265,0,0,0,0,100,0),
(@PATH,15,-259.8373,-4124.032,128.8418,0,0,0,0,100,0),
(@PATH,16,-253.119,-4123.896,124.6126,0,0,0,0,100,0),
(@PATH,17,-245.0412,-4124.756,119.3458,0,0,0,0,100,0),
(@PATH,18,-231.2207,-4124.845,117.8142,0,0,0,0,100,0),
(@PATH,19,-213.4383,-4132.925,118.0337,0,0,0,0,100,0),
(@PATH,20,-231.2207,-4124.845,117.8142,0,0,0,0,100,0),
(@PATH,21,-245.0412,-4124.756,119.3458,0,0,0,0,100,0),
(@PATH,22,-253.119,-4123.896,124.6126,0,0,0,0,100,0),
(@PATH,23,-259.8373,-4124.032,128.8418,0,0,0,0,100,0),
(@PATH,24,-268.0964,-4124.016,135.5265,0,0,0,0,100,0),
(@PATH,25,-276.8211,-4123.947,137.0688,0,0,0,0,100,0),
(@PATH,26,-287.9145,-4123.469,136.6125,0,0,0,0,100,0),
(@PATH,27,-296.116,-4127.808,136.4748,0,0,0,0,100,0),
(@PATH,28,-297.4698,-4136.667,136.5396,0,0,0,0,100,0),
(@PATH,29,-296.5112,-4150.362,136.5396,0,0,0,0,100,0),
(@PATH,30,-291.1088,-4159.861,136.5396,0,0,0,0,100,0),
(@PATH,31,-282.9599,-4172.346,136.5655,0,0,0,0,100,0),
(@PATH,32,-279.7527,-4179.343,136.4959,0,0,0,0,100,0),
(@PATH,33,-278.4128,-4187.48,136.5716,0,0,0,0,100,0),
(@PATH,34,-281.4611,-4198.692,136.5716,0,0,0,0,100,0),
(@PATH,35,-284.916,-4203.682,136.7266,0,0,0,0,100,0),
(@PATH,36,-294.703,-4206.721,136.5972,0,0,0,0,100,0),
(@PATH,37,-299.2402,-4199.432,136.8216,0,0,0,0,100,0),
(@PATH,38,-300.8814,-4190.363,136.5622,0,0,0,0,100,0);

-- Gossip Menu insert from sniff
DELETE FROM `gossip_menu` WHERE `entry`=6059 AND `text_id`=7211;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (6059,7211);
DELETE FROM `gossip_menu` WHERE `entry`=6087 AND `text_id`=7241;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (6087,7241);
DELETE FROM `gossip_menu` WHERE `entry`=6088 AND `text_id`=7242;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (6088,7242);
DELETE FROM `gossip_menu` WHERE `entry`=6086 AND `text_id`=7240;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (6086,7240);

-- Creature Gossip_menu_id Update from sniff
UPDATE `creature_template` SET `gossip_menu_id`=6059 WHERE `entry`=14731;
UPDATE `creature_template` SET `gossip_menu_id`=6087 WHERE `entry`=14740;
UPDATE `creature_template` SET `gossip_menu_id`=6088 WHERE `entry`=14741;
UPDATE `creature_template` SET `gossip_menu_id`=6086 WHERE `entry`=14739;

-- Creature Gossip_menu_option Update from sniff
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (6059,6087,6086) AND `id` IN (0);
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (6059,6087) AND `id` IN (1);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(6059,0,5, 'Make this inn your home.',8,65536,0,0,0,0, ''),
(6059,1,1, 'Let me browse your goods.',3,128,0,0,0,0, ''),
(6087,0,1, 'I would like to buy from you.',3,128,0,0,0,0, ''),
(6087,1,3, 'What can you teach me?',5,16,0,0,0,0, ''),
(6086,0,1, 'I would like to buy from you.',3,128,0,0,0,0, '');

-- Pathing for King Dred Entry: 27483 "Drak'Tharon Keep"
SET @NPC := 127507;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-544.874,`position_y`=-696.9735,`position_z`=30.29507 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-529.7952,-711.4729,30.37141,0,1000,0,0,100,0),
(@PATH,2,-544.874,-696.9735,30.29507,0,0,0,0,100,0),
(@PATH,3,-550.9299,-694.043,30.49649,0,0,0,0,100,0),
(@PATH,4,-554.3631,-689.458,30.83389,0,0,0,0,100,0),
(@PATH,5,-554.6004,-681.4241,30.67007,0,0,0,0,100,0),
(@PATH,6,-550.1124,-674.5519,30.67007,0,0,0,0,100,0),
(@PATH,7,-540.9714,-671.0374,30.29507,0,0,0,0,100,0),
(@PATH,8,-535.8426,-664.3137,30.29507,0,1000,0,0,100,0),
(@PATH,9,-540.9714,-671.0374,30.29507,0,0,0,0,100,0),
(@PATH,10,-550.1124,-674.5519,30.67007,0,0,0,0,100,0),
(@PATH,11,-554.6004,-681.4241,30.67007,0,0,0,0,100,0),
(@PATH,12,-554.3631,-689.458,30.83389,0,0,0,0,100,0),
(@PATH,13,-550.9299,-694.043,30.49649,0,0,0,0,100,0),
(@PATH,14,-544.874,-696.9735,30.29507,0,0,0,0,100,0);

-- Spawn & Pathing for Nethervine Inciter Entry: 19511 "Not Spawned"
SET @NPC := 40252;
DELETE FROM `creature` WHERE `guid` IN (@NPC);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`) VALUES
(@NPC,19511,553,1,1,0,0,13.71129,556.805,-18.16187,0.41887,300,0,0,1,0,2);
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,34.53745,554.1877,-18.31396,0,0,0,0,100,0),
(@PATH,2,13.71129,556.805,-18.16187,0,0,0,0,100,0),
(@PATH,3,-11.50565,559.8253,-18.09619,0,0,0,0,100,0),
(@PATH,4,-29.17254,568.2135,-17.99052,0,0,0,0,100,0),
(@PATH,5,-11.50565,559.8253,-18.09619,0,0,0,0,100,0),
(@PATH,6,13.71129,556.805,-18.16187,0,0,0,0,100,0);
-- .go 34.53745 554.1877 -18.31396

-- Pathing for Nethervine Inciter Entry: 19511
SET @NPC := 83086;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-37.1817,`position_y`=524.0293,`position_z`=-10.16431 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-21.58225,517.7063,-6.475254,0,0,0,0,100,0),
(@PATH,2,-9.34382,516.5084,-5.636462,0,0,0,0,100,0),
(@PATH,3,4.990617,518.1604,-7.138422,0,0,0,0,100,0),
(@PATH,4,19.44558,526.3201,-11.25785,0,0,0,0,100,0),
(@PATH,5,23.91135,540.4265,-18.37715,0,0,0,0,100,0),
(@PATH,6,18.10396,548.5428,-18.3295,0,0,0,0,100,0),
(@PATH,7,-1.83314,553.5635,-18.1602,0,0,0,0,100,0),
(@PATH,8,-17.95817,553.2923,-18.19155,0,0,0,0,100,0),
(@PATH,9,-30.42817,550.3372,-18.30474,0,0,0,0,100,0),
(@PATH,10,-43.32164,544.6859,-18.35999,0,0,0,0,100,0),
(@PATH,11,-46.76561,533.5467,-15.89331,0,0,0,0,100,0),
(@PATH,12,-37.1817,524.0293,-10.16431,0,0,0,0,100,0);
-- .go -21.58225 517.7063 -6.475254

-- Pathing for Nethervine Inciter Entry: 19511
SET @NPC := 83072;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-10.81185,`position_y`=498.6948,`position_z`=-5.355443 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10.5063,509.9379,-5.275531,0,0,0,0,100,0),
(@PATH,2,-10.81185,498.6948,-5.355443,0,0,0,0,100,0),
(@PATH,3,2.500325,493.4179,-5.437914,0,0,0,0,100,0),
(@PATH,4,15.09316,496.8965,-5.464271,0,0,0,0,100,0),
(@PATH,5,2.500325,493.4179,-5.437914,0,0,0,0,100,0),
(@PATH,6,-10.81185,498.6948,-5.355443,0,0,0,0,100,0);
-- .go -10.5063 509.9379 -5.275531

-- Pathing for Nethervine Inciter Entry: 19511
SET @NPC := 83073;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-6.525395,`position_y`=482.9323,`position_z`=-5.492778 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1.63937,482.4999,-5.53459,0,0,0,0,100,0),
(@PATH,2,-6.525395,482.9323,-5.492778,0,0,0,0,100,0),
(@PATH,3,-13.81937,488.856,-5.425375,0,0,0,0,100,0),
(@PATH,4,-17.63536,496.55,-5.370692,0,0,0,0,100,0),
(@PATH,5,-16.29433,503.0782,-5.324292,0,0,0,0,100,0),
(@PATH,6,-17.63536,496.55,-5.370692,0,0,0,0,100,0),
(@PATH,7,-13.81937,488.856,-5.425375,0,0,0,0,100,0),
(@PATH,8,-6.525395,482.9323,-5.492778,0,0,0,0,100,0);
-- .go 1.63937 482.4999 -5.53459

-- add spawn for Saragosa 
SET @GUID := 40270; 
DELETE FROM `creature` WHERE `id`=26231;
INSERT INTO creature (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES 
(@GUID,26231,571,1,1,0,0,3981.03687,7148.006,666.1618,1.037019,120,0,0,1,0,0,0,0,0);
-- Pathing for Saragosa Entry: 26231

SET @PATH = @GUID*10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@GUID,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3972.692,7139.177,666.609,0,0,0,0,100,0),
(@PATH,2,3973.208,7140.034,666.609,0,0,0,0,100,0),
(@PATH,3,3981.671,7149.173,666.2463,0,0,0,0,100,0),
(@PATH,4,3989.375,7172.479,669.3846,0,0,0,0,100,0),
(@PATH,5,3998.89,7199.31,674.7188,0,0,0,0,100,0),
(@PATH,6,4012.167,7242.467,666.8287,0,0,0,0,100,0),
(@PATH,7,4020.924,7276.525,652.9682,0,0,0,0,100,0),
(@PATH,8,4026.488,7297.103,640.2736,0,0,0,0,100,0),
(@PATH,9,4026.488,7297.103,640.2736,0,0,0,0,100,0);