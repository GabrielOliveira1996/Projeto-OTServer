local config = {
	rateExp = getConfigInfo('rateExp'),
	rateSkill = getConfigInfo('rateSkill'),
	rateLoot = getConfigInfo('rateLoot'),
	rateMagic = getConfigInfo('rateMagic'),
	rateSpawn = getConfigInfo('rateSpawn'),
	protectionLevel = getConfigInfo('protectionLevel')
}

function onSay(cid, words, param)
	local str = "#Vip Info by GOD Brolly#\n\nComprar Vip:\n !buyvip\n Ver Quantos Dias Restam:\n !vipdays\n-Protection level: " .. config.protectionLevel
	doPlayerPopupFYI(cid, str)
	return FALSE
end