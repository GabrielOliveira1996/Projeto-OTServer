local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_KATON_DAMAGE)

local condition = createConditionObject(CONDITION_FIRE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 3000) 
setConditionParam(condition, CONDITION_PARAM_DRANKTIK, 1000) 
setConditionParam(condition, CONDITION_PARAM_OFFICKEFFECT, 15) 
setConditionParam(condition, CONDITION_PARAM_MINVALUE, -100) 
setConditionParam(condition, CONDITION_PARAM_MAXVALUE, -200) 
setCombatCondition(combat, condition)

-- formula de dano
function onGetFormulaValues(cid, level, maglevel)
    local min = (level * 2.5) + (maglevel * 4.5)
    local max = (level * 3.5) + (maglevel * 5.5)
    return -min, -max
end
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

-- areas da explosao
local area_centro = { {x=0, y=0} }
local area_3x3 = {
    {x=-1, y=-1}, {x=0, y=-1}, {x=1, y=-1},
    {x=-1, y=0},  {x=0, y=0},  {x=1, y=0},
    {x=-1, y=1},  {x=0, y=1},  {x=1, y=1}
}

-- funcao que executa o dano na area
local function applyDamage(cid, pos, area)
    if not isCreature(cid) then return end
    doSendMagicEffect(pos, 15) -- efeito de fogo da explosao
    for _, offset in ipairs(area) do
        local targetPos = {x = pos.x + offset.x, y = pos.y + offset.y, z = pos.z}
        doCombatAreaHealth(cid, COMBAT_KATON_DAMAGE, targetPos, 0, 0, 0, 15) -- apenas efeito visual extra
        -- aplicar o combate com a condicao de fogo e formula
        local var = {pos = targetPos, type = 2}
        doCombat(cid, combat, var)
    end
end

-- funcao da explosao final
local function executeExplosion(cid, pos)
    if not isCreature(cid) then return end
    applyDamage(cid, pos, area_centro) -- primeiro no centro
    addEvent(applyDamage, 300, cid, pos, area_3x3) -- depois espalha 3x3
end

-- funcao do projetil
local function moveKaton(cid, currentPos, look, steps)
    if not isCreature(cid) then return end

    -- se colidir com criatura, explode
    local target = getTopCreature(currentPos).uid
    if isCreature(target) and target ~= cid then
        executeExplosion(cid, currentPos)
        return
    end

    -- se acabar o range, explode
    if steps <= 0 then
        executeExplosion(cid, currentPos)
        return
    end

    local nextPos = {x = currentPos.x, y = currentPos.y, z = currentPos.z}
    if look == 0 then nextPos.y = nextPos.y - 1
    elseif look == 1 then nextPos.x = nextPos.x + 1
    elseif look == 2 then nextPos.y = nextPos.y + 1
    elseif look == 3 then nextPos.x = nextPos.x - 1
    end

    -- se colidir com obstaculo, explode na posição atual
    if doTileQueryAdd(cid, nextPos) ~= RETURNVALUE_NOERROR and not isCreature(getTopCreature(nextPos).uid) then
        executeExplosion(cid, currentPos)
        return
    end

    -- envia o efeito de avanco
    doSendMagicEffect(nextPos, 15)
    addEvent(moveKaton, 100, cid, nextPos, look, steps - 1)
end

function onCastSpell(cid, var)
    local p = getCreaturePosition(cid)
    local look = getCreatureLookDirection(cid)
    -- inicia o movimento a partir da frente do player
    local startPos = {x=p.x, y=p.y, z=p.z}
    moveKaton(cid, startPos, look, 5) -- range de 5 sqms
    return true
end