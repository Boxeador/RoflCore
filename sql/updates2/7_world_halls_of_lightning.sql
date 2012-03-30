-- Achievement for "Lighting Struckt"

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -52098;
INSERT INTO `spell_linked_spell` VALUES
(-52098, 52092, 0, 'General Bjarngrim - Charge up trigger Temporary Electrical Charge');

DELETE FROM `waypoint_scripts` WHERE `id` IN (12698101, 12698100);
INSERT INTO `waypoint_scripts` VALUES
(12698100, 0, 14, 52092, 1, 0, 0, 0, 0, 0, 900), -- Remove aura
(12698101, 2, 15, 52098, 1, 0, 0, 0, 0, 0, 901); -- Cast Charge up

DELETE FROM `waypoint_data` WHERE `id` = 1269810 AND `point` = 15;
INSERT `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES
(1269810, 15, 1262.19, -2.21648, 33.5057);

UPDATE `waypoint_data` SET `action` = 12698100 WHERE `id` = 1269810;
UPDATE `waypoint_data` SET `action` = 12698101, `delay` = 10000 WHERE `id` = 1269810 AND `point` IN (2, 8, 14);

DELETE FROM `disables` WHERE `entry` = 6835;
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 6835 AND `type` = 7;
INSERT INTO `achievement_criteria_data` VALUES
(6835, 7, 52097, 1, '');