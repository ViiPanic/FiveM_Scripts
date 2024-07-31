fx_version 'cerulean'
game 'gta5'


author 'ViiPanic'
description 'Yacht Heist inspired by Angelics script'
version '1.0'

client_script {
    'client/*.lua',
}

server_script {
    'server/*.lua',
}

shared_script {
    'config.lua',
}

dependencies {
    'ps-ui',
    'untangle'
}