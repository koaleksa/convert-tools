@echo off

setlocal enabledelayedexpansion

for /f "delims=" %%a in ('dir /b /a:-d *.wav') do (
    set "fileName=%%a"
    set "newName=!fileName: =_!"
    ren "!fileName!" "!newName!"
)

for /f "delims=" %%a in ('dir /b /a:-d *.wav') do (

    set fileName=%%~na
    echo !fileName!|findstr /r /c:"_raw" >nul 

    if not errorlevel 1 (
        set fileName=!fileName:_raw=!
    ) else (
        set fileName=%%~na
    )

    echo !fileName!

    ffmpeg -i %%a -vn -c:a libvorbis -q:a 10 !fileName!_vorbis.ogg
    
)

pause