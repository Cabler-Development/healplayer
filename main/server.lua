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
        TriggerClientEvent('chatMessage', src, "You do not have permission to heal.")
        return
    end

    if healCooldowns[playerIdentifier] and (os.time() - healCooldowns[playerIdentifier]) < 30 then
        local timeLeft = 30 - (os.time() - healCooldowns[playerIdentifier])
        TriggerClientEvent('chatMessage', src, "You must wait " .. timeLeft .. " seconds before healing again.")
        return
    end

    healCooldowns[playerIdentifier] = os.time()
    TriggerClientEvent('heal', src)
end, false)
