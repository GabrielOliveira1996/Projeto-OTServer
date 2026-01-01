local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local node1 = keywordHandler:addKeyword({'shippuden'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Voce deseja ficarmais forte? prescisa do level 300.'})
	node1:addChildKeyword({'yes'}, StdModule.promotePlayer, {npcHandler = npcHandler, cost = 0, level = 300, promotion = 3, text = 'Agora voce esta mais forte...'})
	node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Volte quando voce setiver pronto.', reset = true})

npcHandler:addModule(FocusModule:new())
