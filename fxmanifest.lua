fx_version "cerulean"
game "gta5"

ui_page 'ui/index.html'
lua54 "yes"

files {
  'ui/**',
  '*.json'
}

shared_script {
  '@es_extended/imports.lua',
  'config.lua',
  'framework.lua'
}

client_scripts {
  "client/*.lua",
}

escrow_ingore {
  'config.lua',
  '*.json'
}

server_scripts {
  "server/*.lua"
}
