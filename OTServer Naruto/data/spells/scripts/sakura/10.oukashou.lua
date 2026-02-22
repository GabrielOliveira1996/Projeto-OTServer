local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

local area = createCombatArea({
    {1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 3, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1},
})
setCombatArea(combat, area)

function onGetFormulaValues(cid, level, skill)
    local min = (skill * 1.5) + (level * 0.8) + 250
    local max = (skill * 2.5) + (level * 1.2) + 400
    return -min, -max
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
    if exhaustion.check(cid, 22003) == false then
        local pos = getThingPos(cid)

        local posEfeito1 = {x = pos.x + 1, y = pos.y - 0, z = pos.z}
        doSendMagicEffect(posEfeito1, 20)
        
        local posEfeito2 = {x = pos.x + 4, y = pos.y - 0, z = pos.z}
        
        addEvent(function()
            if isCreature(cid) then
                doSendMagicEffect(posEfeito2, 62)
            end
        end, 150)

        exhaustion.set(cid, 22003, 2)
        return doCombat(cid, combat, var)
    else
        doPlayerSendTextMessage(cid, 22, "Cooldown [" .. exhaustion.get(cid, 22003) .. "s]")
        return false
    end
end