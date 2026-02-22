function onSay(cid, words, param)
    local points = getPlayerAkamaruPoints(cid)
    local param = param:lower()

    if points <= 0 then
        doPlayerSendCancel(cid, "Voce nao tem pontos de Akamaru disponiveis.")
        return true
    end

    if param == "attack" then
        setPlayerAkamaruAttack(cid, getPlayerAkamaruAttack(cid) + 1)
        setPlayerAkamaruPoints(cid, points - 1)
        doPlayerSendTextMessage(cid, MSG_STATUS_CONSOLE_ORANGE, "Akamaru: +1 Attack!")
    elseif param == "agility" then
        setPlayerAkamaruAgility(cid, getPlayerAkamaruAgility(cid) + 1)
        setPlayerAkamaruPoints(cid, points - 1)
        doPlayerSendTextMessage(cid, MSG_STATUS_CONSOLE_ORANGE, "Akamaru: +1 Agility!")
    elseif param == "dodge" then
        setPlayerAkamaruDodge(cid, getPlayerAkamaruDodge(cid) + 1)
        setPlayerAkamaruPoints(cid, points - 1)
        doPlayerSendTextMessage(cid, MSG_STATUS_CONSOLE_ORANGE, "Akamaru: +1 Dodge!")
    else
        doPlayerSendCancel(cid, "Use: !akamaru add attack, !akamaru add agility ou !akamaru add dodge.")
    end

    return true
end