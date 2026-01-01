local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 40)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)
arr = {

{0, 1, 2},

}


    local T = {
    {level = {from = 200, to = 299}, delay = 300, dur = 3, sto = 301},
    {level = {from = 300, to = 400}, delay = 300, dur = 3, sto = 301},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)
function executeCombat(cid, combat, var, time)
        for _, V in pairs(T) do
if(getPlayerLevel(cid) >= V.level.from and getPlayerLevel(cid) <= V.level.to) then
    if not isCreature(cid) or time <= os.time() then return end
local var = var
var.pos = getThingPos(cid)
    doCombat(cid, combat, var)
    addEvent(executeCombat, V.delay, cid, combat, var, time)
end
end
end

function onCastSpell(cid, var)


    local status = getCreatureStorage(cid, 301)
    if status > os.time() then
    return doPlayerSendCancel(cid, "O jutsu já esta ativado.")
    end

        for _, V in pairs(T) do
if(getPlayerLevel(cid) >= V.level.from and getPlayerLevel(cid) <= V.level.to) then
    doCreatureSetStorage(cid, 301, os.time() + V.dur)
    doSendMagicEffect(getCreaturePosition(cid), 26)
    executeCombat(cid, combat, var, os.time() + V.dur)
return true
end
end
end

