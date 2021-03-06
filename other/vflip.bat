@echo off

setlocal enabledelayedexpansion

for /f "delims=" %%i in (_extensions.txt) do (
    set extensions=!extensions! %%i
)

echo Converting following extensions: !extensions!

for /f "delims=" %%a in ('dir /b /a:-d !extensions!') do (
    set "fileName=%%a"
    set "newName=!fileName: =_!"
    ren "!fileName!" "!newName!"
)

mkdir new

for /f "delims=" %%a in ('dir /b /a:-d !extensions!') do (
    ffmpeg -i %%a -vf vflip new/%%~na.avi
)

echo Operation done!

pause