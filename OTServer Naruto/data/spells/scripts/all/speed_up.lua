local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

local condition = createConditionObject(CONDITION_HASTE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 10000)
setConditionFormula(condition, 0, 500, 0, 0)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
    local getSkill = getPlayerSkillLevel(cid, 6) -- Pega a skill equivalente o chakra control que na source é o fishing.
    local getMana = getCreatureMana(cid)
    local necessarySkill = 30 -- Deve ser 30.
    local totalManaExpenditure = 60 -- Valor de mana gasta.

    if (getPlayerVocation(cid) == 64 or getPlayerVocation(cid) == 65 or getPlayerVocation(cid) == 65) then
        doPlayerSendCancel(cid, "You cannot use this jutsu while in Kyuubi form.")
    else
        if (getSkill >= necessarySkill) then
            if (getMana >= (totalManaExpenditure - getSkill)) then
                local calc = math.min(totalManaExpenditure / 2, -totalManaExpenditure + getSkill)
                doPlayerAddMana(cid, calc);
                return doCombat(cid, combat, var)
            else
                doPlayerSendCancel(cid, "You need " .. totalManaExpenditure - getSkill .. " chakra to use this jutsu.")
            end
        else
            doPlayerSendCancel(cid, "You need to have level " .. necessarySkill .. " in chakra control.")
        end
    end
end
