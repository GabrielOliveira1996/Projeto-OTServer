function onCastSpell(cid, var)
    -- Verifica se já tem o dodge engatilhado para não gastar mana a toa
    if getPlayerStorageValue(cid, STORAGE_SHARINGAN) > 0 then
        doPlayerSendCancel(cid, "Você já está com a percepção do Sharingan ativa.")
        return false
    end

    setPlayerStorageValue(cid, STORAGE_SHARINGAN, 1)
    doSendMagicEffect(getCreaturePosition(cid), 26) -- Efeito de ativação
    doPlayerSendTextMessage(cid, 22, "Sharingan: Percepção Ativada!")
    return true
end