local config = {
	loginMessage = getConfigValue('loginMessage')
}



function onLogin(cid)
	

local loss = getConfigValue('deathLostPercent')
	
if(loss ~= nil) then
		
doPlayerSetLossPercent(cid, PLAYERLOSS_EXPERIENCE, loss * 10)
	
end

	

local accountManager = getPlayerAccountManager(cid)
	
if(accountManager == MANAGER_NONE) then
		
local lastLogin, str = getPlayerLastLoginSaved(cid), config.loginMessage
		

if(lastLogin > 0) then
			
doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, str)
			str = "Your last visit was on " .. os.date("%a %b %d %X %Y", lastLogin) .. "."
			end

		doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, str)
	elseif(accountManager == MANAGER_NAMELOCK) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, it appears that your character has been namelocked, what would you like as your new name?")
	elseif(accountManager == MANAGER_ACCOUNT) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, type 'account' to manage your account and if you want to start over then type 'cancel'.")
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, type 'account' to create an account or type 'recover' to recover an account.")
	end

	if(not isPlayerGhost(cid)) then
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
	end

    registerCreatureEvent(cid, "test")
	registerCreatureEvent(cid, "Mail")
	registerCreatureEvent(cid, "GuildMotd")
	
    registerCreatureEvent(cid, "killer")
    registerCreatureEvent(cid, "Idle")

    registerCreatureEvent(cid, "attackguild")	
    registerCreatureEvent(cid, "FimVip")
    registerCreatureEvent(cid, "SkullCheck")
    registerCreatureEvent(cid, "ReportBug")

    registerCreatureEvent(cid, VipReceive)
    registerCreatureEvent(cid, "LookTypes")
    registerCreatureEvent(cid, "Susanoo")
    registerCreatureEvent(cid, "Testar")
    registerCreatureEvent(cid, "TransformVoc")
    registerCreatureEvent(cid, "Corpse")
    registerCreatureEvent(cid, "Buff")
    registerCreatureEvent(cid, "VocationHpeMana")
    registerCreatureEvent(cid, "VocationHpeManaOne")
    registerCreatureEvent(cid, "VocationHpeManaTwo")
    registerCreatureEvent(cid, "akatsukiring")
    registerCreatureEvent(cid, "mkillm")
    registerCreatureEvent(cid, "Gennin")
    registerCreatureEvent(cid, "Bunshin") 
    registerCreatureEvent(cid, "Summon") 
    registerCreatureEvent(cid, "Summon1") 
    registerCreatureEvent(cid, "Summon2") 
    registerCreatureEvent(cid, "Summon3") 
    registerCreatureEvent(cid, "DeadTeleport") 



    registerCreatureEvent(cid, "mizukiteleport")
    registerCreatureEvent(cid, "mizukiteleport1")
    registerCreatureEvent(cid, "mizukiteleport2")

    registerCreatureEvent(cid, "SagaKill")


    registerCreatureEvent(cid, "aa")

    if (InitArenaScript ~= 0) then
    InitArenaScript = 1
    -- make arena rooms free
        for i = 42300, 42309 do
            setGlobalStorageValue(i, 0)
            setGlobalStorageValue(i+100, 0)
        end
    end
    -- if he did not make full arena 1 he must start from zero
    if getPlayerStorageValue(cid, 42309) < 1 then
        for i = 42300, 42309 do
            setPlayerStorageValue(cid, i, 0)
            setPlayerStorageValue(cid, 14755, -1)
            setPlayerStorageValue(cid, 14755, -1)
        end
    end
    -- if he did not make full arena 2 he must start from zero
    if getPlayerStorageValue(cid, 42319) < 1 then
        for i = 42310, 42319 do
            setPlayerStorageValue(cid, i, 0)
        end
    end
    -- if he did not make full arena 3 he must start from zero
    if getPlayerStorageValue(cid, 42329) < 1 then
        for i = 42320, 42329 do
            setPlayerStorageValue(cid, i, 0)
        end
    end
    if getPlayerStorageValue(cid, 42355) == -1 then
        setPlayerStorageValue(cid, 42355, 0) -- did not arena level
    end
if(getPlayerStorageValue(cid, 1337) == 1) then
   return false
end
    setPlayerStorageValue(cid, 42350, 0) -- time to kick 0
    setPlayerStorageValue(cid, 42352, 0) -- is not in arena 
    setPlayerStorageValue(cid, 11109, 1) -- saga inicial
    setPlayerStorageValue(cid, 92000, 1) -- ryuu the monk mission
setPlayerStorageValue(cid, 14755, -1)

local storagecheck = 31313
local storagelose = 11109

if getPlayerStorageValue(cid, storagecheck) >= 1 then
setPlayerStorageValue(cid, storagelose, -1)
end

local storagelose1 = 92000

if getPlayerStorageValue(cid, 92001) >= 1 and getPlayerStorageValue(cid, 92002) >= 1 and getPlayerStorageValue(cid, 92003) >= 1 then
setPlayerStorageValue(cid, storagelose1, -1)
end

if getPlayerStorageValue(cid, 1992) ~= -1 then
doPlayerSetVocation(cid, getPlayerStorageValue(cid, 1992))
end 
return true
end
