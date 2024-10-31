if Config.Framework == "QB" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "ESX" then
 -- 
end
local effect = false
local promil = 0

local function GetClosestPlayers()
    local players = GetActivePlayers()
    local closePlayers = {}
	local coords = GetEntityCoords(PlayerPedId())
    local distance = 10.0

    for _, player in pairs(players) do
		local target = GetPlayerPed(player)
		local targetCoords = GetEntityCoords(target)
		local targetdistance = #(targetCoords - coords)
		if (targetdistance <= distance) and target ~= PlayerPedId() then
            closePlayers[#closePlayers+1]=GetPlayerServerId(player)
		end
    end
    return closePlayers
end


local prop = nil
RegisterNetEvent('BS-Breathalyzer:client:drinkAlcohol',function(itemName)
    local array = Config.Consumables[itemName]
    if Config.Framework == "ESX" then
        if prop then 
            DeleteObject(prop)
            prop = nil
        end
		local playerPed = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		prop = CreateObject(joaat(array.progress.prop.model), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(playerPed, array.progress.prop.bone)
		AttachEntityToEntity(prop, playerPed, boneIndex, array.progress.prop.coords.x, array.progress.prop.coords.y, array.progress.prop.coords.z, array.progress.prop.rotation.x, array.progress.prop.rotation.y, array.progress.prop.rotation.z, true, true, false, true, 1, true)
		ESX.Streaming.RequestAnimDict(array.progress.animation.animDict, function()
			TaskPlayAnim(playerPed, array.progress.animation.animDict, array.progress.animation.name, 8.0, 1.0, -1, array.progress.animation.flags, 0, 0, 0, 0)
			RemoveAnimDict(array.progress.animation.animDict)
			Wait(3000)
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
            TriggerServerEvent('BS-Breathalyzer:server:drinkAlcohol', itemName)
            local addValue = Config.Consumables[itemName] and Config.Consumables[itemName].promil or 0.10
            promil = promil + addValue
            if promil < 0 then
                promil = 0
            end
            if effect then
                Config.Trips[effect].stop()
            end
            for _, data in pairs(Config.Trips) do
                effect = promil >= data.promil and _ or effect
            end
            if effect then
                Citizen.CreateThread(function()
                    Config.Trips[effect].start(promil)
                end)
            end
            prop = nil
		end)
    elseif Config.Framework == "QB" then
        QBCore.Functions.Progressbar('drink_alcohol', array.progress.text, math.random(array.time.min,array.time.max), false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true
        }, array.progress.animation, array.progress.prop, {}, function() -- Done
            TriggerServerEvent('BS-Breathalyzer:server:drinkAlcohol', itemName)
            local addValue = Config.Consumables[itemName] and Config.Consumables[itemName].promil or 0.10
            promil = promil + addValue
            if promil < 0 then
                promil = 0
            end
            TriggerEvent('qb-inventory:client:ItemBox', QBCore.Shared.Items[itemName], 'remove')
            TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
            if promil > 0.50 and promil < 0.80 then
                TriggerEvent('evidence:client:SetStatus', 'alcohol', 200)
            elseif promil >= 0.80 then
                TriggerEvent('evidence:client:SetStatus', 'heavyalcohol', 200)
            end
            if effect then
                Config.Trips[effect].stop()
            end
            for _, data in pairs(Config.Trips) do
                effect = promil >= data.promil and _ or effect
            end
            if effect then
                Citizen.CreateThread(function()
                    Config.Trips[effect].start(promil)
                end)
            end
        end, function() -- Cancel
    
        end)
    end
end)

RegisterNetEvent('BS-Breathalyzer:client:resetPromil',function()
    promil = 0
end)

RegisterNUICallback('close',function(data)
    SendNUIMessage({action="close"})
    SetNuiFocus(false,false)
end)

RegisterNUICallback('getClosest',function(data)
    local closePlayers = GetClosestPlayers()
    if #closePlayers > 0 then
        TriggerServerEvent('BS-Breathalyzer:server:getClosestPlayers',closePlayers)
    else
        if Config.Framework == "QB" then
            QBCore.Functions.Notify(Locale("nonearby"),"error")
        elseif Config.Framework == "ESX" then
            ESC.ShowNotification(Locale("nonearby"))
        end
    end
end)

RegisterNetEvent('BS-Breathalyzer:client:setClosestPlayers',function(data)
    SendNUIMessage({action="setClosestPlayers",players=data})
end)

RegisterNUICallback('openAlcoholmeter',function(data)
    local target = data.target
    TriggerServerEvent('BS-Breathalyzer:server:openAlcoholMeter',target)
end)

RegisterNetEvent('BS-Breathalyzer:client:openAlcoholMeter',function(target)
    SendNUIMessage({
        action= "open",
        type = target and "user" or "police",
        target = target
    })
    SetNuiFocus(true,true)
end)

RegisterNUICallback('showPromil',function(data)
    local target = data.target
    TriggerServerEvent('BS-Breathalyzer:server:showPromil',target,promil)
end)

RegisterNetEvent('BS-Breathalyzer:client:showPromil',function(promil)
    local colors = {}
    for k,v in pairs(Config.PromilColours) do
        if promil >= v.promil then
            colors = v.css
        end
    end
    SendNUIMessage({
        action = "setPromil",
        promil = promil,
        colors = colors
    })
end)

Citizen.CreateThread(function()
    table.sort(Config.Trips, function (k1, k2) return k1.promil < k2.promil end )
    table.sort(Config.PromilColours, function (x1, x2) return x1.promil < x2.promil end )
    while true do
        Wait(10000)
        if promil > 0 then
            promil = promil - 0.025
            local lasteffect = effect
            for _, data in pairs(Config.Trips) do
                effect = promil >= data.promil and _ or effect
            end
            if lasteffect ~= effect then
                Config.Trips[lasteffect].stop()
                Citizen.CreateThread(function()
                    Config.Trips[effect].start(promil)
                end)
            end
            if Config.Trips[effect].ragdoll and math.random(1,100) >= 50 then
                SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, false, false, false)
            end
            if Config.Trips[effect].damage and math.random(1,100) >= 50 then
                SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId()) - 10)
            end
        else
            promil = 0
            if effect then
                -- stop
                Citizen.CreateThread(Config.Trips[effect].stop)
                effect = false
            end
        end
    end
end)
