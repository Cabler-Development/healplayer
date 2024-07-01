-- client.lua

-- Function to heal the player
function HealPlayer()
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

-- Client-side heal event handler
RegisterNetEvent('heal')
AddEventHandler('heal', function()
    HealPlayer() -- Call the heal function
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
w