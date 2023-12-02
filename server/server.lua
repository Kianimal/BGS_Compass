local VORPcore = {} -- core object

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

-- Register server event to check player inventory
RegisterServerEvent("BGS_Compass:checkPlayerInventory") 
AddEventHandler("BGS_Compass:checkPlayerInventory", function()
    local _source = source
    -- Error check for player inventory
    if not VORPcore.getUser(_source) then
        return
    end
    local compassCount = exports.vorp_inventory:getItemCount(_source, nil, Config.CompassItemToCheck)
    if compassCount > 0 and Config.UseCompass then
        TriggerClientEvent("BGS_Compass:showMiniMap", _source)
    elseif compassCount == 0 and Config.UseCompass then
        TriggerClientEvent("BGS_Compass:hideMiniMap", _source)
    end

    local mapCount = exports.vorp_inventory:getItemCount(_source, nil, Config.MapItemToCheck)
    if mapCount > 0 and Config.UseMap then
        TriggerClientEvent("BGS_Compass:enableMap", _source)
    elseif mapCount == 0 and Config.UseMap then
        TriggerClientEvent("BGS_Compass:disableMap", _source)
    end
end)

RegisterServerEvent("BGS_Compass:getUserGroup", function()
    local _source = source
    TriggerClientEvent("BGS_Compass:storeUserGroup", _source, VORPcore.getUser(_source).getGroup)
end)