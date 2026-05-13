local damage_type = COMBAT_KATON_DAMAGE 
local effect_braco = 22
local speed_braco = 100 
local max_range = 7

local allowed_vocations = {5, 6, 7, 8, 9, 10}

-- condição de lentidão
local paralyze = createConditionObject(CONDITION_PARALYZE)
setConditionParam(paralyze, CONDITION_PARAM_TICKS, 2000) -- 2 segundos
setConditionParam(paralyze, CONDITION_PARAM_SPEED, -100) -- intensidade do slow
setConditionFormula(paralyze, -0.7, 0, -0.7, 0) -- formula para garantir que funcione em levels altos

-- função que faz o braço se movimentar
local function travelClaw(cid, target, lastPos)
    if not isCreature(cid) or not isCreature(target) then return end

    local pPos = getCreaturePosition(cid)
    local tPos = getCreaturePosition(target)
    
    -- verifica distância entre a posição atual do efeito e o alvo
    local distFromUser = getDistanceBetween(pPos, lastPos)
    local distFromTarget = getDistanceBetween(tPos, lastPos)

    -- falha: se o braço se distanciar demais do dono ou se o dono se afastar demais do alvo
    if distFromUser > max_range or getDistanceBetween(pPos, tPos) > max_range then
        doSendMagicEffect(lastPos, 2) 
        return
    end

    -- sucesso: alcançou o alvo
    if distFromTarget <= 1 then
        local level = getPlayerLevel(cid)
        local fist = getPlayerSkillLevel(cid, SKILL_TAIJUTSU)
        local ml = getPlayerMagLevel(cid)
        
        local min = (level * 2.0) + (fist * 2.0)
        local max = (level * 3.0) + (fist * 3.5)
        
        -- aplica Dano
        doTargetCombatHealth(cid, target, damage_type, -min, -max, effect_braco)
        
        -- aplica lentidão
        doAddCondition(target, paralyze)
        return
    end

    -- cálculo de movimento
    local nextPos = {x = lastPos.x, y = lastPos.y, z = lastPos.z}
    if lastPos.x < tPos.x then nextPos.x = nextPos.x + 1 elseif lastPos.x > tPos.x then nextPos.x = nextPos.x - 1 end
    if lastPos.y < tPos.y then nextPos.y = nextPos.y + 1 elseif lastPos.y > tPos.y then nextPos.y = nextPos.y - 1 end

    -- se o próximo passo for o mesmo de antes, evita loop infinito
    if nextPos.x == lastPos.x and nextPos.y == lastPos.y then
        -- já está em cima do alvo ou bloqueado
    else
        doSendMagicEffect(nextPos, effect_braco)
        addEvent(travelClaw, speed_braco, cid, target, nextPos)
    end
end

function onCastSpell(cid, var)
    if not isInArray(allowed_vocations, getPlayerVocation(cid)) then
        doPlayerSendCancel(cid, "Você precisa estar na forma da Kyuubi.")
        return false
    end

    local target = getCreatureTarget(cid)
    if not isCreature(target) then
        doPlayerSendCancel(cid, "Você precisa de um alvo.")
        return false
    end

    local pPos = getCreaturePosition(cid)
    if getDistanceBetween(pPos, getCreaturePosition(target)) > max_range then
        doPlayerSendCancel(cid, "O alvo está muito longe.")
        return false
    end

    travelClaw(cid, target, pPos)
    return true
end