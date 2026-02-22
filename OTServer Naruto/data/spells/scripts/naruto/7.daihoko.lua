local damage_type = COMBAT_KATON_DAMAGE 
local effect_braco = 22

local area = createCombatArea({{3}})

function onCastSpell(cid, var)
    local target = getCreatureTarget(cid)
    
    if not isCreature(target) then
        doPlayerSendCancel(cid, "Voce precisa de um alvo.")
        return false
    end

    local pPos = getCreaturePosition(cid)
    local tPos = getCreaturePosition(target)
    
    if getDistanceBetween(pPos, tPos) > 4 then
        doPlayerSendCancel(cid, "O alvo esta muito longe.")
        return false
    end

    local pos_efeito = {x = tPos.x + 1, y = tPos.y, z = tPos.z}

    -- taijutsu + ninjutsu
    local fist = getPlayerSkillLevel(cid, 0)
    local ml = getPlayerMagLevel(cid)
    
    local min = (fist * 1.5) + (ml * 2.0) + 50
    local max = (fist * 2.5) + (ml * 3.5) + 100

    doAreaCombatHealth(cid, damage_type, tPos, area, -min, -max, 0)
    doSendMagicEffect(pos_efeito, effect_braco)
    
    return true
end