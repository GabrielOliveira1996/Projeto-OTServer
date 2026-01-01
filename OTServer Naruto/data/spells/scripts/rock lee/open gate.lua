function onCastSpell(cid, var)

    local outfit1 = 372
    local skill1 = 2
    local outfit2 = 371
    local outfit3 = 165
    local outfit4 = 167
    local outfit5 = 167

    if getPlayerLevel(cid) >= 40 and getPlayerLevel(cid) <= 149 then
        doSetCreatureOutfit(cid, {lookType = outfit1}, -1)
        doPlayerSetVocation(cid, 70)
        doSendMagicEffect(getCreaturePosition(cid), 90)
        doCreatureSay(cid, "KAIMON", TALKTYPE_MONSTER)
    end

    if getPlayerLevel(cid) >= 80 and getPlayerLevel(cid) <= 149 then
        doSetCreatureOutfit(cid, {lookType = outfit2}, -1)
        doPlayerSetVocation(cid, 71)
        doSendMagicEffect(getCreaturePosition(cid), 90)
        doCreatureSay(cid, "KYUMON", TALKTYPE_MONSTER)
    end

    if getPlayerLevel(cid) >= 120 and getPlayerLevel(cid) <= 149 then
        doSetCreatureOutfit(cid, {lookType = outfit3}, -1)
        doPlayerSetVocation(cid, 72)
        doSendMagicEffect(getCreaturePosition(cid), 90)
        doCreatureSay(cid, "SEIMON", TALKTYPE_MONSTER)
    end

    if getPlayerLevel(cid) >= 250 and getPlayerLevel(cid) <= 319 and getPlayerStorageValue(cid, 20003) == 1 then
        doSetCreatureOutfit(cid, {lookType = outfit4}, -1)
        doPlayerSetVocation(cid, 73)
        doSendMagicEffect(getCreaturePosition(cid), 90)
        doCreatureSay(cid, "SHOMON", TALKTYPE_MONSTER)
    end

    if getPlayerLevel(cid) >= 400 and getPlayerLevel(cid) <= 449 then
        doSetCreatureOutfit(cid, {lookType = outfit5}, -1)
        doPlayerSetVocation(cid, 82)
        doSendMagicEffect(getCreaturePosition(cid), 90)
        doCreatureSay(cid, "TOMON", TALKTYPE_MONSTER)
    return true
    end
end