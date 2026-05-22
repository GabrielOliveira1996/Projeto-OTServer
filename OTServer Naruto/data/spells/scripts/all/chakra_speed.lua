local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

local condition = createConditionObject(CONDITION_HASTE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 20000)
setConditionParam(condition, CONDITION_PARAM_SPEED, 50)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
    local chakraControl = getPlayerSkillLevel(cid, SKILL_CONTROL)
    local necessaryToUse = 20

    if (chakraControl >= necessaryToUse) then
        return doCombat(cid, combat, var)
    else
        doPlayerSendCancel(cid, "Você precisa ter " .. necessaryToUse .. " deControle de Chakra.")
    end
end
