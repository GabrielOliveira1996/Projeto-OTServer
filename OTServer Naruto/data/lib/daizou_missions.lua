-- Storages Gerais
PLAYER_PRESTIGE_POINTS = 12000

DAIZOU_MISSIONS = {
    [1] = { 
        name = "Limpeza da Vizinhan�a",
        rank = "rank d",
        mapMark = 2,
        points = 5,
        rewardId = 2152,
        experience = 1000,
        rewardCount = 5,
        requiredPoints = 0,
        goalCount = 5, 
        storageStatus = 12001, 
        storageCount = 12002, -- essa storage que vai mudar
        storageTime = 12006, 
        locations = {
            [1] = {x = 3029, y = 3074, z = 7, name = "Lixo da Sauna"},
            [2] = {x = 3048, y = 3052, z = 7, name = "Lixo do Depot"},
            [3] = {x = 3018, y = 3050, z = 7, name = "Lixo do Ichiraku"},
            [4] = {x = 2976, y = 3049, z = 7, name = "Lixo da Arena"},
            [5] = {x = 3001, y = 3015, z = 7, name = "Lixo do Predio Principal"}
        },
        msgStart = "Limpe os 5 pontos de lixo espalhados. Aceita?",
        msgDone = "Vila limpa! Aqui está sua recompensa."
    },
    [2] = { 
        name = "Suprimentos Medicos",
        rank = "rank d",
        mapMark = 2,
        points = 5,
        rewardId = 2152,
        experience = 1500,
        rewardCount = 5,
        requiredPoints = 0,
        goalCount = 20,
        itemId = 2677, 
        storageStatus = 12010, 
        storageTime = 12011, 
        msgStart = "O estoque de suprimentos medicos esta critico. Pode me trazer 20 Strawberrys? Aceita?",
        msgDone = "Excelente! Com essas frutas poderemos fabricar pilulas suficientes. Aqui esta seu pagamento."
    },
    [3] = { 
        name = "Coleta de Cartas",
        rank = "rank d",
        mapMark = 2,
        points = 5,
        rewardId = 2152,
        experience = 1000,
        rewardCount = 5,
        requiredPoints = 5,
        goalCount = 4,
        itemId = 2597, 
        storageStatus = 12030, 
        storageCount = 12031,  
        storageID1 = 12032, 
        storageID2 = 12033, 
        storageID3 = 12034, 
        storageID4 = 12035, 
        storageTime = 12036, 
        locations = {
            [1] = {x = 2931, y = 3022, z = 7, name = "Correio do Posto I"},
            [2] = {x = 3005, y = 3015, z = 7, name = "Correio do Predio Principal"},
            [3] = {x = 3067, y = 3026, z = 7, name = "Correio da Academia"},
            [4] = {x = 3054, y = 3098, z = 7, name = "Correio da Vizinhanca"}
        },
        msgStart = "Preciso que recolha as cartas das 4 caixas de correio da vila. Aceita?",
        msgDone = "Excelente trabalho! Essas mensagens sao urgentes."
    },
    [4] = { 
        name = "Invasao de Lobos",
        rank = "rank c",
        mapMark = 12, -- Caveira
        points = 10,
        rewardId = 2152,
        experience = 2500,
        rewardCount = 10, -- 10 gold coins
        requiredPoints = 50, -- Precisa de 50 pontos de prestígio para liberar
        goalCount = 20, 
        storageStatus = 12040, 
        storageCount = 12041,  
        storageTime = 12042, 
        locations = {
            [1] = {x = 3003, y = 3122, z = 7, name = "Entrada de Konoha"} -- Ajuste a coordenada da entrada
        },
        msgStart = "Lobos selvagens estao bloqueando a entrada de Konoha e assustando viajantes. Mate 20 Wolfs para limpar o caminho. Aceita?",
        msgDone = "Excelente trabalho ninja! O caminho para os comerciantes agora esta seguro."
    },
    [5] = { 
        name = "Manuscrito Emboscado",
        rank = "rank c",
        mapMark = 1, -- Ponto de exclamação
        points = 20, -- Recompensa alta de prestígio
        rewardId = 2152,
        experience = 5000,
        rewardCount = 20, 
        requiredPoints = 50, -- pontos necessários para desbloquear
        goalCount = 1,
        itemId = 5919, -- ID de um Scroll/Pergaminho
        storageStatus = 12050, 
        storageCount = 12051,  
        storageTime = 12052, 
        locations = {
            [1] = {x = 2881, y = 3182, z = 7, name = "Posto Avancado"} -- Coloque uma coordenada longe da vila
        },
        msgStart = "Um de nossos mensageiros foi atacado em um posto avancado. Recupere o Manuscrito Proibido antes que caia em maos erradas. Esteja pronto para combate! Aceita?",
        msgDone = "Incrivel! Esse manuscrito contem segredos vitais para a vila. Voce nos ajudou muito."
    },
    [6] = { 
        name = "Cogumelos Medicinais",
        rank = "rank c",
        mapMark = 18, -- Ícone de floresta/planta
        points = 25, 
        rewardId = 2152, -- Gold Platina
        experience = 3000,
        rewardCount = 20, 
        requiredPoints = 50, -- Exige que o player já tenha moral na vila
        goalCount = 20,
        itemId = 2789, -- ID do Brown Mushroom (Ajuste se o seu for outro)
        storageStatus = 12060, 
        storageCount = 12061,  
        storageTime = 12062, 
        locations = {
            [1] = {x = 3136, y = 3120, z = 7, name = "Floresta de Fungos"} -- Área externa
        },
        msgStart = "Nossos medicos estao ficando sem estoque de fungos para antidotos. Preciso que colha 20 cogumelos na Floresta de Fungos ao Leste. Cuidado com os perigos la fora. Aceita?",
        msgDone = "Perfeito! Estes cogumelos sao de excelente qualidade. Agradecemos a sua contrinuicao."
    },
}