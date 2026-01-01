local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_CREATEITEM, 1497)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)


local arr = {
{3}
}


local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
if getPlayerVocation(cid) == 5 or getPlayerVocation(cid) == 6 or getPlayerVocation(cid) == 7 or getPlayerVocation(cid) == 8 or getPlayerVocation(cid) == 74 or getPlayerVocation(cid) == 75 then
return doCombat(cid, combat, var)
end
end