local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	
	-- Bruce lutará novamente o jogador que o derrotar? [true/false]
	local fight_again = true	
	
	if msgcontains(msg, "desafio") then
		if fight_again and getPlayerStorageValue(cid, 69508) < os.time() then
			selfSay("Então você quer me desafiar para um duelo? HA, prepare-se para morrer!")
			local pos = getThingPos(getNpcCid())
			local summonName = getCreatureName(getNpcCid())
			local lookdir = getCreatureLookDirection(cid)
			doRemoveCreature(getNpcCid())
			local summonCid = doCreateMonster(summonName, pos)
			doCreatureSetLookDirection(summonCid, lookdir)
			addEvent(checkForBruce, 5000, summonName)
		else
			selfSay("Ah, sinto muito, mas não estou pronto para uma nova luta com você.", cid)
		end
	end
	return true	
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

function checkForBruce(name)
	local Bruce = isCreature(getCreatureByName("Mizuki1")) and getCreatureByName("Mizuki1") or false
	if isNpc(Bruce) then
		return false
	end
	if not Bruce then
		Bruce = isCreature(getCreatureByName("Mizuki2")) and getCreatureByName("Mizuki2") or Bruce
	end
	if isCreature(getCreatureTarget(Bruce)) then
		addEvent(checkForBruce, 5000, name)
		return true
	else
		local pos = getThingPos(Bruce)
		doRemoveCreature(Bruce)
		doCreateNpc(name, pos)
	end
end