function onCastSpell(cid, var)
    local cooldownStorage = 23005 
    local cooldownTime = 2

    if getPlayerStorageValue(cid, cooldownStorage) > os.time() then
        local remaining = getPlayerStorageValue(cid, cooldownStorage) - os.time()
        doPlayerSendCancel(cid, "Your scent sense is tired. Wait " .. remaining .. "s.")
        return false
    end

    local targetName = variantToName(var)
    local target = getPlayerByName(targetName)

    if not target then
        doPlayerSendCancel(cid, "Kiba cannot pick up the scent of " .. targetName .. ".")
        return false
    end

    if target == cid then
        doPlayerSendCancel(cid, "You are smelling yourself... clearly.")
        return false
    end

    local pPos = getThingPos(cid)
    local tPos = getThingPos(target)

    local msg = ""
    if pPos.z > tPos.z then
        msg = targetName .. " is on a floor above."
    elseif pPos.z < tPos.z then
        msg = targetName .. " is on a floor below."
    else
        local dist = getDistanceBetween(pPos, tPos)
        local dir = ""

        if tPos.y < pPos.y then dir = "north"
        elseif tPos.y > pPos.y then dir = "south" end

        if tPos.x < pPos.x then dir = dir .. "west"
        elseif tPos.x > pPos.x then dir = dir .. "east" end

        if dir == "" then dir = "standing next to you" else dir = "to the " .. dir end
        
        local intensity = ""
        if dist < 5 then intensity = "very strong"
        elseif dist < 50 then intensity = "strong"
        elseif dist < 200 then intensity = "weak"
        else intensity = "very weak" end

        msg = targetName .. "'s scent is " .. intensity .. ", coming from the " .. dir .. "."
    end

    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, msg)
    doSendMagicEffect(getThingPos(cid), 14) 
    setPlayerStorageValue(cid, cooldownStorage, os.time() + cooldownTime)

    return true
end