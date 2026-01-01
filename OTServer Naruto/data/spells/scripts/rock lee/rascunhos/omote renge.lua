local distanceCombat = createCombatObject()
setCombatParam(distanceCombat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(distanceCombat, COMBAT_PARAM_EFFECT, 41)



function getSpellDamage(cid, lv, maglv)
                damage_min = (lv + maglv) * 3.6
                damage_max = (lv + maglv) * 4.4

                if(damage_max < damage_min) then
                                local tmp = damage_max
                  damage_max = damage_min
                  damage_min = tmp
                end
                return -damage_min, -damage_max
end

setCombatCallback(distanceCombat, CALLBACK_PARAM_SKILLVALUE, "getSpellDamage")

function onCastSpell(cid, var)
local player = getCreaturePosition(cid)
local target = getCreatureTarget(cid)
local enemypos = getCreaturePosition(target)

if target == isMonster or isCreature then
doTeleportThing(cid, enemypos)
doSendMagicEffect(enemypos, 2)
doCombat(cid, distanceCombat, var)
return 1
else
doPlayerSendCancel(cid, "Precisa de um target.")
end
end