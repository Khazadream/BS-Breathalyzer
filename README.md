## **BScript Development**

## The BS-Breathalyzer script offers advanced systems for measuring alcohol consumption, intoxication and alcohol. Each of these systems is explained in detail below.

# Alcohol System
This system realistically simulates the players' drinking process. When players consume a drink, they feel the effect of alcohol by switching to an animation. As a result of alcohol consumption, the player's promil value increases, determining the level of intoxication. This system ensures that different drinks have the potential to raise different promil values, so players can have different experiences based on their drinking preferences.

# Intoxication System
As your promil level increases, the intoxication effect is activated. This system allows players to experience different levels of intoxication depending on their promil. The higher the Promil, the more intense the intoxication effect the player will experience. For example, a low BAC level is limited to effects such as mild dizziness and loss of balance, while a high BAC level can lead to more severe visual and auditory impairments. This gives players a more realistic and interactive experience.

# Breathalyser System
This system authorises players with certain professions to use a breathalyser. The breathalyser allows you to measure the blood alcohol levels of nearby players. This feature is specifically designed to increase in-game interactions. The breathalyser provides users with information about the alcohol level of the player they are targeting, enriching social dynamics and role-playing elements. It should be noted that you must have the necessary authorisations to measure with the breathalyser.

https://www.youtube.com/watch?v=1EjHqLhnpkg

# Installation
## QB-Core
- Enter the QB-Core/shared/items.lua file. Insert the following code in a suitable place there.
```lua
beer                         = { name = 'beer', label = 'Beer', weight = 500, type = 'item', image = 'beer.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
    whiskey                      = { name = 'whiskey', label = 'Whiskey', weight = 500, type = 'item', image = 'whiskey.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
    vodka                        = { name = 'vodka', label = 'Vodka', weight = 500, type = 'item', image = 'vodka.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = '' },
    alcoholmeter                  = { name = 'alcoholmeter', label = 'Alcohol Meter', weight = 200, type = 'item', image = 'alcoholmeter.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Alcoholmeter' },
```
- Enter the folder qb-inventory/html/images. Put the images from the `ITEMIMAGES` folder into the qb-inventory/html/images folder.
- Go inside the Config.lua file and set the Config.Framework option to QB.
```lua
Config.Framework = "QB"
```

## ESX
- Run the ESX.sql file.
- If you are using esx_inventory/html/img/items folder and put the images in the `ITEMIMAGES` folder into this folder.
- Go inside the Config.lua file and set the Config.Framework option to ESX.
- ```lua
Config.Framework = "ESX"
```

> [CFX Release Post](https://forum.cfx.re/t/free-bs-breathalyzer-alcohol-drunk-breathalyzer-script/5279329)

# Join Discord (24/7 Support)
> [Discord](https://discord.gg/dxVJ2wxfc6)

