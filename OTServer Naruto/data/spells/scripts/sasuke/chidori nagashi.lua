local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 81)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.5, -600, -1.5, -900)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 5)

arr = {
{0, 0, 1, 0, 0},
{0, 1, 1, 1, 0},
{1, 1, 3, 1, 1},
{0, 1, 1, 1, 0},
{0, 0, 1, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
    if exhaustion.check(cid, 20012) == false then
        exhaustion.set(cid, 20012, 2)
        doCombat(cid, combat, var)
        doCombat(cid, combat, var)
        return true
    else
        doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 20012).."]")
    end
end