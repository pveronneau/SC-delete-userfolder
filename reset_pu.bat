:: Set the program install directory
SET scdir=C:\Program Files\Roberts Space Industries
:: Where you want the backup to be saved, default is the documents directory under a folder called SC_config_backup
SET cfgbkpdir=%UserProfile%\Documents\SC_config_backup
:: Control file location for the PTU
::SET StarCitizenPTU\LIVE\USER\Controls\Mappings
:: Control file location for Live
SET cntrloffset=StarCitizen\LIVE\USER\Controls\Mappings
:: Make a backup of all the exported xml maps
xcopy "%scdir%\%cntrloffset%\*" "%cfgbkpdir%\" /F /R /Y /I
:: delete the user folder, add /q if you don't want it to prompt
rmdir /s "%scdir%\StarCitizen\LIVE\USER"
:: copy back the exported xml maps
xcopy "%cfgbkpdir%\*" "%scdir%\%cntrloffset%\"  /F /R /Y /I
:: Turn on the FPS counter
::echo r_displayinfo=3 > "%scdir%\StarCitizen\LIVE\USER.cfg"
:: Run the launcher
"%scdir%\RSI Launcher\RSI Launcher.exe"