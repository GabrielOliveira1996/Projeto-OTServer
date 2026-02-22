local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FUUTON_DAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 4)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1.0, -520, -1.5, -600)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 16)

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_FUUTON_DAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 103)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -1.0, -580, -1.7, -700)
setCombatParam(combat1, COMBAT_PARAM_HITCOLOR, 186)

arr = {
    {0, 0, 0},
    {0, 3, 0},
    {0, 0, 0},
}

arr1 = {
    {0, 0, 0},
    {0, 3, 0},
    {0, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

local area1 = createCombatArea(arr1)
setCombatArea(combat1, area1)

function onCastSpell(cid, var)
    local vocation = getPlayerVocation(cid)
    local getSkill = getPlayerSkillLevel(cid, 6)
    local getMana = getCreatureMana(cid)
    local totalManaExpenditure = 280
    local calc = math.min(totalManaExpenditure / 2, -totalManaExpenditure + getSkill)

    if (vocation == 37 or vocation == 39 or vocation == 40)  then
        if exhaustion.check(cid, 23000) == false then
            exhaustion.set(cid, 23000, 2)   
            return doCombat(cid, combat, var)
        else
            doPlayerSendCancel(cid, "Cooldown[" .. exhaustion.get(cid, 23000) .. "]")
        end
    else
        if exhaustion.check(cid, 23000) == false then
            exhaustion.set(cid, 23000, 2)   
            return doCombat(cid, combat1, var)
        else
            doPlayerSendCancel(cid, "Cooldown[" .. exhaustion.get(cid, 23000) .. "]")
        end
    end


        

end
