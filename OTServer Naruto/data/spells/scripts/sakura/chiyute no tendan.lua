healRegen = {}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

local condition = createConditionObject(CONDITION_REGENERATION)
setConditionParam(condition, CONDITION_PARAM_SUBID, 1)
setConditionParam(condition, CONDITION_PARAM_BUFF_SPELL, 1)
setCombatCondition(combat, condition)


function regen(cid,var,n)
   n = n or 0
   if isPlayer(cid) then
     doCreatureAddHealth(cid, 20)
     if(n < 20) then
       healRegen[cid] = addEvent(regen,3*1000,cid,var,n+1)
     end
   end
   return true
end

function onCastSpell(cid, var)
   if healRegen[cid] then
     stopEvent(healRegen[cid])
   end
   doCombat(cid, combat, var)
   healRegen[cid] = addEvent(regen,250,cid,var,0)
   return true
end