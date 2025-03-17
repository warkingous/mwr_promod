@echo off

if not exist ..\..\zonetool.exe goto ERROR_ZONETOOL_EXE_NOT_FOUND

set moddir=%cd%

if exist ..\..\zone_source goto SKIP_ZONE_SOURCE_FOLDER
:MAKE_ZONE_SOURCE_FOLDER
mkdir ..\..\zone_source
:SKIP_ZONE_SOURCE_FOLDER

copy /Y mod.csv ..\..\zone_source

if exist ..\..\zonetool goto SKIP_ZONETOOL_FOLDER
:MAKE_ZONETEOOL_FOLDER
mkdir ..\..\zonetool
:SKIP_ZONETOOL_FOLDER

rd /s /q ..\..\zonetool\mod
if exist ..\..\zonetool\mod rd /s /q ..\..\zonetool\mod

if exist ..\..\zonetool\mod goto SKIP_MOD_FOLDER
:MAKE_MOD_FOLDER
mkdir ..\..\zonetool\mod
:SKIP_MOD_FOLDER

xcopy attachments ..\..\zonetool\mod\attachments\ /EY
xcopy effects ..\..\zonetool\mod\effects\ /EY
xcopy images ..\..\zonetool\mod\images\ /EY
xcopy localizedstrings ..\..\zonetool\mod\localizedstrings\ /EY
xcopy loaded_sound ..\..\zonetool\mod\loaded_sound\ /EY
xcopy lpfcurve ..\..\zonetool\mod\lpfcurve\ /EY
xcopy maps ..\..\zonetool\mod\maps\ /EY
xcopy materials ..\..\zonetool\mod\materials\ /EY
xcopy mp ..\..\zonetool\mod\mp\ /EY
xcopy reverbsendcurve ..\..\zonetool\mod\reverbsendcurve\ /EY
xcopy sndcurve ..\..\zonetool\mod\sndcurve\ /EY
xcopy sounds ..\..\zonetool\mod\sounds\ /EY
xcopy techsets ..\..\zonetool\mod\techsets\ /EY
xcopy ui ..\..\zonetool\mod\ui\ /EY
xcopy ui_mp ..\..\zonetool\mod\ui_mp\ /EY
xcopy vision ..\..\zonetool\mod\vision\ /EY
::xcopy weapons ..\..\zonetool\mod\weapons\ /EY
xcopy xanim ..\..\zonetool\mod\xanim\ /EY
xcopy xmodel ..\..\zonetool\mod\xmodel\ /EY
xcopy xsurface ..\..\zonetool\mod\xsurface\ /EY

xcopy override ..\..\zonetool\mod\override\ /EY

cd ..\..\
zonetool.exe -buildzone mod
cd %moddir%

copy /Y ..\..\mod.ff mod.ff

pause
exit 0

:ERROR_ZONETOOL_EXE_NOT_FOUND
echo ERROR: zonetool.exe not found!
pause
exit 2