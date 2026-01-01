local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)
setCombatCondition(combat, condition)

local condition = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(condition, CONDITION_PARAM_TICKS, tempo * 1000)
setConditionParam(condition, CONDITION_PARAM_BUFF, true)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
	heal(cid)
	return doCombat(cid, combat, var)
end

function heal(cid)
	local formula = 100 * getPlayerLevel(cid) 
	for i = 1, tempo do
		addEvent(doCreatureAddHealth,1000 * i,cid, formula / tempo)
	end
end