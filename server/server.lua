local function checkJob(src)
    if Config.Framework == "QB" then
        local PlayerJob = QBCore.Functions.GetPlayer(src).PlayerData.job.name
        return Config.WhitelistedJobs[PlayerJob]
    elseif Config.Framework == "QBX" then
        local PlayerJob = exports.qbx_core:GetPlayer(src).PlayerData.job.name
        return Config.WhitelistedJobs[PlayerJob]
    elseif Config.Framework == "ESX" then
        local PlayerJob = ESX.GetPlayerFromId(src).job.name
        return Config.WhitelistedJobs[PlayerJob]
    end
end

if Config.Framework == "QB" then
    QBCore = exports['qb-core']:GetCoreObject()

    for itemname, _ in pairs(Config.Consumables) do
        QBCore.Functions.CreateUseableItem(itemname, function(source, item)
            TriggerClientEvent("BS-Breathalyzer:client:drinkAlcohol", source,itemname)
        end)
    end
    QBCore.Functions.CreateUseableItem('alcoholmeter',function(source,item)
        local src = source
        if checkJob(src) then
            TriggerClientEvent('BS-Breathalyzer:client:openAlcoholMeter',src)
        else
            QBCore.Functions.Notify(src,Locale("donthavejob"))
        end
    end)
elseif Config.Framework == "QBX" then
    for itemname, _ in pairs(Config.Consumables) do
        exports.qbx_core:CreateUseableItem(itemname, function(source, item)
            TriggerClientEvent("BS-Breathalyzer:client:drinkAlcohol", source,itemname)
        end)
    end
    exports.qbx_core:CreateUseableItem('alcoholmeter',function(source,item)
        local src = source
        if checkJob(src) then
            TriggerClientEvent('BS-Breathalyzer:client:openAlcoholMeter',src)
        else
            exports.qbx_core:Notify(src, Locale("donthavejob"), 'error')
        end
    end)
elseif Config.Framework == "ESX" then
    for itemname, _ in pairs(Config.Consumables) do
        ESX.RegisterUsableItem(itemname, function(source, item)
            TriggerClientEvent("BS-Breathalyzer:client:drinkAlcohol", source,itemname)
        end)
    end
    ESX.RegisterUsableItem('alcoholmeter',function(source,item)
        local src = source
        if checkJob(src) then
            TriggerClientEvent('BS-Breathalyzer:client:openAlcoholMeter',src)
        else
            local xPlayer = ESX.GetPlayerFromId(src)
            xPlayer.showNotification(Locale("donthavejob"))
        end
    end)
end

if Config.OxInventory then
    for itemname, _ in pairs(Config.Consumables) do
        
    end
    exports("usedAlcohol",function(event,item,inventory,slot,data)
        if event == 'usingItem' then
            local src = inventory.id
            TriggerClientEvent("BS-Breathalyzer:client:drinkAlcohol", src,item.name)
        end
    end)
    exports("usedGenericAlcohol",function(event,item,inventory,slot,data)
        if event == 'usingItem' then
            local src = inventory.id
            local metadata = inventory.items[slot].metadata
            TriggerClientEvent("BS-Breathalyzer:client:drinkGenericAlcohol", src,item.name, metadata, slot)
        end
    end)
    exports('openBreathalyzer',function(event, item, inventory, slot, data)
        if event == 'usingItem' then
            local src = inventory.id
            if checkJob(src) then
                TriggerClientEvent('BS-Breathalyzer:client:openAlcoholMeter',src)
            else
                if Config.Framework == "QB" then
                    QBCore.Functions.Notify(src,Locale("donthavejob"))
                elseif Config.Framework == "ESX" then
                    local xPlayer = ESX.GetPlayerFromId(src)
                    xPlayer.showNotification(Locale("donthavejob"))
                elseif Config.Framework == "QBX" then
                    exports.qbx_core:Notify(src, Locale("donthavejob"), 'error')
                end
            end
        end
    end)
end

RegisterNetEvent('BS-Breathalyzer:server:getClosestPlayers',function(players)
    local src = source
    local array = {}
    if Config.Framework == "QB" then
        for _, v in pairs(players) do
            local player = QBCore.Functions.GetPlayer(v)
            local info = {}
            info.value = tostring(v)
            info.text = '['..v..'] '..player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname
            array[#array+1] = info
        end
    elseif Config.Framework == "QBX" then
        for _, v in pairs(players) do
            local player = exports.qbx_core:GetPlayer(v)
            local info = {}
            info.value = tostring(v)
            info.text = '['..v..'] '..player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname
            array[#array+1] = info
        end
    elseif Config.Framework == "ESX" then
        for _, v in pairs(players) do
            local info = {}
            info.value = tostring(v)
            info.text = '['..v..'] '..GetPlayerName(v)
            array[#array+1] = info
        end
    end
    TriggerClientEvent('BS-Breathalyzer:client:setClosestPlayers',src,array)
end)

RegisterNetEvent('BS-Breathalyzer:server:openAlcoholMeter',function(trgt)
    local src = trgt
    local target = source
    if checkJob(target) then
        TriggerClientEvent('BS-Breathalyzer:client:openAlcoholMeter',src,target)
    else
        DropPlayer(source,"You've banned from this server. TriggerServerEvent('BS-Breathalyzer:server:openAlcoholMeter',"..trgt..")")
    end
end)

RegisterNetEvent('BS-Breathalyzer:server:showPromil',function(target,promil)
    local src = source
    if tonumber(target) == -1 then
        DropPlayer(source,"You've banned from this server. TriggerServerEvent('BS-Breathalyzer:server:showPromil',"..target..","..promil..")")
    end
    TriggerClientEvent('BS-Breathalyzer:client:showPromil',src,promil)
    TriggerClientEvent('BS-Breathalyzer:client:showPromil',target,promil)
end)


RegisterNetEvent('BS-Breathalyzer:server:drinkAlcohol',function(itemName)
    local src = source
    if Config.Framework == "QB" then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.RemoveItem(itemName,1)
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.removeInventoryItem(itemName,1)
    elseif Config.Framework == "QBX" then
        exports.ox_inventory:RemoveItem(src, itemName, 1)
    end
end)

RegisterNetEvent('BS-Breathalyzer:server:drinkGenericAlcohol',function(itemName, metadata, slot)
    local src = source
    if Config.Framework == "QB" then
        local Player = QBCore.Functions.GetPlayer(src)
        exports.ox_inventory:RemoveItem(src, itemName, 1, metadata, slot)
    end
end)

RegisterNetEvent('bs-khaza-give-alcohol', function()
    local src = source

    local data = {
        text = "Beer is consumed...",
        animation = {
            animDict = 'mp_player_intdrink',
            anim = 'loop_bottle',
            flags = 49
        },
        prop = {
            model = 'prop_amb_beer_bottle',
            bone = 60309,
            coords = vec3(0.0, 0.0, -0.05),
            rotation = vec3(0.0, 0.0, -40),
        },
    }


    exports.ox_inventory:AddItem(src, 'alcohol_generic', 1, {label = 'Beer?', promil = 0.55, progress = data})
end)