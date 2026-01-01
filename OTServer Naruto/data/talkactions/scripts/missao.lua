local missions = {
{sto = 1000,
enunciado = "Missões # Começando as missões",
objetivo = "Vá até o terceiro andar do predio principal de konoha e fale com tsunade, peça sua primeira missão.",
reward = "Experience: -"},

{sto = 1002,
enunciado = "1ª Missão # Limpando o rio",
objetivo = "Vá até o rio de konoha ao nordeste e limpe-o.",
reward = "Experience: 2000"},

{sto = 1003,
enunciado = "1ª Missão # Limpando o rio",
objetivo = "Volte até a sala de tsunade e receba seu pagamento da missão.",
reward = "Experience: 2000"},

{sto = 1004,
enunciado = "2ª Missão # Reculpere o gato",
objetivo = "Encontre o gato perdido, procure por toda a cidade.",
reward = "Experience: 2500"},

{sto = 1005,
enunciado = "2ª Missão # Reculpere o gato",
objetivo = "Volte até a sala de tsunade e receba seu pagamento da missão.",
reward = "Experience: 2500"},

{sto = 1006,
enunciado = "3ª Missão # Concerto das luzes de Konoha",
objetivo = "Vá até a montanha dos hokages e procure por um homem chamado kyusuke, diga a ele para consertar as luzes de Konoha.(Palavra Chave: concertar luzes)",
reward = "Experience: 2500"},

{sto = 1007,
enunciado = "3ª Missão # Concerto das luzes de Konoha",
objetivo = "Volte até a sala de tsunade e receba seu pagamento da missão.",
reward = "Experience: 2500"},

{sto = 1008,
enunciado = "3ª Missão # ---",
objetivo = "--",
reward = "Experience: --"},

}

function onSay(cid, words, param, channel)

local str = ""
local haveMission = false
for _, array in ipairs(missions) do
if getPlayerStorageValue(cid, array.sto) >= 1 then
str = str..array.enunciado.."\n"..array.objetivo.."\nReward:\n"..array.reward
doPlayerSendTextMessage(cid, 27, str)
str = ""
haveMission = true
end
end 

if not haveMission then
doPlayerSendTextMessage(cid, 27, "Primeiro vire gennin para fazer missões ou se já for gennin fale com tsunade.")
end	
return true
end