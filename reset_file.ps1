# Set the program install directory by locating the launcher install path from the registry
$ProgramName = "*RSI Launcher*"
$installdir = (Get-ChildItem "HKLM:\SOFTWARE\" |  Where-Object { $_.getValue('ShortcutName') -like $ProgramName } | ForEach-Object { $_.getValue('InstallLocation')})
$scdir = $installdir.Replace("RSI Launcher","")
####
#   USER DEFINED VARIABLES
####
# Uncomment below to manually specify a directory instead of using the launcher install location.
#[string]$scdir = "C:\Program Files\Roberts Space Industries"
# Specify the directory where you want the backup to be saved. Default is the documents directory under a folder called SC_Mappings.
[string]$cfgbkpdir = "$HOME\Documents\SC_Mappings"
# startup config file variables
[string]$userconfig = "r_displaySessionInfo = 1"
####
#   DO NOT MODIFY BELOW THIS LINE!
####
#Control file location for Live
[string]$pudir = "\StarCitizen"
#Control file location for the PTU
[string]$ptudir = "\StarCitizenPTU"
# User folder
[string]$userfolder = "\LIVE\USER"
[string]$ptuuserfolder = "\PTU\USER"
# Mappings directory
[string]$mappingdir = "\Controls\Mappings\"
# PU folders
[string]$puuser = "$scdir$pudir$userfolder"
[string]$puxmlsource = "$puuser$mappingdir"
# PTU folders
[string]$ptuuser = "$scdir$ptudir$userfolder"
[string]$ptuptuuser = "$scdir$ptudir$ptuuserfolder"
[string]$ptuxmlsource = "$ptuuser$mappingdir"
[string]$ptuptuxmlsource = "$ptuptuuser$mappingdir"
# Make a backup of all the exported xml maps also Make sure the backup directories exist, if they don't create them
if (Test-Path -path $puxmlsource) {if (!(Test-Path -path $cfgbkpdir\PU\)) {New-Item $cfgbkpdir\PU\ -Type Directory} Copy-item $puxmlsource\* -Destination $cfgbkpdir\PU\ -Force -Recurse}
if (Test-Path -path $ptuxmlsource) {if (!(Test-Path -path $cfgbkpdir\PTU\)) {New-Item $cfgbkpdir\PTU\ -Type Directory} Copy-item $ptuxmlsource\* -Destination $cfgbkpdir\PTU\ -Force -Recurse}
if (Test-Path -path $ptuptuxmlsource) {if (!(Test-Path -path $cfgbkpdir\PTU_Launcher_PTU\)) {New-Item $cfgbkpdir\PTU_Launcher_PTU\ -Type Directory} Copy-item $ptuptuxmlsource\* -Destination $cfgbkpdir\PTU_Launcher_PTU\ -Force -Recurse}
# Delete the user folder
if (Test-Path -path $puuser) { Remove-Item -Recurse -Force -LiteralPath $puuser }
if (Test-Path -path $ptuuser) { Remove-Item -Recurse -Force -LiteralPath $ptuuser }
if (Test-Path -path $ptuptuuser) { Remove-Item -Recurse -Force -LiteralPath $ptuptuuser }
# Make sure source directories exist, then restore xml files
if ((Test-Path -path $cfgbkpdir\PU\)) {New-Item $puxmlsource -Type Directory ; Copy-item $cfgbkpdir\PU\* -Destination $puxmlsource -Force -Recurse }
if ((Test-Path -path $cfgbkpdir\PTU\)) {New-Item $ptuxmlsource -Type Directory ; Copy-item $cfgbkpdir\PTU\* -Destination $ptuxmlsource  -Force -Recurse}
if ((Test-Path -path $cfgbkpdir\PTU_Launcher_PTU\)) {New-Item $ptuptuxmlsource -Type Directory ; Copy-item $cfgbkpdir\PTU_Launcher_PTU\* -Destination $ptuptuxmlsource  -Force -Recurse}
# Add user.cfg to PTU version
New-Item -Path $scdir$ptudir\LIVE -Name "USER.cfg" -ItemType "file" -Value $userconfig  -Force
New-Item -Path $scdir$ptudir\PTU -Name "USER.cfg" -ItemType "file" -Value $userconfig  -Force
# Add user.cfg to PU version
#New-Item -Path $scdir$pudir\LIVE -Name "USER.cfg" -ItemType "file" -Value $userconfig  -Force