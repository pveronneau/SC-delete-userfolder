#Set the program install directory
$ProgramName = "*RSI Launcher*"
$installdir = (Get-ChildItem "HKLM:\SOFTWARE\" |  Where-Object { $_.getValue('ShortcutName') -like $ProgramName } | ForEach-Object { $_.getValue('InstallLocation')})
$scdir = $installdir.Replace("RSI Launcher","")
# Uncomment to manually specify
#[string]$scdir = "C:\Program Files\Roberts Space Industries"
#Where you want the backup to be saved, default is the documents directory under a folder called SC_config_backup
[string]$cfgbkpdir = "$HOME\Documents\SC_Mappings"
#Control file location for Live
[string]$pudir = "\StarCitizen"
#Control file location for the PTU
[string]$ptudir = "\StarCitizenPTU"
# User folder
[string]$userfolder = "\LIVE\USER"
# Mappings directory
[string]$mappingdir = "\Controls\Mappings\"
# PU folders
[string]$puuser = "$scdir$pudir$userfolder"
[string]$puxmlsource = "$puuser$mappingdir"
# PTU folders
[string]$ptuuser = "$scdir$ptudir$userfolder"
[string]$ptuxmlsource = "$ptuuser$mappingdir"
# startup config file variables
[string]$userconfig = "r_displayinfo=3"
# Make sure the backup directories exist, if they don't create them
if (!(Test-Path -path $cfgbkpdir\PU\)) {New-Item $cfgbkpdir\PU\ -Type Directory}
if (!(Test-Path -path $cfgbkpdir\PTU\)) {New-Item $cfgbkpdir\PTU\ -Type Directory}
#Make a backup of all the exported xml maps
if (Test-Path -path $puxmlsource) {Copy-item $puxmlsource\* -Destination $cfgbkpdir\PU\ -Force -Recurse}
if (Test-Path -path $ptuxmlsource) {Copy-item $ptuxmlsource\* -Destination $cfgbkpdir\PTU\ -Force -Recurse}
# Delete the user folder
Remove-Item -Recurse -Force -LiteralPath $puuser
Remove-Item -Recurse -Force -LiteralPath $ptuuser
# Make sure source directories exist
if (!(Test-Path -path $puxmlsource)) {New-Item $puxmlsource -Type Directory}
if (!(Test-Path -path $ptuxmlsource)) {New-Item $ptuxmlsource -Type Directory}
# Restore xml files
Copy-item $cfgbkpdir\PU\* -Destination $puxmlsource -Force -Recurse
Copy-item $cfgbkpdir\PTU\* -Destination $ptuxmlsource  -Force -Recurse
# Add user.cfg to PTU version
New-Item -Path $scdir$ptudir\LIVE -Name "USER.cfg" -ItemType "file" -Value $userconfig  -Force