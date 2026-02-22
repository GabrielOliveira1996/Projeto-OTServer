function onSay(cid, words, param)
    -- Obtendo os dados básicos
    local level = getPlayerAkamaruLevel(cid)
    local exp = getPlayerAkamaruExp(cid)
    local points = getPlayerAkamaruPoints(cid)
    
    local text = "--- [ Akamaru Status ] ---\n\n"
    text = text .. ">> Progressão\n"
    text = text .. "Nivel: " .. level .. "\n"
    text = text .. "Experiencia: " .. exp .. "\n"
    text = text .. "Pontos para Distribuir: " .. points .. "\n\n"
    
    text = text .. ">> Atributos de Combate\n"
    text = text .. "Attack (Dano): " .. getPlayerAkamaruAttack(cid) .. "\n"
    text = text .. "Agility (Velocidade): " .. getPlayerAkamaruAgility(cid) .. "\n"
    text = text .. "Dodge (Esquiva): " .. getPlayerAkamaruDodge(cid) .. "%\n"
    
    text = text .. "\n>> Atributos de Sobrevivencia\n"
    text = text .. "Vida Extra: " .. getPlayerAkamaruHealthPts(cid) .. "\n"
    
    text = text .. "\n--------------------------\n"
    text = text .. "Comandos:\n"
    text = text .. "!akamaru_add_skill attack\n"
    text = text .. "!akamaru_add_skill agility\n"
    text = text .. "!akamaru_add_skill dodge\n"
    text = text .. "!akamaru_add_skill health\n"

    doShowTextDialog(cid, 2550, text) -- Abre a janela de diálogo (ID 2550 é o Akamaru ou um ícone neutro)
    return true
end