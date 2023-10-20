-- Import and define VORPS
local VorpCore = {}
TriggerEvent("getCore",function(core)
    VorpCore = core
end)
-- Register server event to check player inventory
RegisterServerEvent("BGS_Compass:checkPlayerInventory") 
AddEventHandler("BGS_Compass:checkPlayerInventory", function(_source)
    -- Error check for source value
    if _source then
        local user = VorpCore.getUser(_source)
        -- Error check for user value
        if user then
            -- Get inventory and auto-set has item to false
            local inventory = exports.vorp_inventory:getUserInventoryItems(_source)
            local hasItem = false
            -- Error check for player inventory
            if inventory then
                local compassCount = exports.vorp_inventory:getItemCount(_source, nil, Config.compassItemToCheck)
                if compassCount > 0 then
                    hasItem = true
                    TriggerClientEvent("BGS_Compass:showMiniMap", _source)
                end
                -- If compass not found, hide minimap
                if not hasItem and Config.useCompass then
                    TriggerClientEvent("BGS_Compass:hideMiniMap", _source)
                end
            end
            hasItem = false
            if inventory then
                local mapCount = exports.vorp_inventory:getItemCount(_source, nil, Config.mapItemToCheck)
                if mapCount > 0 then
                    hasItem = true
                    TriggerClientEvent("BGS_Compass:enableMap", _source)
                end
                if not hasItem and Config.useMap then
                    TriggerClientEvent("BGS_Compass:disableMap", _source)
                end
            end
        end
    end
end)