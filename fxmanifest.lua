fx_version 'cerulean'
game 'gta5'
author 'PrimeState'
version '1.0.0'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua',
    '@oxmysql/lib/MySQL.lua',
}

files {
    'nui/index.html',
    'nui/style.css',
    'nui/script.js',
    'nui/images/*.png'
}

ui_page 'nui/index.html'

dependencies {
    'qb-core',
    'ox_lib',
    'ox_inventory',
    'oxmysql'
}
escrow_ignore {
    'config.lua'
}
