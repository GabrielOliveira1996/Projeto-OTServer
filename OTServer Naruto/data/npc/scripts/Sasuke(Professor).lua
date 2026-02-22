local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

-- Sasuke Jutsu Table
local JUTSUS = {
    {name = "katon daiendan no jutsu", lvl = 10, spell = "katon daiendan no jutsu"},
    {name = "sharingan",               lvl = 20, spell = "sharingan"},
    {name = "cursed seal i",           lvl = 30, spell = "cursed seal i"},
    {name = "chidori",                 lvl = 40, spell = "chidori"},
    {name = "katon ryuuka",            lvl = 60, spell = "katon ryuuka"},
    {name = "chidori nagashi",         lvl = 100, spell = "chidori nagashi"},
    {name = "kirin",                   lvl = 150, spell = "kirin"},
    {name = "amaterasu",               lvl = 180, spell = "amaterasu"},
    {name = "susanoo",                 lvl = 180, spell = "susanoo"}
}

local sasukeVocs = {33, 35, 36, 92, 61, 62, 63}

function onGreet(cid)
    if isInArray(sasukeVocs, getPlayerVocation(cid)) then
        npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|! I am the master of the Uchiha clan. Say {teach} to see the jutsus or {training} to upgrade your rank.")
    else
        npcHandler:setMessage(MESSAGE_GREET, "I don't waste time with those who lack the Sharingan. Leave.")
        return false
    end
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local msg = msg:lower()

    -- JUTSU LIST
    if msgcontains(msg, 'teach') then
        local message = "I can teach you these techniques: \n"
        for i = 1, #JUTSUS do
            local info = JUTSUS[i]
            message = message .. info.name:upper() .. " (Level " .. info.lvl .. ")" .. (i == #JUTSUS and "." or ", \n")
        end
        selfSay(message, cid)
        selfSay("To learn one, just say 'learn' and the name of the jutsu.", cid)

    -- LEARNING SPELLS
    elseif msgcontains(msg, 'learn') then
        local found = false
        for i = 1, #JUTSUS do
            local info = JUTSUS[i]
            if msgcontains(msg, info.name) then
                found = true
                if getPlayerLevel(cid) < info.lvl then
                    selfSay("You lack enough hatred. You need level " .. info.lvl .. " to learn this.", cid)
                elseif getPlayerLearnedInstantSpell(cid, info.spell) then
                    selfSay("You have already mastered this technique.", cid)
                else
                    doPlayerLearnInstantSpell(cid, info.spell)
                    doSendMagicEffect(getThingPos(cid), 10) -- efeito de aprendizado
                    selfSay("Excellent. You have learned " .. info.name:upper() .. "!", cid)
                end
                break
            end
        end
        if not found then
            selfSay("I don't know that jutsu. Check the list by saying {teach}.", cid)
        end

    -- treinamentos
    elseif msgcontains(msg, 'training') then
        selfSay("I can take you to the next level: {shippuden training} (Lv 90) or {third training} (Lv 170).", cid)

    elseif msgcontains(msg, 'shippuden training') then
        if getPlayerVocation(cid) == 33 and getPlayerLevel(cid) >= 90 then
            doPlayerSetVocation(cid, 35)
            setPlayerStorageValue(cid, 20001, 1)
            doSendMagicEffect(getThingPos(cid), 10)
            selfSay("Your revenge is closer. You are now a Shippuden Ninja!", cid)
        else
            selfSay("You are still weak. Come back when you are level 90 and a basic Sasuke.", cid)
        end

    elseif msgcontains(msg, 'third training') then
        if getPlayerVocation(cid) == 35 and getPlayerLevel(cid) >= 170 then
            doPlayerSetVocation(cid, 36)
            doSendMagicEffect(getThingPos(cid), 10)
            selfSay("Your eyes have awakened their full power! The final training is complete.", cid)
        else
            selfSay("You must be a Shippuden Sasuke level 170 for the Third Training.", cid)
        end
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())