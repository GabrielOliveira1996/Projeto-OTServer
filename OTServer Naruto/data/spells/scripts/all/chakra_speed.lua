local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

local condition = createConditionObject(CONDITION_HASTE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 20000)
setConditionParam(condition, CONDITION_PARAM_SPEED, 50)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
    local getSkill = getPlayerSkillLevel(cid, 6) -- pega a skill equivalente o chakra control que na source é o fishing.
    local getMana = getCreatureMana(cid)
    local necessarySkill = 20 -- deve ser 30 para conseguir utilizar.

    if (getPlayerVocation(cid) == 64 or getPlayerVocation(cid) == 65 or getPlayerVocation(cid) == 65) then
        doPlayerSendCancel(cid, "You cannot use this jutsu while in Kyuubi form.")
    else
        if (getSkill >= necessarySkill) then
            return doCombat(cid, combat, var)
        else
            doPlayerSendCancel(cid, "You need to have level " .. necessarySkill .. " in chakra control.")
        end
    end
end
