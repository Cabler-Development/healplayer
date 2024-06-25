-- server.lua

local healCooldowns = {}
local useDiscordPerms = true -- Set this to false if you don't want to use Discord permissions

-- Heal function with permissions and cooldown
RegisterCommand('heal', function(source, args, rawCommand)
    local src = source
    local playerIdentifier = GetPlayerIdentifiers(src)[1]
    local hasPermission = true

    if useDiscordPerms then
        hasPermission = exports.discord_perms:IsRolePresent(src, "HealerRole") -- Change "HealerRole" to your desired Discord role
    end

    if not hasPermission then
        TriggerClientEvent('chatMessage', src, "^1SYSTEM", {255, 0, 0}, "You do not have permission to heal.") -- Send chat message
        return
    end

    if healCooldowns[playerIdentifier] and (os.time() - healCooldowns[playerIdentifier]) < 30 then
        local timeLeft = 30 - (os.time() - healCooldowns[playerIdentifier])
        TriggerClientEvent('chatMessage', src, "^1SYSTEM", {255, 0, 0}, "You must wait " .. timeLeft .. " seconds before healing again.") -- Send chat message
        return
    end

    healCooldowns[playerIdentifier] = os.time()
    TriggerClientEvent('heal', src)
end, false)

-- Server-side heal event handler
RegisterServerEvent('heal:player')
AddEventHandler('heal:player', function()
    local src = source
    TriggerClientEvent('heal', src)
end)
