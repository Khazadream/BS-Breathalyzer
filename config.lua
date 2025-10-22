Config = {}
Config.Framework = "QB" -- ESX - QBX - QB
Config.OxInventory = true -- or true
Config.Language = "fr"
Config.Locale = {
    ["en"] = {
        nonearby = "there's no one nearby",
        donthavejob = "You don't know how to use this",
    },
    ["fr"] = {
        nonearby = "Il n'y a personne à proximité",
        donthavejob = "Vous ne savez pas comment utiliser ceci",
    }
}

Config.WhitelistedJobs = {
    ["police"] = true,
    ["sheriff"] = true,
    ["sasp"] = true,
}

Config.PromilColours = {
    {
        promil = 2,
        css = {
            color = "white",
            background = "#ff00007a",
        }
    },
    {
        promil = 0.80,
        css = {
            color = "white",
            background = "#ffb100f7",
        }
    },
    {
        promil = 0,
        css = {
            color = "white",
            background = "#5eff0073",
        }
    },

}

Config.Trips = {
    {
        promil = 0.001,
        ragdoll = false,
        damage = false,
        start = function(promil)
            print("start")
        end,
        stop = function()
            print("stop")
            SetPedIsDrunk(PlayerPedId(), false)	
            ResetPedMovementClipset(PlayerPedId(), 0.0)	
            SetPedMotionBlur(PlayerPedId(), false)
            SetTimecycleModifierStrength(0.0)
            ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        end,
    },
    {
        promil = 0.51,
        ragdoll = false,
        damage = false,
        start = function(promil)
            print("2 has started")
            SetTimecycleModifier("Bloom")
            SetTimecycleModifierStrength(1.0)
            SetPedMotionBlur(PlayerPedId(), true)
            SetPedIsDrunk(PlayerPedId(), true)
        end,
        stop = function()
            print("2 has stopped")
            SetPedIsDrunk(PlayerPedId(), false)		
            SetPedMotionBlur(PlayerPedId(), false)
            SetTimecycleModifierStrength(0.0)
        end,
    },
    {
        promil = 0.80,
        ragdoll = false,
        damage = false,
        start = function(promil)
            RequestAnimSet("MOVE_M@QUICK") 
            while not HasAnimSetLoaded("MOVE_M@QUICK") do
              Citizen.Wait(0)
            end    
            SetTimecycleModifier("Bloom")
            SetTimecycleModifierStrength(2.0)
            SetPedMotionBlur(PlayerPedId(), true)
            SetPedIsDrunk(PlayerPedId(), true)
            SetPedMovementClipset(PlayerPedId(), "MOVE_M@QUICK", true)
            ShakeGameplayCam("DRUNK_SHAKE", 1.0)
        end,
        stop = function()
            SetPedIsDrunk(PlayerPedId(), false)
            ResetPedMovementClipset(PlayerPedId(), 0.0)
            SetPedMotionBlur(PlayerPedId(), false)
            SetTimecycleModifierStrength(0.0)
            ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        end,
    },
    {
        promil = 1.0,
        ragdoll = false,
        damage = false,
        start = function(promil)
            RequestAnimSet("MOVE_M@QUICK") 
            while not HasAnimSetLoaded("MOVE_M@QUICK") do
              Citizen.Wait(0)
            end    
            SetTimecycleModifier("Bloom")
            SetTimecycleModifierStrength(10.0)
            SetPedMotionBlur(PlayerPedId(), true)
            SetPedIsDrunk(PlayerPedId(), true)
            SetPedMovementClipset(PlayerPedId(), "MOVE_M@QUICK", true)
            ShakeGameplayCam("DRUNK_SHAKE", 3.0)
        end,
        stop = function()
            SetPedIsDrunk(PlayerPedId(), false)
            ResetPedMovementClipset(PlayerPedId(), 0.0)	
            SetPedMotionBlur(PlayerPedId(), false)
            SetTimecycleModifierStrength(0.0)
            ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        end,
    },
    {
        promil = 1.5,
        ragdoll = true,
        damage = false,
        start = function(promil)
            RequestAnimSet("move_m@hobo@a") 
            while not HasAnimSetLoaded("move_m@hobo@a") do
              Citizen.Wait(0)
            end    
            SetTimecycleModifier("Bloom")
            SetTimecycleModifierStrength(10.0)
            SetPedMotionBlur(PlayerPedId(), true)
            SetPedIsDrunk(PlayerPedId(), true)
            SetPedMovementClipset(PlayerPedId(), "move_m@hobo@a", true)
            ShakeGameplayCam("DRUNK_SHAKE", 5.0)
        end,
        stop = function()
            SetPedIsDrunk(PlayerPedId(), false)	
            ResetPedMovementClipset(PlayerPedId(), 0.0)	
            SetPedMotionBlur(PlayerPedId(), false)
            SetTimecycleModifierStrength(0.0)
            ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        end,
    },
    {
        promil = 2.0,
        ragdoll = true,
        damage = true,
        start = function(promil)
            RequestAnimSet("move_m@hobo@a") 
            while not HasAnimSetLoaded("move_m@hobo@a") do
              Citizen.Wait(0)
            end    
            SetTimecycleModifier("Bloom")
            SetTimecycleModifierStrength(10.0)
            SetPedMotionBlur(PlayerPedId(), true)
            SetPedIsDrunk(PlayerPedId(), true)
            SetPedMovementClipset(PlayerPedId(), "move_m@hobo@a", true)
            ShakeGameplayCam("DRUNK_SHAKE", 10.0)
        end,
        stop = function()
            SetPedIsDrunk(PlayerPedId(), false)	
            ResetPedMovementClipset(PlayerPedId(), 0.0)	
            SetPedMotionBlur(PlayerPedId(), false)
            SetTimecycleModifierStrength(0.0)
            ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        end,
    },
}

