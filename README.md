# Chocolatey-Dip
Use Chocolately, Winget, and the PowerShell gallery to quickly install all of the tools and modules that I need on a new machine build.

### ChocoInstaller.ps1
Installs Chocolatey for the current user and then installs or updates all listed apps from the Chocolatey repository.  

### WingetInstaller.ps1
Installs the given list of packages from the Winget repository or from the Microsoft Store. (Signing into the Windows Store is not required if using winget 1.3 or higher.)

### InstallPowerShellModules.ps1
Installs a list of PowerShell modules that are likely to be used by an infrastructure or systems engineer.

## To Do
Replace `choco update` with choco upgrade.
Wrap in a function.
 - Define install function
 - Define update/upgrade function
 - Set default function
