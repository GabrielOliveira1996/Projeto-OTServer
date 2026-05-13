-- Condição de invisibilidade no topo
local invisible = createConditionObject(CONDITION_INVISIBLE)
setConditionParam(invisible, CONDITION_PARAM_TICKS, 2000)

local function removeInvisibility(cid)
    if isCreature(cid) then
        doCreatureSetHideHealth(cid, false)
    end
end

function onCastSpell(cid, var)
    local cooldownStorage = 23002
    local cooldownTime = 15
    local duration = 2
    local monsterToSummon = "Mushi Bunshin"
    local spawnPos = getThingPos(cid)

    if os.time() < getPlayerStorageValue(cid, cooldownStorage) then
        doPlayerSendCancel(cid, "Your Mushi Bunshin is on cooldown.")
        return false
    end

    -- 1. Cria o Clone idêntico (Usa sua função da lib)
    local clone = createBunshin(monsterToSummon, spawnPos, cid)
    
    if clone then
        -- 2. Limpa paralisia para o Shino não travar
        doRemoveCondition(cid, CONDITION_PARALYZE)

        -- 3. Força monstros a trocarem o alvo para o clone
        local enemies = getSpectators(spawnPos, 7, 7, false)
        if enemies then
            for _, enemy in ipairs(enemies) do
                -- Verifica se é um monstro e se NÃO é um summon (usando getCreatureMaster)
                if isMonster(enemy) and getCreatureMaster(enemy) == enemy then
                    doMonsterSetTarget(enemy, clone)
                end
            end
        end

        doConvinceCreature(cid, clone)
        doSendMagicEffect(spawnPos, 191) 
        doAddCondition(cid, invisible)
        doCreatureSetHideHealth(cid, true)

        -- Agendar o retorno da barra de vida
        addEvent(removeInvisibility, duration * 1000, cid)

        doCreatureSay(cid, "Mushi Bunshin no Jutsu!", TALKTYPE_MONSTER)
        setPlayerStorageValue(cid, cooldownStorage, os.time() + cooldownTime)
        
        return true
    end

    return false
end