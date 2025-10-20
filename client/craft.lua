
-- TODO: Check if player as enought items to craft

local defautls = {
    alcohol = 'vodka',
    alcoholDose = 0,
    soft = 'none',
    quantity = 0
}

local function openCraftMenu()

    local heading = "Mixeur de boissons"

    local rows = {
        {
            type = 'select',
            label = "Type d'alcohol",
            options = {
                {
                    value = 'vodka',
                    label = 'Vodka',
                },
                {
                    value = 'whisky',
                    label = 'Whisky',
                },
            },
            placeholder = 'This is a placeholder',
            --icon = 'icon?',
            required = true,
            default = defaults and defaults.alcohol or 'vodka',
        },
        {
            type = 'slider',
            label = "Dose d'alcohol",
            placeholder = 'This is a placeholder',
            --icon = 'icon?',
            required = true,
            default = defaults and defaults.alcoholDose or 0,
            min = 0,
            max = 5,
            step = 1
        },
        {
            type = 'select',
            label = "Soft",
            options = {
                {
                    value = 'none',
                    label = "Aucun",
                },
                {
                    value = 'orange_juice',
                    label = "Jus d'Orange",
                },
                {
                    value = 'sprunk',
                    label = 'Sprunk',
                },
                {
                    value = 'tomato_juice',
                    label = 'Jus de tomate',
                },
                {
                    value = 'coffee',
                    label = 'Café',
                },
                {
                    value = 'peket',
                    label = 'Peket',
                },
                {
                    value = 'cola',
                    label = 'Cola',
                },
                {
                    value = 'ananas_juice',
                    label = "Jus d'ananas",
                },
            },
            placeholder = 'This is a placeholder',
            --icon = 'icon?',
            required = true,
            default = defaults and defaults.soft or 'none',
        },
        {
            type = 'number',
            label = 'Nombre de cocktails ?',
            placeholder = '1',
            --icon = 'icon?',
            required = true,
            default = defaults and defaults.quantity or 1,
            min = 1,
            max = 10,
            step = 1
        },
    }

    local options = {
        allowCancel = true,
        size = "md"
    }


    local input = lib.inputDialog(heading, rows, options)
    if input ~= nil then
        defaults = {
            alcohol = input[1],
            alcoholDose = input[2],
            soft = input[3],
            quantity = input[4]
        }

        TriggerServerEvent("BS-Breathalyzer:server:craft", defaults)

    end
end

RegisterNetEvent('BS-Breathalyzer:client:openCraftMenu', function()

end)






















RegisterCommand('khaza-craft-cocktails', function()
    openCraftMenu()
end)