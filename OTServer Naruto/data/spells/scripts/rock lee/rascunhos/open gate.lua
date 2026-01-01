local function one(cid)
if getPlayerMana(cid) <= 100 then return true end
doPlayerSetVocation(cid, 42)
doSetCreatureOutfit(cid, {lookType = 373}, -1)

if getPlayerLevel(cid) >= 40 then
doCreatureAddMana(cid, -10)
addEvent(one ,2 * 1000, cid)
end
end

local function two(cid)
if getPlayerMana(cid) <= 100 then return true end
doPlayerSetVocation(cid, 42)
doSetCreatureOutfit(cid, {lookType = 373}, -1)

if getPlayerLevel(cid) >= 80 then
   doCreatureAddMana(cid, -20)
    addEvent(two ,2 * 1000, cid)
 end
end

local function three(cid)
if getPlayerMana(cid) <= 100 then return true end
doPlayerSetVocation(cid, 42)
doSetCreatureOutfit(cid, {lookType = 373}, -1)

if getPlayerLevel(cid) >= 120 then
   doCreatureAddMana(cid, -30)
    addEvent(three ,2 * 1000, cid)
 end
end

local function four(cid)
if getPlayerLevel(cid) >= 150 then
   doCreatureAddMana(cid, -40)
    addEvent(four ,2 * 1000, cid)

if getPlayerMana(cid) <= 100 then return true end
doPlayerSetVocation(cid, 43)
doSetCreatureOutfit(cid, {lookType = 374}, -1)
 end
end

local function five(cid)
if getPlayerLevel(cid) >= 300 then
   doCreatureAddMana(cid, -50)
    addEvent(five ,2 * 1000, cid)

if getPlayerMana(cid) <= 100 then return true end
doPlayerSetVocation(cid, 44)
doSetCreatureOutfit(cid, {lookType = 374}, -1)
 end
end


function onCastSpell(cid, var)

local outfit1 = 372
local level1 = 40
local outfit2 = 371
local level2 = 80
local outfit3 = 165
local level3 = 120
local outfit4 = 167
local level4 = 150
local outfit5 = 407
local level5 = 300

if getPlayerLevel(cid) >= level1 then
doSetCreatureOutfit(cid, {lookType = outfit1}, -1)
doPlayerSetVocation(cid, 70)
doSendMagicEffect(getCreaturePosition(cid), 106)
addEvent(one ,2 * 1000, cid)
end

if getPlayerLevel(cid) >= level2 then
doSetCreatureOutfit(cid, {lookType = outfit2}, -1)
doPlayerSetVocation(cid, 71)
doSendMagicEffect(getCreaturePosition(cid), 106)
addEvent(two ,2 * 1000, cid)
end

if getPlayerLevel(cid) >= level3 then
doSetCreatureOutfit(cid, {lookType = outfit3}, -1)
doPlayerSetVocation(cid, 72)
doSendMagicEffect(getCreaturePosition(cid), 106)
addEvent(three ,2 * 1000, cid)
end

if getPlayerLevel(cid) >= level4 then
doSetCreatureOutfit(cid, {lookType = outfit4}, -1)
doPlayerSetVocation(cid, 73)
doSendMagicEffect(getCreaturePosition(cid), 106)
addEvent(four ,2 * 1000, cid)
end

if getPlayerLevel(cid) >= level5 then
doSetCreatureOutfit(cid, {lookType = outfit5}, -1)
doPlayerSetVocation(cid, 82)
doSendMagicEffect(getCreaturePosition(cid), 106)
addEvent(five ,2 * 1000, cid)
return true
end
end