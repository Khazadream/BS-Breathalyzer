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
```lua
Config.Framework = "ESX"
```

## QBX
- Go inside the Config.lua file and set the Config.Framework option to QBX.
```lua
Config.Framework = "QBX"
```

## OX_Inventory
- Go inside the Config.lua file and set the Config.OxInventory option to true.
```lua
Config.OxInventory = true
```
- Go inside the ox_inventory/data/items.lua and insert the following code in a suitable place there.
```lua
    ["alcoholmeter"] = {
		label = "Alcoholmeter",
		weight = 1,
		stack = true,
		close = true,
		consume = 0,
		server = {
			export = 'BS-Breathalyzer.openBreathalyzer'
		}
	},

	["beer"] = {
		label = "Beer",
		weight = 1,
		stack = true,
		close = true,
		server = {
			export = 'BS-Breathalyzer.usedAlcohol'
		}
	},

	["vodka"] = {
		label = "Vodka",
		weight = 1,
		stack = true,
		close = true,
		server = {
			export = 'BS-Breathalyzer.usedAlcohol'
		}
	},

	["whiskey"] = {
		label = "Whiskey",
		weight = 1,
		stack = true,
		close = true,
		server = {
			export = 'BS-Breathalyzer.usedAlcohol'
		}
	},
```



> ### Note: In FXManifest -> shared_script, delete the line of the scripts you do not use. Otherwise it will appear as Warning on the command line. (Not an important error, just a warning. The script will not be prevented from running)