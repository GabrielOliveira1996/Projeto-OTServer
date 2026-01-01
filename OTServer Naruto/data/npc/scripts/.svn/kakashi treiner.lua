local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

if getPlayerVocation(cid) == 39 or getPlayerVocation(cid) == 40 then

local node1 = keywordHandler:addKeyword({'primeiro treinamento'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Para receber esse treinamento você prescisa ter o level 50, você esta possui esse level?'})
node1:addChildKeyword({'yes'}, StdModule.promotePlayer, {npcHandler = npcHandler, cost = 0, level = 50, promotion = 1, text = 'Você se saiu bem no treinamento, vejo que você esta mais forte.'})
node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Você ainda não esta preparado para esse tipo de treinamento.', reset = true})
end

if getPlayerVocation(cid) == 39 or getPlayerVocation(cid) == 40 then

local node2 = keywordHandler:addKeyword({'segundo treinamento'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Para receber esse treinamento você prescisa ter o level 150, você esta possui esse level?'})
node2:addChildKeyword({'yes'}, StdModule.promotePlayer, {npcHandler = npcHandler, cost = 0, level = 150, promotion = 2, text = 'Parabêns você esta mais forte.'})
node2:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Você ainda não esta preparado para esse tipo de treinamento.', reset = true})
end

if getPlayerVocation(cid) == 39 or getPlayerVocation(cid) == 40 then

local node3 = keywordHandler:addKeyword({'terceiro treinamento'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Para receber esse treinamento você prescisa ter o level 300, você esta possui esse level?'})
node3:addChildKeyword({'yes'}, StdModule.promotePlayer, {npcHandler = npcHandler, cost = 0, level = 300, promotion = 3, text = 'Sua forta está ao extremo, o poder esta a te cosumir.'})
node3:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Você ainda não esta preparado para esse tipo de treinamento.', reset = true})
end

if getPlayerVocation(cid) == 67 or getPlayerVocation(cid) == 68 then
doPlayerSendTextMessage(cid, 23, "Voce nao tem a vocaçao necessaria!.")
end
return true
end

npcHandler:addModule(FocusModule:new())