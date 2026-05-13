local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FUUTON_DAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 4)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 16)

local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_FUUTON_DAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 103)
setCombatParam(combat1, COMBAT_PARAM_HITCOLOR, 186)

-- FÓRMULA DE DANO PARA COMBAT (Vocações Iniciais/Sennin)
function onGetFormulaValues(cid, level, maglevel)
    local fist = getPlayerSkillLevel(cid, 0) -- 0 é Fist Skill
    -- Adicionado (fist * 2.0) no min e (fist * 3.5) no max
    local min = (level * 2.5) + (maglevel * 15.0) + (fist * 1.5) + 50
    local max = (level * 4.0) + (maglevel * 20.5) + (fist * 2.5) + 100
    return -min, -max
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

-- FÓRMULA DE DANO PARA COMBAT1 (Vocações Avançadas)
function onGetFormulaValues1(cid, level, maglevel)
    local fist = getPlayerSkillLevel(cid, 0) -- 0 é Fist Skill
    -- Adicionado (fist * 3.0) no min e (fist * 4.5) no max
    local min = (level * 2.5) + (maglevel * 15.0) + (fist * 1.5) + 100
    local max = (level * 4.0) + (maglevel * 20.5) + (fist * 2.5) + 200
    return -min, -max
end
setCombatCallback(combat1, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")

-- Áreas
local area = createCombatArea({{0, 3, 0}})
setCombatArea(combat, area)

local area1 = createCombatArea({{0, 3, 0}})
setCombatArea(combat1, area1)

function onCastSpell(cid, var)
    local vocation = getPlayerVocation(cid)
    local voc_sennin = 11
    local voc_kyuubi_sennin = 12
    local voc_kyuubi_sennin_kage = 13
    local custo_soul = 5
    local sanin_mode_check = (vocation == voc_sennin or vocation == voc_kyuubi_sennin or vocation == voc_kyuubi_sennin_kage)

    -- Quarta cauda não permite usar esse jutsu
    if vocation == 9 then
        doPlayerSendCancel(cid, "Esta forma não permite o uso deste jutsu.")
        doSendMagicEffect(getThingPos(cid), 2)
        return false
    end

    -- Verifica Soul (Energia da Natureza)
    if sanin_mode_check then
        if getPlayerSoul(cid) < custo_soul then
            doPlayerSendCancel(cid, "Você precisa de pelo menos " .. custo_soul .. " Energia da Natureza.")
            doSendMagicEffect(getThingPos(cid), 2)
            return false
        end
        doPlayerAddSoul(cid, -custo_soul)
        doSendMagicEffect(getThingPos(cid), 13)
    end

    -- Execução conforme a vocação
    if (vocation >= 1 and vocation <= 4) or sanin_mode_check then
        return doCombat(cid, combat, var)
    else
        return doCombat(cid, combat1, var)
    end
end