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

-- Client-side heal event handler
RegisterNetEvent('heal')
AddEventHandler('heal', function()
    local playerPed = PlayerPedId()
    SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
    Notify("You have been healed!") -- Use the Notify function for consistency
end)

-- Event to display chat messages
RegisterNetEvent('chatMessage')
AddEventHandler('chatMessage', function(author, color, text)
    TriggerEvent('chat:addMessage', {
        color = color,
        multiline = true,
        args = { author, text }
    })
end)
