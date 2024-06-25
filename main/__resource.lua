-- __resource.lua

-- Resource metadata
fx_version 'cerulean'
games { 'gta5' }

author 'AcGaming'
description 'A simple heal script for FiveM'
version '1.0'

dependency 'DiscordAcePerms'

-- What to run
client_scripts {
    'client.lua' -- The client-side script
}

server_scripts {
    'server.lua' -- The server-side script
}