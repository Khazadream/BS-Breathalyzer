fx_version "cerulean"
game "gta5"

ui_page 'ui/index.html'
lua54 "yes"
version "1.1"
files {
  'ui/**',
  '*.json'
}

shared_script {
  '@ox_lib/init.lua',
  --'@qbx_core/modules/lib.lua',
  --'@es_extended/imports.lua',
  'config.lua'
}

client_scripts {
  "client/*.lua",
}

escrow_ignore {
  '**/*',
}

server_scripts {
  --'versionchecker.lua',
  "server/*.lua"
}
