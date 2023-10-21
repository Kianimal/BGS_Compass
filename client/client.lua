-- Define the map types
local mapTypeOnFoot = Config.MapTypeOnFoot
local mapTypeOnMount = Config.MapTypeOnMount
local mapTypeNoCompass = Config.MapTypeNoCompass

local hasMapItem = false

-- Register show minimap event
RegisterNetEvent('BGS_Compass:showMiniMap')
AddEventHandler('BGS_Compass:showMiniMap', function()
    local player = PlayerPedId()
    local playerOnMout = IsPedOnMount(player)
    local playerOnVeh = IsPedInAnyVehicle(player)
    -- Check if player is on foot or vehicle
    if not playerOnMout and not playerOnVeh and not Config.UseUserCompass then
        SetMinimapType(mapTypeOnFoot)
    elseif playerOnMout or playerOnVeh and not Config.UseUserCompass then
        SetMinimapType(mapTypeOnMount)
    else
        return
    end
end)

--Register hide minimap event
RegisterNetEvent('BGS_Compass:hideMiniMap')
AddEventHandler('BGS_Compass:hideMiniMap', function()
    SetMinimapType(mapTypeNoCompass)
end)

-- Register show map event
RegisterNetEvent('BGS_Compass:enableMap')
AddEventHandler('BGS_Compass:enableMap', function()
    hasMapItem = true
end)

--Register hide map event
RegisterNetEvent('BGS_Compass:disableMap')
AddEventHandler('BGS_Compass:disableMap', function()
    hasMapItem = false
end)

-- Add character selected event handler to check for inventory
RegisterNetEvent("vorp:SelectedCharacter", function()
    local playerPed = PlayerPedId()
    -- Create thread loop for checking inventory on player spawn
    CreateThread(function()
        while Config.UseCompass or Config.UseMap do
            TriggerServerEvent("BGS_Compass:checkPlayerInventory")
            Citizen.Wait(Config.TimeToCheck) -- Check inventory every 5 seconds
        end
    end)
    if Config.UseMap then
        TriggerEvent("BGS_Compass:disableMap", playerPed)
    end
end)

CreateThread(function()
    while Config.UseMap do
        Wait(1)
        print("test")
        if hasMapItem then
            EnableControlAction(0, 0xE31C6A41, true)
        else
            DisableControlAction(0, 0xE31C6A41, true)
        end
    end
end)