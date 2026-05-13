local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

-- jutsus da hinata
local JUTSUS = {
    {name = "byakugan",          lvl = 10,  spell = "Byakugan"},
    {name = "hakke kusho",       lvl = 30,  spell = "Hakke Kusho"},
    {name = "juken",             lvl = 40,  spell = "Juken"},
    {name = "shugohakke",        lvl = 60,  spell = "Shugohakke"},
    {name = "hakke sanjuni sho", lvl = 100, spell = "Hakke Sanjuni Sho"},
    {name = "jusho soshiken",    lvl = 140, spell = "Jusho Soshiken"}
}

-- ids das vocações da hinata
local hinataVocs = {53, 54, 55, 56}

function onGreet(cid)
    if isInArray(hinataVocs, getPlayerVocation(cid)) then
        npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|. My Byakugan sees your potential. I can {teach} you the Hyuuga arts or help with your {training} stages.")
    else
        npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|. I can only train members of the Hyuuga clan.")
    end
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local msg = msg:lower()

    -- lista de Jutsus
    if msgcontains(msg, 'teach') then
        local message = "I can teach you these techniques: \n"
        for i = 1, #JUTSUS do
            local info = JUTSUS[i]
            message = message .. info.name:upper() .. " (Level " .. info.lvl .. ")" .. (i == #JUTSUS and "." or ", \n")
        end
        selfSay(message, cid)
        selfSay("To learn one, say 'learn' and the name of the jutsu.", cid)

    -- aprendizado
    elseif msgcontains(msg, 'learn') then
        local found = false
        for i = 1, #JUTSUS do
            local info = JUTSUS[i]
            if msgcontains(msg, info.name) then
                found = true
                if getPlayerLevel(cid) < info.lvl then
                    selfSay("You need level " .. info.lvl .. " to master this technique.", cid)
                elseif getPlayerLearnedInstantSpell(cid, info.spell) then
                    selfSay("You already mastered the " .. info.name:upper() .. ".", cid)
                else
                    doPlayerLearnInstantSpell(cid, info.spell)
                    doSendMagicEffect(getThingPos(cid), 24) 
                    selfSay("Excellent! You have mastered " .. info.name:upper() .. "!", cid)
                end
                break
            end
        end
        if not found then
            selfSay("This technique does not belong to the Gentle Fist style. Say {teach} to see the list.", cid)
        end

    elseif msgcontains(msg, 'training') then
        selfSay("I can guide you through: {shippuden training} (Lv 90) and {ultimate training} (Lv 170).", cid)

    elseif msgcontains(msg, 'shippuden training') then
        if (getPlayerVocation(cid) == 53 or getPlayerVocation(cid) == 54) and getPlayerLevel(cid) >= 90 then
            doPlayerSetVocation(cid, 55)
            doSendMagicEffect(getThingPos(cid), 24)
            selfSay("Your chakra control is impressive. You are now a Hinata Shippuden!", cid)
        else
            selfSay("You aren't ready. You need level 90 and be a Shippuden.", cid)
        end

    elseif msgcontains(msg, 'ultimate training') then
        if getPlayerVocation(cid) == 55 and getPlayerLevel(cid) >= 170 then
            doPlayerSetVocation(cid, 56)
            doSendMagicEffect(getThingPos(cid), 24)
            selfSay("Incredible! Your Byakugan has reached its peak. You are a Master Hyuuga!", cid)
        else
            selfSay("This is only for level 170+ Shippuden Hyuugas.", cid)
        end
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())