function onStartup()
    -- 1. Comando original: Limpa o status online dos players no banco de dados
    db.executeQuery("UPDATE `players` SET `online` = 0 WHERE `world_id` = " .. getConfigValue('worldId') .. ";")
    
    setGlobalStorageValue(SAGA_AUX_BRIDGE_LOCK_STORAGE, 0)
    
    -- Log para confirmar que tudo rodou bem ao ligar o servidor
    print(">> [Startup] Players online status resetados.")
    print(">> [Saga Bridge] Global Storage " .. SAGA_AUX_BRIDGE_LOCK_STORAGE .. " resetada para 0.")
    
    return true
end