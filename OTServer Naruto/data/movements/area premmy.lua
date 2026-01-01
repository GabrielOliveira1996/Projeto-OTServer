function onStepIn(cid, item, position, fromPosition)
local cfg = {
pos = {x=10, y=1, z=7}, -- local que o teleport vai levar
stg = 4124, -- storage que o player precisará ter
}
if getPlayerStorageValue(cid,cfg.stg) == 1 then
setPlayerStorageValue(cid,cfg.stg,2)
doTeleportThing(cid,cfg.pos)
doSendMagicEffect(getPlayerPosition(cid),10)
else
doPlayerSendTextMessage(cid,25,"Você não pode entrar ou já entrou aqui uma vez.")
doTeleportThing(cid,fromPosition)
end
end