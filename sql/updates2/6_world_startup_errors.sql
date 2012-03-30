UPDATE creature_template SET scriptname = "npc_flame_leviathan_seat" WHERE entry = 33114;
UPDATE creature_template SET scriptname = "npc_flame_leviathan_defense_turret" WHERE entry = 33142;
UPDATE creature_template SET scriptname = "npc_flame_leviathan_overload_device" WHERE entry = 33143;
UPDATE creature_template SET scriptname = "npc_liquid_pyrite" WHERE entry = 33189;
UPDATE creature_template SET scriptname = "npc_freyas_ward" WHERE entry = 33367;
UPDATE creature_template SET scriptname = "npc_freyas_ward_summon" WHERE entry = 33387;
UPDATE creature_template SET scriptname = "npc_leviathan_player_vehicle" WHERE entry IN (33060, 33062, 33109);
UPDATE creature_template SET scriptname = "npc_flame_leviathan_defense_cannon" WHERE entry = 33139;
UPDATE creature_template SET scriptname = "npc_queldelar_schwert" WHERE entry = 37158;
UPDATE creature_template SET scriptname = "npc_spectator" WHERE entry = 26667;
UPDATE creature_template SET scriptname = "npc_ritual_channeler" WHERE entry = 27281;
UPDATE creature_template SET scriptname = "mob_saronit_vapor" WHERE entry = 33488;
UPDATE creature_template SET scriptname = "mob_saronit_animus" WHERE entry = 33524;
UPDATE creature_template SET scriptname = "npc_queldelar" WHERE entry = 37704;

UPDATE creature_template SET spell4 = 64677 WHERE entry = 33060;
DELETE FROM areatrigger_scripts WHERE entry = 5369;
INSERT INTO areatrigger_scripts VALUES (5369, 'at_RX_214_repair_o_matic_station');
REPLACE INTO spell_script_names VALUES
(62359, 'spell_anti_air_rocket'),
(62324, 'spell_throw_passenger'),
(62374, 'spell_pursued'),
(65044, 'spell_flame_leviathan_flames'),
(62907, 'spell_freyas_ward_summon'),
(63847, 'spell_flame_leviathan_flame_vents'),
(64677, 'spell_shield_generator'),
(63018, 'spell_xt002_searing_light'),
(63024, 'spell_xt002_gravity_bomb'),
(63276, 'spell_general_vezax_mark_of_the_faceless_aura'),
(63278, 'spell_general_vezax_mark_of_the_faceless_drain'),
(62692, 'spell_general_vezax_aura_of_despair_aura'),
(63495, 'spell_steelbreaker_static_disruption'),
(61900, 'spell_steelbreaker_electrical_charge'),
(48278, 'spell_paralyze_pinnacle');

