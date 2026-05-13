local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_KATON_DAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 15) -- Efeito de fogo atingindo o alvo
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 33) -- Efeito da bola de fogo voando

-- Formula de dano baseada no level e magic level
function getFormula(cid, lv, mag)
    local min = (lv * 0.5) + (mag * 0.8) + 10
    local max = (lv * 0.8) + (mag * 1.2) + 20
    return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "getFormula")

-- Função para disparar múltiplos tiros
local function executeSpell(cid, var, count)
    if not isCreature(cid) then return end
    
    -- Se o alvo sumir ou morrer, para de atirar
    local target = variantToNumber(var)
    if target > 0 and not isCreature(target) then return end

    doCombat(cid, combat, var)
    
    if count > 1 then
        addEvent(executeSpell, 200, cid, var, count - 1)
    end
end

function onCastSpell(cid, var)
    -- Dispara 5 bolas de fogo com intervalo de 200ms
    executeSpell(cid, var, 5)
    return true
end