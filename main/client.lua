-- client.lua

-- Function to heal the player
function healPlayer()
    local playerPed = PlayerPedId() -- Get the player's Ped (character) ID
    SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed)) -- Set the player's health to the maximum
    Notify("You have been healed!") -- Notify the player
end

-- Function to display a notification
function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

-- Register the heal command
RegisterCommand('heal', function()
    TriggerServerEvent('heal:player') -- Trigger the server event to heal the player
end, false)

-- Event handler for applying the heal
RegisterNetEvent('heal:apply')
AddEventHandler('heal:apply', function()
    healPlayer() -- Call the function to heal the player
end)
