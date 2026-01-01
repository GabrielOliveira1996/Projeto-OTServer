function onCastSpell(cid, var)
    local playerLevel = getPlayerLevel(cid) 
    local lookTypeOneTailedKyuubi = 354
    local vocationOneTailedKyuubi = 64
    local lookTypeTwoTailedKyuubi = 354
    local vocationTwoTailedKyuubi = 65
    local lookTypeThreeTailedKyuubi = 354
    local vocationThreeTailedKyuubi = 66
    
    if playerLevel >= 30 and playerLevel <= 49 and getPlayerVocation(cid) == 37 then
        kyuubiTransform(cid, lookTypeOneTailedKyuubi, vocationOneTailedKyuubi)
    elseif playerLevel >= 50 and playerLevel <= 69 and getPlayerVocation(cid) == 37 then
        kyuubiTransform(cid, lookTypeTwoTailedKyuubi, vocationTwoTailedKyuubi)
    elseif playerLevel >= 70 and playerLevel <= 89 then
        kyuubiTransform(cid, lookTypeThreeTailedKyuubi, vocationThreeTailedKyuubi)
    elseif playerLevel >= 160 and playerLevel <= 319 and getPlayerVocation(cid) == 37 then
        kyuubiTransform(cid, 357, 67)
    elseif playerLevel >= 400 and playerLevel <= 449 then
        kyuubiTransform(cid, 383, 81)
    elseif getPlayerVocation(cid) == 64 or getPlayerVocation(cid) == 65 or getPlayerVocation(cid) == 66 then
        kyuubiRevert(cid, 352, 37)
    end
end

function kyuubiTransform(cid, lookType, vocation)
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 73)
    doChangeSpeed(cid, 300)
    summons = getCreatureSummons(cid)
    if summons then
        for _, summon in pairs(summons) do
            doSendMagicEffect(getThingPos(summon), 73)
            doRemoveCreature(summon)
        end
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, "The chakra from the Kyuubi's form destroyed his Bunshins.")
    end
end

function kyuubiRevert(cid, lookType, vocation)
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 73)
    doChangeSpeed(cid, -300)
end


