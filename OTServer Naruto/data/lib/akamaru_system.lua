AKAMARU_OPCODE = 101 

function doUpdateAkamaruClient(cid)
    if not isPlayer(cid) then return false end

    local data = {
        getPlayerAkamaruLevel(cid) or 0,        -- [1]
        getPlayerAkamaruExp(cid) or 0,          -- [2]
        getPlayerAkamaruNextLevelExp(cid) or 0, -- [3]
        getPlayerAkamaruPoints(cid) or 0,       -- [4]
        getPlayerAkamaruAttack(cid) or 0,       -- [5]
        getPlayerAkamaruAgility(cid) or 0,      -- [6]
        getPlayerAkamaruDodge(cid) or 0,        -- [7]
        getPlayerAkamaruHealthPts(cid) or 0,    -- [8]
        getPlayerAkamaruMaxHealth(cid) or 0,    -- [9]
        getPlayerAkamaruSpeedPts(cid) or 0,     -- [10]
        getPlayerAkamaruMaxSpeed(cid) or 0      -- [11]
    }
    
    local protocol = table.concat(data, "|")

    doSendPlayerExtendedOpcode(cid, AKAMARU_OPCODE, protocol)
    addEvent(doUpdateAkamaruClient, 2000, cid)
    return true
end