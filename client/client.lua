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
    local playerOnVeh = IsPedInAnyVehicle(player, false)
    -- Check if player is on foot or vehicle
    if not playerOnMout and not playerOnVeh and not Config.UseUserCompass then
        SetMinimapType(mapTypeOnFoot)
        DisplayRadar(true)
    elseif playerOnMout or playerOnVeh and not Config.UseUserCompass then
        SetMinimapType(mapTypeOnMount)
        DisplayRadar(true)
    else
        DisplayRadar(true)
        return
    end
end)

--Register hide minimap event
RegisterNetEvent('BGS_Compass:hideMiniMap')
AddEventHandler('BGS_Compass:hideMiniMap', function()
    if not Config.UseUserCompass then
        SetMinimapType(mapTypeNoCompass)
    else
        DisplayRadar(false)
    end
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
            Citizen.Wait(Config.TimeToCheck) -- Check inventory every X seconds
        end
    end)
    if Config.UseMap then
        TriggerEvent("BGS_Compass:disableMap", playerPed)
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        if Config.UseMap then
            if not hasMapItem then
                SetMinimapHideFow(false)
                Citizen.InvokeNative(0x632AA10BF7EA53D3, false)
                DisableControlAction(0, 0xE31C6A41, true)
                ClearGpsPlayerWaypoint()
                ClearGpsMultiRoute()
            else
                SetMinimapHideFow(true)
            end
        end
        if Config.DisableTabWheelCompass then
            if IsControlPressed(0, 0xAC4BD4F1) then
                print("menu active")
                DisplayRadar(false)
            end
        end
    end
end)