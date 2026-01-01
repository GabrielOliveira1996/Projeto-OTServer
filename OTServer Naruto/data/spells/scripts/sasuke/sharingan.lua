local tempo = 180 * 1000 -- Tempo, nesse caso esta 60 segundos Lembrando que 1000 = 1 segundo

local skillclub = 3
local skillsword = 3
local skillshield = 3

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 26)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

local condition = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(condition, CONDITION_PARAM_TICKS, tempo)
setConditionParam(condition, CONDITION_PARAM_SKILL_CLUB, skillclub)
setConditionParam(condition, CONDITION_PARAM_SKILL_SWORD, skillsword)
setConditionParam(condition, CONDITION_PARAM_SKILL_SHIELD, skillshield)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
    return doCombat(cid, combat, var)
end