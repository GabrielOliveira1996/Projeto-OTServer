arr = {
{0, 0, 0, 0, 0},
{0, 0, 1, 0, 0},
{0, 1, 1, 1, 0},
{0, 1, 3, 1, 0},
{0, 1, 0, 1, 0},
}
local area = createCombatArea(arr) -- define a variavel area como a area de combat acima (pra usar na funcao la embaixo)


local factor = 1

function onCastSpell(cid, var)
	local fist = getPlayerSkillLevel(cid, 0)

	local formula = {
	min = factor * (650 + (fist /2)), -- nao esqueca dessa virgula pra separar o min do max
	max = factor * (800 + (3 * (fist/2)))
	}

	doAreaCombatHealth(cid, 2048, getCreaturePosition(cid), area, -formula.min, -formula.max, 30)
return true
end