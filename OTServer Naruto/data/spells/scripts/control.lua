local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)

local exhaust = createConditionObject(CONDITION_EXHAUST)
setConditionParam(exhaust, CONDITION_PARAM_SUBID, 1)
setConditionParam(exhaust, CONDITION_PARAM_TICKS, 1 * 10 * 1000)
setCombatCondition(combat, exhaust)

function onCastSpell(cid, var)
        local target = getCreatureTarget(cid)
        if isCreature(target) then
                local creature = doConvinceCreature(creature, getThingPosition(target))
                doConvinceCreature(cid, creature)
                return doCombat(cid, combat, var)
        else
                return doPlayerSendCancel(cid, "You need a target.")
        end
end