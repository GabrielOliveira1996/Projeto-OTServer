local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

-- Tabela de Jutsus do Kiba
local JUTSUS = {
    {name = "akamaru",           lvl = 0,   spell = "Akamaru"},
    {name = "tsuuga",            lvl = 10,  spell = "Tsuuga"},
    {name = "juujin bunshin",    lvl = 20,  spell = "Juujin Bunshin"},
    {name = "kizu",              lvl = 30,  spell = "Kizu"},
    {name = "gatsuuga",          lvl = 40,  spell = "Gatsuuga"},
    {name = "tsuigeki no ko",    lvl = 50,  spell = "Tsuigeki No Ko"},
    {name = "shikyaku no jutsu", lvl = 60,  spell = "Shikyaku No Jutsu"},
    {name = "garouga",           lvl = 70,  spell = "Garouga"}
}

-- IDs das vocações do Kiba (conforme seu XML)
local kibaVocs = {9, 10, 11}

function onGreet(cid)
    if isInArray(kibaVocs, getPlayerVocation(cid)) then
        npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|! Ready to hunt? I can {teach} you Inuzuka techniques or help with your {training} stages.")
    else
        npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|. I only train members of the Inuzuka clan.")
    end
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local msg = msg:lower()

    -- Lista de Jutsus
    if msgcontains(msg, 'teach') then
        local message = "I can teach you these techniques: \n"
        for i = 1, #JUTSUS do
            local info = JUTSUS[i]
            message = message .. info.name:upper() .. " (Level " .. info.lvl .. ")" .. (i == #JUTSUS and "." or ", \n")
        end
        selfSay(message, cid)
        selfSay("To learn one, say 'learn' and the name of the jutsu.", cid)

    -- Aprendizado
    elseif msgcontains(msg, 'learn') then
        local found = false
        for i = 1, #JUTSUS do
            local info = JUTSUS[i]
            if msgcontains(msg, info.name) then
                found = true
                if getPlayerLevel(cid) < info.lvl then
                    selfSay("You need level " .. info.lvl .. " to master this technique.", cid)
                elseif getPlayerLearnedInstantSpell(cid, info.spell) then
                    selfSay("You and Akamaru already know how to do that.", cid)
                else
                    doPlayerLearnInstantSpell(cid, info.spell)
                    doSendMagicEffect(getThingPos(cid), 14) -- Efeito de faro/impacto
                    selfSay("Excellent! You have mastered " .. info.name:upper() .. "!", cid)
                end
                break
            end
        end
        if not found then
            selfSay("I've never heard of that jutsu. Check the list by saying {teach}.", cid)
        end

    -- Evolução de Vocação (Training)
    elseif msgcontains(msg, 'training') then
        selfSay("I can guide you through: {shippuden training} (Lv 90) and {ultimate training} (Lv 170).", cid)

    elseif msgcontains(msg, 'shippuden training') then
        if getPlayerVocation(cid) == 9 and getPlayerLevel(cid) >= 90 then
            doPlayerSetVocation(cid, 10)
            doSendMagicEffect(getThingPos(cid), 14)
            selfSay("Your bond with Akamaru has grown! You are now a Shippuden Inuzuka.", cid)
        else
            selfSay("You aren't ready. You need level 90 and be in your first form.", cid)
        end

    elseif msgcontains(msg, 'ultimate training') then
        if getPlayerVocation(cid) == 10 and getPlayerLevel(cid) >= 170 then
            doPlayerSetVocation(cid, 11)
            doSendMagicEffect(getThingPos(cid), 14)
            selfSay("Incredible! You have reached the peak of the Inuzuka Clan training!", cid)
        else
            selfSay("This is only for level 170+ Shippuden Inuzukas.", cid)
        end
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())