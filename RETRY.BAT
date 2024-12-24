@echo off

:COLORS
color 0B

:: Fetch the name of the currently connected Wi-Fi network
for /f "tokens=1,2,* delims=:" %%A in ('netsh wlan show interfaces ^| findstr /C:"SSID" ^| findstr /v "BSSID"') do set "CURRENT_WIFI=%%B"

:: Trim leading/trailing spaces
for /f "tokens=* delims= " %%A in ("%CURRENT_WIFI%") do set CURRENT_WIFI=%%A
)

:: Check if a network name was found
if "%CURRENT_WIFI%"=="" (
    echo No Wi-Fi network is currently connected.
    echo Please specify a network manually or reconnect later.
    pause
    goto :manual
) else (
echo YOU WERE PREVIOUSLY CONNECTED: "%CURRENT_WIFI%" bye bye.. disconnecting
)
CLS
COLOR 74
:: Disconnect and reconnect to the current network
netsh wlan disconnect
timeout /t 5 > nul
echo:
CLS
COLOR 03
echo:RECONNECTING...
echo on
netsh wlan connect name="%CURRENT_WIFI%"
@echo off
if %errorlevel%==0 CLS & echo Done!
:END
echo:
timeout 5
