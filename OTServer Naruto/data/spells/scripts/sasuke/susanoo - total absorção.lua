local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 40)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

arr = {
{0 ,0, 0, 0, 0, 0, 0},
{0 ,0, 0, 0, 0, 0, 0},
{0 ,0, 0, 0, 0, 0, 0},
{0 ,0, 0, 1, 2, 0, 0},
{0 ,0, 0, 0, 0, 0, 0},
{0 ,0, 0, 0, 0, 0, 0},
{0 ,0, 0, 0, 0, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)
local dur = 5 -- spell vai durar 5 segundos
local delay = 200 -- delay (em ms) entre cada enviada de effect
function executeCombat(cid, combat, var, time)
if not isCreature(cid) or time <= os.time() then return end
local var = var
var.pos = getThingPos(cid)
doCombat(cid, combat, var)
addEvent(executeCombat, delay, cid, combat, var, time)
end
function onCastSpell(cid, var)
local status = getCreatureStorage(cid, 301)
if status > os.time() then
    return doPlayerSendCancel(cid, "Susano'o já esta ativado.")
    end
    doCreatureSetStorage(cid, 301, os.time() + 5)
    executeCombat(cid, combat, var, os.time() + dur)
return true
end