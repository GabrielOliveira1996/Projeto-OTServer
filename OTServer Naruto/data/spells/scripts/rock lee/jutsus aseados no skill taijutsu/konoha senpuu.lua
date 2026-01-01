

arr = {
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
{0, 1, 3, 1, 0},
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
}
local area = createCombatArea(arr) -- define a variavel area como a area de combat acima (pra usar na funcao la embaixo)


local factor = 1

function onCastSpell(cid, var)
	local fist = getPlayerSkillLevel(cid, 0)

	local formula = {
	min = factor * (300 + (fist /2)), -- nao esqueca dessa virgula pra separar o min do max
	max = factor * (450 + (6 * (fist/2)))
	}

	
if exhaustion.check(cid, 20010) == false then
exhaustion.set(cid, 20010, 2)
return doAreaCombatHealth(cid, 2048, getCreaturePosition(cid), area, -formula.min, -formula.max, 46)
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 20010).."]")
end
end

