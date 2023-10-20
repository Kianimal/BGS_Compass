Config = {}

-- Flags for which systems to use
Config.UseCompass = true
Config.UseMap = false

-- Compass/map items
Config.CompassItemToCheck = "compass"
Config.MapItemToCheck = "map"

-- Map types: 0 is off, 1 is normal, 2 is expanded, 3 is simple compass
Config.MapTypeNoCompass = 0
Config.MapTypeOnFoot = 0
Config.MapTypeOnMount = 3

-- Whether or not to use user compass value instead of MapTypeCompass values
Config.UseUserCompass = false

-- Time interval to check for inventory updates and horse/foot status
Config.TimeToCheck = 1000 -- Default 1 seconds