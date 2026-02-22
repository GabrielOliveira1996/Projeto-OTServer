function onStepIn(cid, item, position, fromPosition)
    -- verifica se é um jogador.
    if not isPlayer(cid) then
        return true
    end
    -- verifica se o item que está pisando possui o id.
    if item.itemid == 4825 then
        if getCreatureMana(cid) >= 10 then
            -- adiciona progresso na skill 6.
            doPlayerAddSkillTry(cid, 6, 1)
            -- remove a mana.
            doCreatureAddMana(cid, -20)
            -- efeito visual na posição do jogador
            doSendMagicEffect(getThingPos(cid), 1)
        else
            -- mensagem caso não tenha chakra.
            doPlayerSendCancel(cid, "You don't have enough chakra.")
        end
    end
    return true
end