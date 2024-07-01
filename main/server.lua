-- server.lua

local healCooldowns = {}
local useDiscordPerms = true -- Set this to false if you don't want to use Discord permissions

-- Heal function with permissions and cooldown
RegisterCommand('heal', function(source, args, rawCommand)
    local src = source
    local playerIdentifier = GetPlayerIdentifiers(src)[1]
    local hasPermission = true

    if useDiscordPerms then
        local roleIDs = exports.Badger_Discord_API:GetDiscordRoles(src)
        if roleIDs then
            for _, roleID in ipairs(roleIDs) do
                if roleID == "HealerRole" then -- Change "HealerRole" to your desired Discord role ID
                    hasPermission = true
                    break
                end
            end
        else
            hasPermission = false
        end
    end

    if not hasPermission then
        TriggerClientEvent('chat:addMessage', src, {
            color = {255, 0, 0},
            multiline = true,
            args = {"SYSTEM", "You do not have permission to heal."}
        })
        return
    end

    if healCooldowns[playerIdentifier] and (os.time() - healCooldowns[playerIdentifier]) < 30 then
        local timeLeft = 30 - (os.time() - healCooldowns[playerIdentifier])
        TriggerClientEvent('chat:addMessage', src, {
            color = {255, 0, 0},
            multiline = true,
            args = {"SYSTEM", "You must wait " .. timeLeft .. " seconds before healing again."}
        })
        return
    end

    healCooldowns[playerIdentifier] = os.time()
    TriggerClientEvent('heal', src)
end, false)

-- Server-side heal event handler
RegisterServerEvent('heal:player')
AddEventHandler('heal:player', function()
    local src = source
    local playerIdentifier = GetPlayerIdentifiers(src)[1]
    local hasPermission = true

    if useDiscordPerms then
        local roleIDs = exports.Badger_Discord_API:GetDiscordRoles(src)
        if roleIDs then
            for _, roleID in ipairs(roleIDs) do
                if roleID == "HealerRole" then -- Change "HealerRole" to your desired Discord role ID
                    hasPermission = true
                    break
                end
            end
        else
            hasPermission = false
        end
    end

    if not hasPermission then
        TriggerClientEvent('chat:addMessage', src, {
            color = {255, 0, 0},
            multiline = true,
            args = {"SYSTEM", "You do not have permission to heal."}
        })
        return
    end

    if healCooldowns[playerIdentifier] and (os.time() - healCooldowns[playerIdentifier]) < 30 then
        local timeLeft = 30 - (os.time() - healCooldowns[playerIdentifier])
        TriggerClientEvent('chat:addMessage', src, {
            color = {255, 0, 0},
            multiline = true,
            args = {"SYSTEM", "You must wait " .. timeLeft .. " seconds before healing again."}
        })
        return
    end

    healCooldowns[playerIdentifier] = os.time()
    TriggerClientEvent('heal', src)
end)
