local mainStorage = 1500 -- Main storage value
local maxBombCount = 2 -- How many seconds you can plant a bomb. Each bomb storage needs 4
local podlozenoTime = 2 -- How many seconds loading bombs
local naCzas = 'yes' -- Is a time bomb (yes) or detonates when you use item (no)
local tekst = 'yes' -- Show a message when the bomb explodes?
local uciekac = 'no' -- display the inscription of running away when the bomb explodes?
local wybuchTime = 2 -- After how many seconds after a bomb...
local area = { -- 3 is bomb position, 1 is a tile which will explode
        {0, 1, 1, 1, 1, 1, 0},
        {1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 3, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1},
        {0, 1, 1, 1, 1, 1, 0}
}
local min = 100 -- Min. hp that will deal
local max = 500 -- Max. hp that will deal
local kolorTekstow = (TALKTYPE_MONSTER ~= nil and TALKTYPE_MONSTER or TALKTYPE_ORANGE_1) -- Color Messages
local condition = createConditionObject(CONDITION_INFIGHT)
setConditionParam(condition, key, value)
setConditionParam(condition, CONDITION_PARAM_TICKS,(podlozenoTime+wybuchTime+1)*1000)
area = createCombatArea(area)
naCzas = naCzas == 'yes' and true or false
tekst = tekst == 'yes' and true or false
uciekac = uciekac == 'yes' and true or false

function onUse(cid, item, fromPosition, itemEx, toPosition)  
        if item.itemid == 8300 then
                if naCzas then
                        doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,"You may not detonate a bomb.")
                        return true
                end
                -- Bomb Detonation
                local aktualnyStorage = mainStorage+1
                local ileBomb = 0 -- How many bombs exploded in
                while getCreatureStorage(cid,aktualnyStorage) > 0 do
                        local pos = {x=getCreatureStorage(cid,aktualnyStorage), y=getCreatureStorage(cid,aktualnyStorage+1), z=getCreatureStorage(cid,aktualnyStorage+2), stackpos=getCreatureStorage(cid,aktualnyStorage+3)}
                        ileBomb = ileBomb+1
                        detonujBombe(cid, pos, aktualnyStorage)
                        aktualnyStorage = aktualnyStorage+4
                end
                if ileBomb == 0 then
                        doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,'Nao foi colocada a Bomba.')
                else
                        doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,ileBomb ..' bomb'.. (ileBomb == 1 and 'a' or '') ..' Explotada'.. (ileBomb == 1 and '' or 'o') ..'.')
                end
                return true
        end
        -- Bomb
        local playerPos = getCreaturePosition(cid)
        if getTileInfo(playerPos).protection or getTileInfo(playerPos).house then
                doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,'Você nao pode ativar a papel Bomba em Zona de Proteção.')
                return true
        end
        local aktualneBomby = getCreatureStorage(cid,mainStorage)
        if aktualneBomby+maxBombCount > os.time() then
                doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,'Tem que esperar para colocar Outro papel Bomba.')
                return true
        end
        local ileMaBomb = 0
        local aktualnyStorage = mainStorage+1
        while(getCreatureStorage(cid,aktualnyStorage) > 0) do
                ileMaBomb = ileMaBomb+1
                aktualnyStorage = aktualnyStorage+4
        end
        if(item.type > 1) then
                doChangeTypeItem(item.uid,item.type-1)
        else
                doRemoveItem(item.uid,1)
        end
        doCreatureSay(cid,'Armando o papel bomba...',kolorTekstow)
        addEvent(podlozBombe,podlozenoTime*1000,cid,playerPos,aktualnyStorage)
        doCreatureSetStorage(cid,mainStorage,os.time())
end

function podlozBombe(cid, pozycjaGracza, storage)
        if not isPlayer(cid) then
                return false
        end
        local playerPos = getCreaturePosition(cid)
        if(playerPos.x ~= pozycjaGracza.x or playerPos.y ~= pozycjaGracza.y or playerPos.z ~= pozycjaGracza.z) then
                doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,'Você se moveu.. nao foi Possivel Armar o Papel Bomba.')
                return true
        end
        local bomba = doCreateItem(2144,1,pozycjaGracza)
        local bombaPos = getThingPos(bomba)
        doCreatureSetStorage(cid,storage,pozycjaGracza.x)
        doCreatureSetStorage(cid,storage+1,pozycjaGracza.y)
        doCreatureSetStorage(cid,storage+2,pozycjaGracza.z)
        doCreatureSetStorage(cid,storage+3,bombaPos.stackpos)
        if(not naCzas) then
                doCreatureSay(cid,'Bomba armada',kolorTekstow)
                doAddCondition(cid,condition)
        else
                if(uciekac) then
                        doCreatureSay(cid,'Corre! o papel bomba foi armada!',kolorTekstow)
                end
                addEvent(detonujBombe,wybuchTime*1000,cid,bombaPos,storage)
                doAddCondition(cid,condition)
        end
        return true
end

function detonujBombe(cid, pos, storage)
        local playerPos = getCreaturePosition(cid)
        if(playerPos.x ~= pos.x or playerPos.y ~= pos.y or playerPos.z ~= pos.z) then
                pos.stackpos = pos.stackpos-1
        end
        local bomba = getThingfromPos(pos)
        if(bomba.itemid == 2144) then
                doAreaCombatHealth(0, COMBAT_HOLYDAMAGE, pos, area, -min, -max, 19)
                doCreatureSetStorage(cid,storage,0)
                if(tekst) then
                        doSendAnimatedText(pos,'KaaaBoOoOoOo!',TEXTCOLOR_YELLOW)
                end
                doRemoveItem(bomba.uid,1)
                return true
        end
        return false
end