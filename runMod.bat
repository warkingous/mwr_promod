@echo off

set "map=mp_backlot"

cd ..\..\
start h1-mod_dev.exe -multiplayer +set fs_game "mods\promod" +set g_gametype war +set developer_script 2 +devmap %map%