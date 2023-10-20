-- Define the map types
local mapTypeOnFoot = Config.MapTypeOnFoot
local mapTypeOnMount = Config.MapTypeOnMount
local mapTypeNoCompass = Config.MapTypeNoCompass

local hasMapItem = false

-- Register show minimap event
RegisterNetEvent('BGS_Compass:showMiniMap')
AddEventHandler('BGS_Compass:showMiniMap', function(_source)
    local player = PlayerPedId()
    local playerOnMout = IsPedOnMount(player)
    local playerOnVeh = IsPedInAnyVehicle(player)
    -- Check if player is on foot or vehicle
    if not playerOnMout and not playerOnVeh then
        SetMinimapType(mapTypeOnFoot)
    elseif playerOnMout or playerOnVeh then
        SetMinimapType(mapTypeOnMount)
    end
end)

--Register hide minimap event
RegisterNetEvent('BGS_Compass:hideMiniMap')
AddEventHandler('BGS_Compass:hideMiniMap', function(_source)
    SetMinimapType(mapTypeNoCompass)
end)

-- Register show map event
RegisterNetEvent('BGS_Compass:enableMap')
AddEventHandler('BGS_Compass:enableMap', function(_source)
    hasMapItem = true
    if hasMapItem then
        EnableControlAction(0, 0xE31C6A41, true)
    end
end)

--Register hide map event
RegisterNetEvent('BGS_Compass:disableMap')
AddEventHandler('BGS_Compass:disableMap', function(_source)
    hasMapItem = false
    CreateThread(function()
        if hasMapItem then
            TerminateThisThread()
        end
        while Config.useMap and not hasMapItem do
            DisableControlAction(0, 0xE31C6A41, true)
            Citizen.Wait(0) -- Check inventory every 5 seconds
        end
    end)
end)

-- Add character selected event handler to check for inventory
RegisterNetEvent("vorp:SelectedCharacter", function()
    local playerPed = PlayerPedId()
    -- Create thread loop for checking inventory on player spawn
    CreateThread(function()
        while Config.useCompass or Config.useMap do
            TriggerServerEvent("BGS_Compass:checkPlayerInventory")
            Citizen.Wait(Config.TimeToCheck) -- Check inventory every 5 seconds
        end
    end)
    if Config.useMap then
        TriggerEvent("BGS_Compass:disableMap", playerPed)
    end
end)