Config.Consumables = {
    ["whiskey"] = {
        promil = 0.40,
        time = {
            min = 3000,
            max = 8000,
        },
        progress = {
            text = "Whiskey is consumed...",
            animation = {
                animDict = 'mp_player_intdrink',
                anim = 'loop_bottle',
                flags = 49
            },
            prop = {
                model = 'prop_wine_rose',
                bone = 60309,
                coords = vec3(0.0, 0.0, -0.18),
                rotation = vec3(0.0, 0.0, -40),
            },
        },
    },
    ["beer"] = {
        promil = 0.25,
        time = {
            min = 3000,
            max = 8000,
        },
        progress = {
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
        },
    },
    ["vodka"] = {
        promil = 0.20,
        time = {
            min = 3000,
            max = 8000,
        },
        progress = {
            text = "Vodka is consumed...",
            animation = {
                animDict = 'mp_player_intdrink',
                anim = 'loop_bottle',
                flags = 49
            },
            prop = {
                model = 'prop_cs_beer_bot_40oz',
                bone = 60309,
                coords = vec3(0.0, 0.0, -0.05),
                rotation = vec3(0.0, 0.0, -40),
            },
        },
    },
}


function Locale(key,subs)
    local translate = Config.Locale[Config.Language][key] and Config.Locale[Config.Language][key] or "Config.Locale["..Config.Language.."]["..key.."] doesn't exits"
    subs = subs and subs or {}
    for k, v in pairs(subs) do
        local templateToFind = '%${' .. k .. '}'
        translate = translate:gsub(templateToFind, tostring(v))
    end
    return tostring(translate)
end

Config.EnableDrugs = true -- Enable drug effects
Config.Drugs = { -- Create you own drugs

    ['joint'] = {
        label = 'Joint',
        animation = 'smoke', -- Animations: blunt, sniff, pill
        time = 60, -- Time in seconds of the Effects
        effects = { -- Effects: runningSpeedIncrease, infinateStamina, moreStrength, healthRegen, foodRegen, drunkWalk, psycoWalk, outOfBody, cameraShake, fogEffect, confusionEffect, whiteoutEffect, intenseEffect, focusEffect
            'intenseEffect',
            'healthRegen',
            --'moreStrength',
            'drunkWalk'
        },
        cooldown = 10, --360, -- Cooldown in seconds until you can use this drug again
    },
    ['cocaine'] = {
        label = 'Cocaine',
        animation = 'sniff', -- Animations: blunt, sniff, pill
        time = 60, -- Time in seconds of the Effects
        effects = { -- Effects: runningSpeedIncrease, infinateStamina, moreStrength, healthRegen, foodRegen, drunkWalk, psycoWalk, outOfBody, cameraShake, fogEffect, confusionEffect, whiteoutEffect, intenseEffect, focusEffect
            --'runningSpeedIncrease',
            'infinateStamina',
            'fogEffect',
            'psycoWalk'
        },
        cooldown = 480, -- Cooldown in seconds until you can use this drug again
    },
    ['meth'] = {
        label = 'Cocaine',
        animation = 'sniff', -- Animations: blunt, sniff, pill
        time = 60, -- Time in seconds of the Effects
        effects = { -- Effects: runningSpeedIncrease, infinateStamina, moreStrength, healthRegen, foodRegen, drunkWalk, psycoWalk, outOfBody, cameraShake, fogEffect, confusionEffect, whiteoutEffect, intenseEffect, focusEffect
            'runningSpeedIncrease',
            --'infinateStamina',
            'confusionEffect',
            'outOfBody',
            'focusEffect',
            --'drunkWalk'
        },
        cooldown = 480, -- Cooldown in seconds until you can use this drug again
    },
    ['ameth'] = {
        label = 'Amphetamine',
        animation = 'sniff', -- Animations: blunt, sniff, pill
        time = 60, -- Time in seconds of the Effects
        effects = { -- Effects: runningSpeedIncrease, infinateStamina, moreStrength, healthRegen, foodRegen, drunkWalk, psycoWalk, outOfBody, cameraShake, fogEffect, confusionEffect, whiteoutEffect, intenseEffect, focusEffect
            'runningSpeedIncrease',
            --'infinateStamina',
            'whiteoutEffect',
            --'drunkWalk'
        },
        cooldown = 480, -- Cooldown in seconds until you can use this drug again
    },
}

-- Effects: 

-- runningSpeedIncrease, 
-- infinateStamina, 
-- moreStrength, 
-- healthRegen,
-- foodRegen,

-- drunkWalk,
-- psycoWalk,

-- outOfBody,
-- cameraShake,
-- fogEffect,
-- confusionEffect,
-- whiteoutEffect,
-- intenseEffect,
-- focusEffect

-- TODO: Ajout de drogue dans verre d'alcool. (Citron, olives, oranges, cocaine, etc...)
-- TODO: Dépendance alcool / drogue.

-- Alcool + drogue : Effets alcool, pas d'effets visuels de drogue.       OKAY
-- Drogue + Alcool : Effets drogue stop + Effets plus poussé de l'alcool. OKAY