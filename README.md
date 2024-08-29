# Chocolatey-Dip

> [!NOTE]
> The functionality in Chocolatey-Dip and Win-Dip is being moved to the new [PSPreworkout](https://github.com/SamErde/PSPreworkout) repository.

Use Chocolately, Winget, and the PowerShell gallery to quickly install all of the tools and modules that I need on a new machine build.

### ChocoInstaller.ps1

Installs Chocolatey for the current user and then installs or updates all listed apps from the Chocolatey repository.

### WingetInstaller.ps1

Installs the given list of packages from the Winget repository or from the Microsoft Store. (Signing into the Windows Store is not required if using winget 1.3 or higher.)

### Install-MyModules.ps1

Installs a list of PowerShell modules that are likely to be used by an infrastructure or systems engineer.
