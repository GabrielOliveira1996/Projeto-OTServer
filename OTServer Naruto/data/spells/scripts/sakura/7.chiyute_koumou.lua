local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

function onGetFormulaValues(cid, level, maglevel)
    local min = (level * 2 + maglevel * 3)
    local max = (level * 2 + maglevel * 5)
    return min, max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
    local party = getPlayerParty(cid)
    
    if not party then
        return doCombat(cid, combat, var)
    end

    local members = getPartyMembers(party)
    local center = getThingPos(cid)
    local affected = false

    for _, member in ipairs(members) do
        local memberPos = getThingPos(member)
        -- cura aliados em party em até 7 sqm de distância.
        if memberPos.z == center.z and getDistanceBetween(center, memberPos) <= 7 then
            doCombat(cid, combat, numberToVariant(member))
            doSendMagicEffect(memberPos, CONST_ME_MAGIC_BLUE)
            affected = true
        end
    end

    if not affected then
        -- se ninguem da party estiver proximo cura apenas o usuario
        return doCombat(cid, combat, var)
    end

    return true
end