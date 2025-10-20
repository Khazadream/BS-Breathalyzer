local function GetCocktailName(alcohol, soft)
    for k, v in pairs(Server.Recipe) do
        if k == alcohol then
            for i, j in pairs(v) do
                if i == soft then
                    return j
                end
            end
        end
    end
    return false
end

RegisterNetEvent('BS-Breathalyzer:server:craft', function(recipe)
    local src = source

    local quantity = recipe.quantity

    local alcohol = recipe.alcohol
    local alcoholQuantity = recipe.alcoholDose * quantity
    local soft = recipe.soft
    local softQuantity = 1 * quantity

    if soft == 'none' then
        softQuantity = 0
    end
    if alcohol == 'none' then
        alcoholQuantity = 0
    end

    local recipeResult = GetCocktailName(alcohol, soft)

    if not recipeResult then
        --TODO: Notify that recipe is not correct.
        return
    end

    local alcoholCount = exports.ox_inventory:GetItemCount(src, alcohol)
    local softCount = exports.ox_inventory:GetItemCount(src, soft)

    local hasEnoughAlcohol = false
    if alcoholCount >= alcoholQuantity or alcoholQuantity == 0 then
        hasEnoughAlcohol = true
    end

    local hasEnoughSoft = false
    if softCount >= softQuantity or softQuantity == 0 then
        hasEnoughSoft = true
    end

    if hasEnoughSoft and hasEnoughAlcohol then
        exports.ox_inventory:RemoveItem(src, alcohol, alcoholQuantity)
        exports.ox_inventory:RemoveItem(src, soft, softQuantity)
        local metadata = {
            label = recipeResult.label,
            image = recipeResult.image,
            promil = 0.1 * recipe.alcoholDose,
            progress = {
                text = recipeResult.label .." is consumed...",
                animation = {
                    animDict = 'mp_player_intdrink',
                    anim = 'loop_bottle',
                    flags = 49
                },
                prop = {
                    model = recipeResult.prop or 'prop_amb_beer_bottle',
                    bone = 60309,
                    coords = vec3(0.0, 0.0, -0.05),
                    rotation = vec3(0.0, 0.0, -40),
                },
            }
        }
        exports.ox_inventory:AddItem(src, recipeResult.itemName, quantity, metadata)
    else 
        --TODO: Notify not enough items to player.
    end
end)