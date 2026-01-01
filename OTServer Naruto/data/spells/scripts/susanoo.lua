local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

arr = {
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
{0, 1, 3, 1, 0},
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
    local status = getCreatureStorage(cid, 11122)
    if status > os.time() then
        return doPlayerSendCancel(cid, "O efeito da magia está ativo.")
    end
    doCreatureSetStorage(cid, 11122, os.time() + 15)
    doCombat(cid, combat, var)
    return true
end