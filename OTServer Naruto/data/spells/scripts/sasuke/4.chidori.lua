-- 1. Combate para Sasuke Normal
local combatNormal = createCombatObject()
setCombatParam(combatNormal, COMBAT_PARAM_TYPE, COMBAT_RAITON_DAMAGE)
setCombatParam(combatNormal, COMBAT_PARAM_EFFECT, 11) -- Efeito 11 fixo aqui

-- 2. Combate para Sasuke Maldição
local combatCursed = createCombatObject()
setCombatParam(combatCursed, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combatCursed, COMBAT_PARAM_EFFECT, 88) -- Efeito 88 fixo aqui

-- 3. Fórmulas com nomes EXCLUSIVOS para este script
function onGetFormulaHousenkaNormal(cid, level, maglevel)
    local fist = getPlayerSkillLevel(cid, 0)
    local min = (level * 2.5) + (maglevel * 15.0) + (fist * 1.5) + 50
    local max = (level * 4.0) + (maglevel * 20.5) + (fist * 2.5) + 100
    return -min, -max
end

function onGetFormulaHousenkaCursed(cid, level, maglevel)
    local fist = getPlayerSkillLevel(cid, 0)
    local min = (level * 2.5) + (maglevel * 15.0) + (fist * 1.5) + 100
    local max = (level * 4.0) + (maglevel * 20.5) + (fist * 2.5) + 200
    return -min, -max
end

setCombatCallback(combatNormal, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaHousenkaNormal")
setCombatCallback(combatCursed, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaHousenkaCursed")

-- 4. Áreas (definidas separadamente para cada objeto)
local areaHousenka = createCombatArea({{0, 3, 0}})
setCombatArea(combatNormal, areaHousenka)
setCombatArea(combatCursed, areaHousenka)

-- 5. Função Principal
function onCastSpell(cid, var)
    local vocation = getPlayerVocation(cid)
    print(vocation)
    
    -- Executa apenas UM dos combates. O efeito visual sairá automático no alvo.
    if vocation >= 20 and vocation <= 23 then
        print("maldição!")
        return doCombat(cid, combatCursed, var)
    else
        print("normal!")
        return doCombat(cid, combatNormal, var)
    end
end