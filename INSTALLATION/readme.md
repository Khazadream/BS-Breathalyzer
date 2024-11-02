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
