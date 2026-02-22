local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

-- tabelo de niveis
local JUTSUS = {
    {name = "kage bunshin no jutsu", lvl = 10, spell = "kage bunshin no jutsu"},
    {name = "dai rendan",            lvl = 20, spell = "dai rendan"},
    {name = "kyuubi form I",         lvl = 30, spell = "kyuubi form i"},
    {name = "rasengan",              lvl = 40, spell = "rasengan"},
    {name = "kyuubi form II",        lvl = 50, spell = "kyuubi form ii"},
    {name = "kyuubi form III",       lvl = 70, spell = "kyuubi form iii"},
    {name = "oodama rasengan",       lvl = 80, spell = "oodama rasengan"},
    {name = "rasenshuriken",         lvl = 100, spell = "rasenshuriken"}
}

local narutoVocs = {37, 39, 40, 64, 65, 66, 67, 81}

function onGreet(cid)
    if isInArray(narutoVocs, getPlayerVocation(cid)) then
        npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|! I am here to help you. To see the jutsu list, say {teach}. For rank upgrades, ask about {training}.")
    else
        npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|. I only train Naruto ninjas.")
    end
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local msg = msg:lower()

    -- lista de itens no chat
    if msgcontains(msg, 'teach') then
        local message = "I can teach you these techniques: \n"
        for i = 1, #JUTSUS do
            local info = JUTSUS[i]
            message = message .. info.name:upper() .. " (Level " .. info.lvl .. ")" .. (i == #JUTSUS and "." or ", \n")
        end
        selfSay(message, cid)
        selfSay("To learn one, just say 'learn' and the name.", cid)

    -- aprendizado
    elseif msgcontains(msg, 'learn') then
        local found = false
        for i = 1, #JUTSUS do
            local info = JUTSUS[i]
            if msgcontains(msg, info.name) then
                found = true
                if getPlayerLevel(cid) < info.lvl then
                    selfSay("You need level " .. info.lvl .. " to learn this jutsu.", cid)
                elseif getPlayerLearnedInstantSpell(cid, info.spell) then
                    selfSay("You already know this technique.", cid)
                else
                    doPlayerLearnInstantSpell(cid, info.spell)
                    doSendMagicEffect(getThingPos(cid), 12)
                    selfSay("Great! You have mastered " .. info.name:upper() .. "!", cid)
                end
                break
            end
        end
        if not found then
            selfSay("I don't know that jutsu. Check the list by saying {teach}.", cid)
        end

    -- treinamentos
    elseif msgcontains(msg, 'training') then
        selfSay("I offer two stages: {shippuden training} (Lv 90) and {third training} (Lv 170).", cid)

    elseif msgcontains(msg, 'shippuden training') then
        if getPlayerVocation(cid) == 37 and getPlayerLevel(cid) >= 90 then
            doPlayerSetVocation(cid, 39)
            setPlayerStorageValue(cid, 20002, 1)
            doSendMagicEffect(getThingPos(cid), 12)
            selfSay("Your training is complete! You are now a Shippuden Ninja.", cid)
        else
            selfSay("You are not ready yet. Come back when you are level 90.", cid)
        end

    elseif msgcontains(msg, 'third training') then
        if getPlayerVocation(cid) == 39 and getPlayerLevel(cid) >= 170 then
            doPlayerSetVocation(cid, 40)
            doSendMagicEffect(getThingPos(cid), 12)
            selfSay("Incredible! You have reached the final stage of training!", cid)
        else
            selfSay("This training is only for level 170+ Shippuden Ninjas.", cid)
        end
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())