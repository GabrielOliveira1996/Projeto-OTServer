local FUSION_EFFECT = 10 
local CHAKRA_DRAIN_PER_SECOND = 20 
local DRAIN_INTERVAL = 2000 

local fusionConditions = {}
for i = 1, 200 do
    fusionConditions[i] = createConditionObject(CONDITION_ATTRIBUTES)
    setConditionParam(fusionConditions[i], CONDITION_PARAM_TICKS, -1) 
    setConditionParam(fusionConditions[i], CONDITION_PARAM_SKILL_FIST, i)
    setConditionParam(fusionConditions[i], CONDITION_PARAM_SKILL_SHIELD, i)
    setConditionParam(fusionConditions[i], CONDITION_PARAM_SKILL_CLUB, i)
end

-- Função para encerrar a fusão
local function endFusion(cid)
    if not isCreature(cid) then return end
    
    local bSpeed = getPlayerStorageValue(cid, STORAGE_BONUS_SPEED)
    if bSpeed > 0 then
        doChangeSpeed(cid, -bSpeed)
    end
    
    doRemoveCondition(cid, CONDITION_ATTRIBUTES)
    doRemoveCondition(cid, CONDITION_OUTFIT)
    
    setPlayerStorageValue(cid, STORAGE_IS_FUSED, -1)
    setPlayerStorageValue(cid, STORAGE_BONUS_SPEED, 0)
    
    doSendMagicEffect(getCreaturePosition(cid), 2) 
    doPlayerSendTextMessage(cid, 20, "A fusão foi desfeita.")
end

local function drainMana(cid)
    if not isCreature(cid) then return end
    if getPlayerStorageValue(cid, STORAGE_IS_FUSED) <= 0 then return end 

    if getCreatureMana(cid) < CHAKRA_DRAIN_PER_SECOND then
        endFusion(cid)
    else
        doPlayerRemoveMana(cid, -CHAKRA_DRAIN_PER_SECOND)
        addEvent(drainMana, DRAIN_INTERVAL, cid)
    end
end

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, STORAGE_IS_FUSED) > 0 then
        endFusion(cid) 
        return true
    end

    local summons = getCreatureSummons(cid)
    local targetSummon = nil
    local playerName = getCreatureName(cid)

    for _, summon in ipairs(summons) do
        local sName = getCreatureName(summon)
        if sName == "Akamaru" or sName == playerName then
            targetSummon = summon
            break
        end
    end

    if not targetSummon then
        doPlayerSendCancel(cid, "Você precisa do Akamaru ou do Bunshin para se fundir.")
        return false
    end

    if getCreatureMana(cid) < CHAKRA_DRAIN_PER_SECOND then
        doPlayerSendCancel(cid, "Você não tem chakra suficiente.")
        return false
    end

    local atkBonus = math.floor(getPlayerAkamaruAttack(cid) / 2)
    local speedBonus = math.floor(getPlayerAkamaruMaxSpeed(cid) / 2)
    local selectedBonus = math.max(1, math.min(200, atkBonus))

    doSendMagicEffect(getCreaturePosition(targetSummon), 10)
    doRemoveCreature(targetSummon)
    doAddCondition(cid, fusionConditions[selectedBonus])
    doChangeSpeed(cid, speedBonus)
    setPlayerStorageValue(cid, STORAGE_BONUS_SPEED, speedBonus)
    setPlayerStorageValue(cid, STORAGE_IS_FUSED, 1)
    doSetCreatureOutfit(cid, {lookType = FIRST_FUSION_OUTFIT}, -1)
    doSendMagicEffect(getCreaturePosition(cid), FUSION_EFFECT)
    drainMana(cid)
    return true
end