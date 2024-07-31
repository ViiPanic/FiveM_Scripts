fx_version 'adamant'

games { 'gta5' }

script_author 'ViiPanic'
description 'Medical heist re-written, source PHOENIX STUDIOS '

lua54 'yes'

shared_scripts {
	'config.lua',
} 

client_scripts {
	'client/*.lua',
	'config.lua'
}

server_scripts {
	'server/server.lua',
}