fx_version 'adamant'

games { 'gta5' }

script_author 'Rose'
description 'Real eastate script'

lua54 'yes'

shared_scripts {
	'config.lua',
} 

client_scripts {
	'client/*.lua',
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@ox_lib/init.lua',
	'config.lua'
}

server_scripts {
	'server/server.lua',
}