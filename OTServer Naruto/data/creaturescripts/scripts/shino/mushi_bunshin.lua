local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 3000)
setConditionParam(condition, CONDITION_PARAM_SPEED, -500)
setConditionFormula(condition, -0.9, 0, -0.9, 0)

function onStatsChange(cid, attacker, type, combat, value)
    -- Se quem leva dano é um Monstro (o clone) e tem um mestre (você)
    local master = getCreatureMaster(cid)
    
    if isMonster(cid) and master ~= cid and isPlayer(master) then
        if type == STATSCHANGE_HEALTHLOSS then
            local pos = getThingPos(cid)
            
            -- Explosão de insetos
            doSendMagicEffect(pos, 14)
            
            local spectators = getSpectators(pos, 2, 2, false)
            if spectators then
                for _, victim in ipairs(spectators) do
                    -- Não atinge o dono nem outros summons
                    if isCreature(victim) and victim ~= cid and getCreatureMaster(victim) == victim then
                        doTargetCombatHealth(0, victim, COMBAT_EARTHDAMAGE, -200, -500, 14)
                        doTargetCombatMana(0, victim, -100, -100, 2)
                        doAddCondition(victim, condition)
                    end
                end
            end
            
            doRemoveCreature(cid)
            return false 
        end
    end
    return true
end