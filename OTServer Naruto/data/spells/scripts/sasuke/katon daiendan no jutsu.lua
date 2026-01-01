local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 24)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.5, -190, -1.5, -280)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 192)

arr = {
{0, 0, 1, 0, 0},
{0, 1, 3, 1, 0},
{0, 0, 1, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
    local getSkill = getPlayerSkillLevel(cid, 6)
    local getMana = getCreatureMana(cid)
    local totalManaExpenditure = 140
    local calc = math.min(totalManaExpenditure / 2, -totalManaExpenditure + getSkill)
    
    if (getMana >= (totalManaExpenditure - getSkill)) then
        if exhaustion.check(cid, 23001) == false then
            exhaustion.set(cid, 23001, 2)
            doPlayerAddMana(cid, calc)
            doCombat(cid, combat, var)
            return true
        else
            doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 23001).."]")
        end
    else
        doPlayerSendCancel(cid, "You need " .. totalManaExpenditure - getSkill .. " chakra to use this jutsu.")
    end  
end