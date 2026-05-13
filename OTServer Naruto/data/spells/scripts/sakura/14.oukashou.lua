local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 2000)
setConditionParam(condition, CONDITION_PARAM_SPEED, -200) 

function onCastSpell(cid, var)
    local STORAGE_EXHAUST = 23014
    local COOLDOWN_TIME = 2

    if exhaustion.check(cid, STORAGE_EXHAUST) then
        doPlayerSendCancel(cid, "Cooldown [" .. exhaustion.get(cid, STORAGE_EXHAUST) .. "s]")
        return false
    end

    local level = getPlayerLevel(cid)
    local fist = getPlayerSkillLevel(cid, 0) 
    local lookDir = getCreatureLookDirection(cid)
    local EFFECT_ID = 37 
    
    -- Dano Shannaro/Oukashou
    local min = (fist * 2.0) + (level * 6.0) + 250
    local max = (fist * 3.0) + (level * 7.0) + 400
    local pos = getThingPos(cid)
    local speed = 50 -- Velocidade da onda

    -- Loop de 6 SQMs usando a lógica da primeira spell
    for i = 1, 6 do
        addEvent(function()
            if not isCreature(cid) then return end -- Segurança se o player deslogar
            
            local targetPos = {x = pos.x, y = pos.y, z = pos.z}

            if lookDir == 0 then targetPos.y = targetPos.y - i      -- Norte
            elseif lookDir == 1 then targetPos.x = targetPos.x + i -- Leste
            elseif lookDir == 2 then targetPos.y = targetPos.y + i -- Sul
            elseif lookDir == 3 then targetPos.x = targetPos.x - i -- Oeste
            end

            -- Efeito visual
            doSendMagicEffect(targetPos, EFFECT_ID)

            -- Busca criatura exatamente como na primeira spell que funciona
            local target = getTopCreature(targetPos).uid
            if isCreature(target) and target ~= cid then
                -- Aplica dano e paralisia
                doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -min, -max, CONST_ME_NONE)
                doAddCondition(target, condition)
            end
        end, i * speed)
    end

    exhaustion.set(cid, STORAGE_EXHAUST, COOLDOWN_TIME)
    return true
end