local BYA_STORAGE = 45001
local INVUL_STORAGE = 45002 
local cooldownStorage = 23002
local cooldownTime = 5

local bosses_nao_empurraveis = {"Trainer"}

local function pushTarget(cid, target)
    if not isCreature(cid) or not isCreature(target) then return end
    
    local targetName = getCreatureName(target)
    for _, name in ipairs(bosses_nao_empurraveis) do
        if targetName:lower() == name:lower() then
            return false 
        end
    end

    local posCid = getThingPos(cid)
    local posTarget = getThingPos(target)
    
    local nx = posTarget.x > posCid.x and 1 or (posTarget.x < posCid.x and -1 or 0)
    local ny = posTarget.y > posCid.y and 1 or (posTarget.y < posCid.y and -1 or 0)
    
    local toPos = {x = posTarget.x + nx, y = posTarget.y + ny, z = posTarget.z}
    
    if isWalkable(toPos) then
        doTeleportThing(target, toPos, true)
        doSendMagicEffect(toPos, 43) 
    end
end

function isWalkable(pos)
    if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then return false end
    if getTileInfo(pos).protection then return false end
    if doTileQueryAdd(getPlayersOnline()[1], pos) ~= RETURNVALUE_NOERROR then return false end
    return true
end

function onCastSpell(cid, var)
    if os.time() < getPlayerStorageValue(cid, cooldownStorage) then
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false
    end

    local hits = 10 
    local skill = getPlayerSkillLevel(cid, 6)
    local level = getPlayerLevel(cid)
    local isByakugan = getPlayerStorageValue(cid, BYA_STORAGE) > 0

    doCreatureSetNoMove(cid, true)
    setPlayerStorageValue(cid, INVUL_STORAGE, os.time() + 3) 
    
    local pos = getThingPos(cid)
    doSendMagicEffect({x = pos.x + 1, y = pos.y + 1, z = pos.z}, 82)

    for i = 1, hits do
        addEvent(function()
            if isCreature(cid) then
                local currentPos = getThingPos(cid)
                local min = (skill * 0.1) + (level * 0.1)
                local max = (skill * 0.3) + (level * 0.3)
                
                if isByakugan then 
                    min = (skill * 0.3) + (level * 0.3)
                    max = (skill * 0.6) + (level * 0.6)
                end 

                local targets = getCreaturesInRange(currentPos, 1, 1, true, true)
                for _, target in ipairs(targets) do
                    if isCreature(target) and target ~= cid then
                        doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -min, -max, 1)
                        
                        if i == hits then
                            pushTarget(cid, target)
                        end
                    end
                end
            end
        end, i * 200) 
    end

    addEvent(function()
        if isCreature(cid) then doCreatureSetNoMove(cid, false) end
    end, 2000)

    setPlayerStorageValue(cid, cooldownStorage, os.time() + cooldownTime)
    return true
end

function getCreaturesInRange(pos, radiusX, radiusY, showMonsters, showPlayers)
    local creatures = {}
    for x = -radiusX, radiusX do
        for y = -radiusY, radiusY do
            local m = getTopCreature({x=pos.x+x, y=pos.y+y, z=pos.z}).uid
            if isCreature(m) then
                if (isMonster(m) and showMonsters) or (isPlayer(m) and showPlayers) then
                    table.insert(creatures, m)
                end
            end
        end
    end
    return creatures
end