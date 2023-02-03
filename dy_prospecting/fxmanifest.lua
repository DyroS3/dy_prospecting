fx_version "adamant"

game "gta5"

author "Dyrose"

lua54 'yes'

description "Prospecting plugin for ESX"

shared_scripts {
    '@ox_lib/init.lua'
}

dependencies {"prospecting"}
server_script "@prospecting/interface.lua"

client_script "scripts/cl_*.lua"
server_script "scripts/sv_*.lua"

client_script "config.lua"
server_script "config.lua"
