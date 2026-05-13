TAITO_STORAGES = {
    RANK_POINTS = 34100,
    DAILY_LIMIT = 34101,
    ACTIVE_MISSION = 34102,
    MISSION_PROG = 34103,
    JOINED = 34104
}

TAITO_MISSIONS = {
    [1] = {
        name = "Patrulha de Limpeza I", rank = "D", points = 5, goal = 25, target = "Kuroi Infiltrator", 
        desc = "Elimine 25 Infiltrators ao sul da vila.",
        rewards = {{2152, 10}, {2160, 1}}
    },
    [2] = {
        name = "Suprimentos Médicos", rank = "D", points = 10, 
        desc = "Leve esta caixa de ervas para a sentinela do Portão Sul.", 
        item = 2549, type = "npc_delivery",
        contact = "jairo", 
        rewards = {{2152, 12}, {2145, 5}}
    },
    [3] = {
        name = "Patrulha de Limpeza II", rank = "C", points = 10, goal = 50, target = "Kuroi Infiltrator", 
        desc = "Mate 50 Infiltrators que tentam pular os muros.",
        rewards = {{2152, 20}}
    },
    [4] = {
        name = "Mensagem Urgente", rank = "C", points = 25, 
        desc = "Entregue este relatório ao general Kendo em Konoha.", 
        item = 1952, type = "npc_delivery",
        contact = "kendo", 
        rewards = {{2152, 25}}
    },
    [5] = {
        name = "Fogo Contra Fogo", rank = "B", points = 40, goal = 50, target = "Kuroi Ascendant", 
        desc = "Abata 50 Ascendants da Kuroi Hasu.",
        rewards = {{2152, 40}, {2157, 1}}
    },
    [6] = {
        name = "Sabotagem de Base", rank = "B", points = 45, 
        desc = "Vá até a base ao suldeste e destrua o estoque de suprimentos que existe la.", 
        item = 2144,
        type = "pos",
        rewards = {{2152, 45}}
    },
    [7] = {
        name = "Onda Sombria", rank = "A", points = 70, goal = 30, target = "Kuroi Infiltrator", 
        desc = "Eliminação em massa: 30 alvos de elite.",
        rewards = {{2152, 70}, {2160, 2}}
    },
    [8] = {
        name = "Resgate de Refém", rank = "A", points = 80, 
        desc = "Encontre o ANBU ferido na floresta morta.", 
        type = "pos",
        rewards = {{2152, 80}}
    },
    [9] = {
        name = "Assassinato: O Carniceiro", rank = "S", points = 150, goal = 1, target = "Kuroi Commander Boss", 
        desc = "Missão Suicida: Elimine um Comandante da Lótus.",
        rewards = {{2152, 150}, {2160, 5}}
    },
    [10] = {
        name = "Fronteira Final", rank = "S", points = 200, 
        desc = "Defenda a base avançada por 10 minutos.", 
        type = "pos",
        rewards = {{2152, 200}, {2160, 10}}
    }
}

function getRankName(pts)
    if pts < 50 then return "D"
    elseif pts < 150 then return "C"
    elseif pts < 400 then return "B"
    elseif pts < 1000 then return "A"
    else return "S" end
end