function onCombat(cid, attacker, type, combat)
if type == COMBAT_PHYSICALDAMAGE or COMBAT_DEATHDAMAGE and isCreature(attacker) then
doTargetCombatHealth(attacker, cid, combat, 1, 100000, 1)
doPlayerAddSkillTry(cid, 5, 1)
return true
end
end
