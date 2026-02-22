local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_LIFEDRAIN)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
-- ainda não está lendo o xml attk, corrigir.
function onUseWeapon(cid, var)
    -- pega o skill de fist e o ataque da arma na mão
    local skill = getPlayerSkillLevel(cid, SKILL_FIST)
    local weapon = getPlayerSlotItem(cid, CONST_SLOT_LEFT) -- pega o item da mao
    local atk = getItemAttribute(weapon.uid, "attack") or 20 -- padrao 20 se nao ler do XML
    
    local min = (skill * 0.5) + (atk * 0.2)
    local max = (skill * 0.8) + (atk * 0.4)
    
    local damage = math.random(math.floor(min), math.floor(max))
    local percentage = 0.1 -- 10%

    local target = variantToNumber(var)
    if isCreature(target) then
        -- causa o dano de dreno no alvo
        doTargetCombatHealth(cid, target, COMBAT_LIFEDRAIN, -damage, -damage, CONST_ME_MAGIC_RED)
        
        -- cura o usuario apenas a porcentagem definida
        local heal = math.floor(damage * percentage)
        if heal > 0 then
            doCreatureAddHealth(cid, heal)
            doSendMagicEffect(getCreaturePos(cid), CONST_ME_MAGIC_BLUE) -- efeito visual de cura no player
        end
        return true
    end
    return false
end