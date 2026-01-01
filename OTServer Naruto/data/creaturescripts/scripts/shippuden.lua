local config = { 
promoLevel = 1, -- promotion level : ) 
needLevel = 150, -- level to get promotion 
needPremium = "no" -- need premium (YES/NO)? :D 
} 

function onAdvance(cid, skill, oldlevel, newlevel) 
if (skill == 0) and (newlevel >= config.needLevel and getPlayerPromotionLevel(cid)<config.promoLevel) then 
if(string.lower(config.needPremium) == "yes" and isPremium(cid) == TRUE) or (string.lower(config.needPremium) == "no") then 
setPlayerPromotionLevel(cid, config.promoLevel) 
doPlayerSendTextMessage(cid, 22, "Você agora é " .. getVocationInfo(getPlayerVocation(cid)).name .. ".") 
end 
end 
return TRUE 
end