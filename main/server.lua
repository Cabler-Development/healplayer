-- server.lua

-- Event handler for the heal event
RegisterServerEvent('heal:player')
AddEventHandler('heal:player', function()
    local src = source -- Get the source of the event (the player who triggered it)
    TriggerClientEvent('heal:apply', src) -- Trigger the client event to apply the heal
end)
