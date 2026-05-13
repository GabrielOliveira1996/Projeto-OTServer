local function getAkamaru(cid)
    local summons = getCreatureSummons(cid)
    if #summons > 0 then
        for _, summon in ipairs(summons) do
            -- Busca pela Storage Universal do Akamaru (Cachorro ou Bunshin)
            if getCreatureStorage(summon, STORAGE_AKAMARU_IDENTIFIER) == 1 then
                return summon
            end
        end
    end
    return nil
end

function onCastSpell(cid, var)
    local akamaru = getAkamaru(cid)
    
    if not akamaru then
        doPlayerSendCancel(cid, "Seu Akamaru ou Bunshin precisa estar invocado para usar este jutsu.")
        return false
    end

    local pos = getThingPos(akamaru)
    local playerPos = getThingPos(cid)
    
    -- Sincroniza a vida na Source antes de remover (importante para o sistema de HP que fizemos)
    local currentHP = getCreatureHealth(akamaru)
    -- Se você optou por não criar a função setAkamaruCurrentHp, a source 
    -- salvará o HP via onCreatureDisappear (que é disparado pelo doRemoveCreature)
    
    -- Efeito 10 no Akamaru ao sumir
    doSendMagicEffect(pos, 10)
    
    -- Remove a criatura (Akamaru ou Bunshin)
    doRemoveCreature(akamaru)

    -- Configuração de Dano
    local level = getPlayerLevel(cid)
    local fist = getPlayerSkillLevel(cid, SKILL_FIST)

    local min = ((fist * 3.0) + (level * 1.5)) + 50
    local max = ((fist * 4.5) + (level * 3.0)) + 100

    -- Tiro de distância do Player até onde o Akamaru estava
    doSendDistanceShoot(playerPos, pos, 8)

    -- Explosão de estilhaços/ataque em área
    for x = -1, 1 do
        for y = -1, 1 do
            local targetPos = {x = pos.x + x, y = pos.y + y, z = pos.z}
            
            -- Efeito visual de disparos saindo do centro para as bordas
            if not (x == 0 and y == 0) then
                doSendDistanceShoot(pos, targetPos, 8)
            end
            
            -- Causa dano físico
            doAreaCombatHealth(cid, COMBAT_PHYSICALDAMAGE, targetPos, 0, -min, -max, 3) -- Efeito 3 (Explosão/Fumaça)
        end
    end

    return true
end