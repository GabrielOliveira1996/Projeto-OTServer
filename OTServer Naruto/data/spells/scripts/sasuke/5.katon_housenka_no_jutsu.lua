-- 1. Funções de suporte para evitar o erro "attempt to call a nil value"
local function fixNumberToVariant(id) return {type = 1, number = id} end
local function fixPositionToVariant(pos) return {type = 3, pos = pos} end

-- 2. Configurações da Spell
local config = {
    shots = 8,
    targetedShots = 3,
    delay = 150,
    effect = 15,         -- Efeito de explosão no alvo
    distEffect = 33,     -- Projétil
    damageType = COMBAT_KATON_DAMAGE
}

-- 3. Objetos de Combate (sem Callbacks para evitar erro de carregamento)
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, config.damageType)
setCombatParam(combat, COMBAT_PARAM_EFFECT, config.effect)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, config.distEffect)

-- 4. Função de cálculo de dano interna
local function getDano(cid)
    local lv = getPlayerLevel(cid)
    local mag = getPlayerMagLevel(cid)
    local min = (lv * 0.3) + (mag * 0.6) + 5
    local max = (lv * 0.5) + (mag * 0.9) + 15
    return -math.random(min, max)
end

-- 5. Função que executa os disparos
local function executeHousenka(cid, targetId, staticPos, count)
    if not isCreature(cid) then return end

    local dano = getDano(cid)
    
    -- Lógica de Target vs Área
    if count > (config.shots - config.targetedShots) then
        -- Tiros que seguem o alvo
        if isCreature(targetId) then
            doTargetCombatHealth(cid, targetId, config.damageType, dano, dano, config.effect)
            doSendDistanceShoot(getThingPos(cid), getThingPos(targetId), config.distEffect)
        else
            doAreaCombatHealth(cid, config.damageType, staticPos, 0, dano, dano, config.effect)
            doSendDistanceShoot(getThingPos(cid), staticPos, config.distEffect)
        end
    else
        -- Tiros de dispersão
        local randomPos = {
            x = staticPos.x + math.random(-1, 1),
            y = staticPos.y + math.random(-1, 1),
            z = staticPos.z
        }
        doAreaCombatHealth(cid, config.damageType, randomPos, 0, dano, dano, config.effect)
        doSendDistanceShoot(getThingPos(cid), randomPos, config.distEffect)
    end

    if count > 1 then
        addEvent(executeHousenka, config.delay, cid, targetId, staticPos, count - 1)
    end
end

-- 6. Função Principal
function onCastSpell(cid, var)
    local target = getCreatureTarget(cid)
    if not isCreature(target) then
        target = variantToNumber(var)
    end

    if not isCreature(target) then
        doPlayerSendCancel(cid, "Você precisa de um alvo.")
        return false
    end

    local targetPos = getThingPos(target)
    if not targetPos then return false end
    
    -- Inicia os disparos
    executeHousenka(cid, target, targetPos, config.shots)
    return true
end