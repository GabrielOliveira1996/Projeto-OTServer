local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 4)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1.0, -520, -1.7, -600)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 16)

arr = {
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
{0, 0, 3, 0, 0},
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

local tempo = 2 -- em segundos
local strg = 12120

function onCastSpell(cid, var)
 if not exhaustion.check(cid, strg) then
        exhaustion.set(cid, strg, tempo * 1000)
        return doCombat(cid, combat, var)
    else
        doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, strg).."]")
    end
end