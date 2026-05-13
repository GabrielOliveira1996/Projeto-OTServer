function onUse(cid, item, fromPosition, itemEx, toPosition)
    local titulo = "Escrituras dos Elementos"
    local mensagem = "No principio, o Fogo consumiu o vazio. O calor gerou o Vento, que soprou as cinzas. Das nuvens negras, o Relampago castigou o solo, moldando a Terra firme. Por fim, as lagrimas do ceu trouxeram a Agua, acalmando a furia da criacao."

    doShowTextDialog(cid, item.itemid, mensagem)
    --doSendMagicEffect(getThingPos(item.uid), 27) 
    return true
end