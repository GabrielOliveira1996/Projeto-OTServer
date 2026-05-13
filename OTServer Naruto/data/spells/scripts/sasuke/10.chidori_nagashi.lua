local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_RAITON_DAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 81)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 5)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 1000) 
setConditionParam(condition, CONDITION_PARAM_SPEED, -1500) 
setCombatCondition(combat, condition)

local arr = {
    {0, 0, 1, 0, 0},
    {0, 1, 1, 1, 0},
    {1, 1, 2, 1, 1},
    {0, 1, 1, 1, 0},
    {0, 0, 1, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onGetFormulaValues(cid, level, maglevel)
    local min = (level * 1.5) + (maglevel * 3.5) + 250
    local max = (level * 2.0) + (maglevel * 5.5) + 300
    return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
    if exhaustion.check(cid, 23010) == false then
        exhaustion.set(cid, 23010, 2)
        
        doCombat(cid, combat, var)
        
        addEvent(function()
            if isCreature(cid) then
                doCombat(cid, combat, var)
            end
        end, 200)
        
        return true
    else
        doPlayerSendCancel(cid, "Cooldown[" .. exhaustion.get(cid, 23010) .. "]")
        return false
    end
end