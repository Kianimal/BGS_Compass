Config = {}

-- Flags for which systems to use
Config.UseCompass = true                -- Default use compass item
Config.UseMap = true                    -- Default use map item

-- Compass/map items
Config.CompassItemToCheck   = "compass"   -- Compass item in the db to check against
Config.MapItemToCheck       = "map"           -- Map item in the db to check against

-- Map types: 0 is off, 1 is normal, 2 is expanded, 3 is simple compass
Config.MapTypeNoCompass = 0             -- Map type displayed with no compass (default nothing)
Config.MapTypeOnFoot = 0                -- Map type displayed on foot (default nothing)
Config.MapTypeOnMount = 3               -- Map type displayed on horseback/vehicle (default simple compass)

-- Whether or not to use user compass value instead of MapTypeCompass values
Config.UseUserCompass = false           -- Default to not use user compass

-- Time interval to check for inventory updates and horse/foot status (in ms)
Config.TimeToCheck = 1000               -- Default 1 seconds