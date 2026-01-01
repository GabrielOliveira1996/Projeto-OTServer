local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 19)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.5, -900, -1.5, -1200)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 192)

arr = {
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
{0, 0, 1, 0, 0},
{0, 0, 1, 0, 0},
{0, 0, 1, 0, 0},
{0, 0, 1, 0, 0},
{0, 0, 3, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
    if exhaustion.check(cid, 20013) == false then
        exhaustion.set(cid, 20013, 2)
        doCombat(cid, combat, var)
        doCombat(cid, combat, var)
        return true
    else
        doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 20013).."]")
    end
end