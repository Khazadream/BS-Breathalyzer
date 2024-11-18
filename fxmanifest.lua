fx_version "cerulean"
game "gta5"

ui_page 'ui/index.html'
lua54 "yes"
version "1.0"
files {
  'ui/**',
  '*.json'
}

shared_script {
  '@es_extended/imports.lua',
  'config.lua'
}

client_scripts {
  "client/*.lua",
}

escrow_ingore {
  'config.lua',
  '*.json'
}

server_scripts {
  'versionchecker.lua',
  "server/*.lua"
}
