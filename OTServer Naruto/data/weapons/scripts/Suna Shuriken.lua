local combat = createCombatObject()


setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 1)

setCombatParam(combat, COMBAT_PARAM_BLOCKSHIELD, 1)

setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

setCombatParam(combat, COMBAT_PARAM_EFFECT, 95)

setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_GREENSTAR)

setCombatFormula(combat, COMBAT_FORMULA_SKILL, 1, 0, 1, 0)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 205)



local area = createCombatArea({
	{0, 0, 0},
	{0, 3, 0},
	{0, 0, 0}
})



setCombatArea(combat, area)

function onUseWeapon(cid, var)
	
return 
doCombat(cid, combat, var)

end
