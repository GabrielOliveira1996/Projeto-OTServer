local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)
setCombatParam(combat, COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
setHealingFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 9, 9, 9, 11)

function onCastSpell(cid, var)
	local getSkill = getPlayerSkillLevel(cid, 6) -- Pega a skill equivalente o chakra control que na source é o fishing.
    local getMana = getCreatureMana(cid)
    local necessarySkill = 40 -- Deve ser 40.
    local totalManaExpenditure = 150 -- Valor de mana gasta.

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
