# Allow the current PowerShell process to bypass execution policies in order to download and run the chocolatey installer.
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n=allowGlobalConfirmation

# List all of the packages for chocolately to install. Each should be in double quotes followed by a comma.
$install = @( 
    "7zip.install",             #7-Zip
    "authy-desktop",            #Authy TFA App
    "azure-cli",                #Azure CLI Tools
    "azurepowershell",          #PowerShell Module for Azure
    "burnttoast-psmodule",      #PowerShell Module for Toast Notifications
    "carbon",                   #Carbon PowerShell Module
    "conemu",                   #ConEmu (Pop-up Console Emulator)
    "curl",                     #curl
    "dellcommandupdate",        #Dell Command Update
    "filezilla",                #FileZilla
    "firefox",                  #Firefox
    "foxitreader",              #Foxit PDF Reader
    "git.install",              #Git
    "googlechrome",             #Chrome
    "iissecurity-psmodule",     #PowerShell Module for IIS Security
    "jre8",                     #Java Runtime
    "lastpass",                 #LastPass
    "lastpass-for-applications", 
    "ntfssecurity-psmodule",    #PowerShell Module for NTFS Security
    "onenote",                  #OneNote 2016
    "orionsdk",                 #Solarwinds Orion SDK and PowerShell Module
    "poshadmin",                #PowerShell Admin
    "powershell-core",          #PowerShell 6.0 Core
    "powershellhere",           #Open a PowerShell prompt 'here'
    "putty.install",            #PuTTy
    "psget",                    #PSGet (NuGet for PowerShell)
    "rdmfree",                  #Remote Desktop Manager
    "rsat",                     #Remote Server Admin Tools
    "rvtools",                  #RVtools
    "sysinternals",             #SysInternals
    "treesizefree",             #TreeSize Free
    "vmware-powercli-psmodule", #VMware PowerCLI
    "vscode",                   #Visual Studio Code
    "vscode-docker",            #Docker Extension for VS Code
    "vscode-powershell",        #PowerShell Extension for VS Code
    "winscp",                   #WinSCP
    "youtube-dl"                #YouTube Downloader
    )

#Install each package that is listed in the multi-line string variable.
foreach ($package in $install) { choco install $package }

#Update all installed chocolately packages. Add parameter handling to the script so it can be run with the -install or -update parameters.
choco upgrade all
