SET scdir=C:\Program Files\Roberts Space Industries\StarCitizenPTU
SET cfgbkpdir=%UserProfile%\Documents\SC_config_backup
SET cntrloffset=LIVE\USER\Controls\Mappings\
xcopy "%scdir%\%cntrloffset%\*" "%cfgbkpdir%\" /F /R /Y /I
rmdir /s "%scdir%\LIVE\USER"
xcopy "%cfgbkpdir%\*" "%scdir%\%cntrloffset%\"  /F /R /Y /I
echo r_displayinfo=3 > "%scdir%\LIVE\USER.cfg"