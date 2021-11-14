fx_version "cerulean"

game "gta5"


ui_page "index.html"

files {
    '*.html',
    '*.js'
}


client_scripts {
  "configuration/Config_C.json",
  "configuration/Weapon.json",
  "client.lua"
}
server_scripts {
  "server.lua"
}

