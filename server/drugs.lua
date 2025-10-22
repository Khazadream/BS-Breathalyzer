exports('takeDrug', function(event, item, inventory, slot, data)

    if Config.Debug then lib.print.info('takeDrug', item) end

    local drug = item.name
    if event == 'usingItem' then -- EVENT MIGHT BE usingItem
        local src = inventory.id
        local currentDrug = lib.callback.await('BS-Breathalyzer:client:getCurrentDrugEffect', src)
        if Config.Debug then lib.print.info('currentDrug', currentDrug) end
        if not currentDrug then

            local isDrugOnCooldown = lib.callback.await('BS-Breathalyzer:client:isDrugOnCooldown', src, drug)
            if isDrugOnCooldown then
                -- ShowNotification(src, _U('NOTIFICATION__DRUG__COOLDOWN'), "info")
                --TODO: Change to QBCore notify
                return
            end

            TriggerClientEvent('BS-Breathalyzer:client:takeDrug', src, drug)
            exports.ox_inventory:RemoveItem(src, item, 1, nil, slot) -- ADDED THIS ONE TO REMOVE ITEM, on ox_inventory consume = 0
        
        else
            --ShowNotification(src, _U('NOTIFICATION__DRUG__ALREADY'), "info")
            --TODO: Change to QBCore notify
        end
    end
end)