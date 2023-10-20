-- Register server event to check player inventory
RegisterServerEvent("BGS_Compass:checkPlayerInventory") 
AddEventHandler("BGS_Compass:checkPlayerInventory", function()
    local _source = source
    -- Get inventory and auto-set has item to false
    local hasItem = false
    -- Error check for player inventory
    local compassCount = exports.vorp_inventory:getItemCount(_source, nil, Config.compassItemToCheck)
    if compassCount > 0 then
        hasItem = true
        TriggerClientEvent("BGS_Compass:showMiniMap", _source)
    end
    -- If compass not found, hide minimap
    if not hasItem and Config.useCompass then
        TriggerClientEvent("BGS_Compass:hideMiniMap", _source)
    end
    hasItem = false
    local mapCount = exports.vorp_inventory:getItemCount(_source, nil, Config.mapItemToCheck)
    if mapCount > 0 then
        hasItem = true
        TriggerClientEvent("BGS_Compass:enableMap", _source)
    end
    if not hasItem and Config.useMap then
        TriggerClientEvent("BGS_Compass:disableMap", _source)
    end
end)