-- Register server event to check player inventory
RegisterServerEvent("BGS_Compass:checkPlayerInventory") 
AddEventHandler("BGS_Compass:checkPlayerInventory", function()
    local _source = source
    -- Get inventory and auto-set has item to false
    local hasItem = false
    -- Error check for player inventory
    local compassCount = exports.vorp_inventory:getItemCount(_source, nil, Config.CompassItemToCheck)
    if compassCount > 0 and Config.UseCompass then
        hasItem = true
        TriggerClientEvent("BGS_Compass:showMiniMap", _source)
    elseif not hasItem and Config.UseCompass then
        TriggerClientEvent("BGS_Compass:hideMiniMap", _source)
    end
    hasItem = false
    local mapCount = exports.vorp_inventory:getItemCount(_source, nil, Config.MapItemToCheck)
    if mapCount > 0 and Config.UseMap then
        hasItem = true
        TriggerClientEvent("BGS_Compass:enableMap", _source)
    elseif not hasItem and Config.UseMap then
        TriggerClientEvent("BGS_Compass:disableMap", _source)
    end
end)