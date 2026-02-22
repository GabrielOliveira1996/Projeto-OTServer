-- As condições devem ser criadas fora das funções principais
local chakra_bonus = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(chakra_bonus, CONDITION_PARAM_TICKS, -1) -- Bonus infinito enquanto estiver equipado
setConditionParam(chakra_bonus, CONDITION_PARAM_SKILL_FISHING, 10) -- Altera o bônus para o valor desejado
setConditionParam(chakra_bonus, CONDITION_PARAM_SUBID, 100) -- ID único para não conflitar com outros itens

function onEquip(cid, item, slot)
    doAddCondition(cid, chakra_bonus)
    doPlayerSendTextMessage(cid, 22, "You have equipped the Classic Sakura Shirt. Your Chakra Control has increased!")
    return true
end

function onDeEquip(cid, item, slot)
    doRemoveCondition(cid, CONDITION_ATTRIBUTES, 100) -- Remove a condição pelo SUBID 100
    doPlayerSendTextMessage(cid, 22, "You have removed the Classic Sakura Shirt.")
    return true
end