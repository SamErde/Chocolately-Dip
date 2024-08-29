function Start-ChocolateyDip {

    [CmdletBinding()]
    param(
        [switch]$InstallApps,
        [switch]$UpdateApps,
        [switch]$InstallChocolately
    )

    choco feature enable -n=allowGlobalConfirmation

    # List all of the packages for chocolately to install. Each should be in double quotes followed by a comma.
    $Packages = @(
        '7zip.install', #7-Zip
        'azure-cli', #Azure CLI Tools
        'curl', #curl
        'filezilla', #FileZilla
        'firefox', #Firefox
        'git.install', #Git
        'googlechrome', #Chrome
        'lastpass', #LastPass
        'lastpass-for-applications',
        'ntfssecurity-psmodule', #PowerShell Module for NTFS Security
        'poshadmin', #PowerShell Admin
        'putty.install', #PuTTy
        'rdmfree', #Remote Desktop Manager
        'rsat', #Remote Server Admin Tools
        'rvtools', #RVtools
        'sysinternals', #SysInternals
        'treesizefree', #TreeSize Free
        'vscode', #Visual Studio Code
        'vscode-powershell', #PowerShell Extension for VS Code
        'winscp', #WinSCP
        'youtube-dl'                #YouTube Downloader
    )

    If ($InstallApps) {
        #Install each package that is listed in the multi-line string variable.
        foreach ($package in $Packages) { choco install $package }
    }

    If ($UpdateApps) {
        #Update all installed chocolately packages.
        choco upgrade all
    }

    If ($InstallChocolately) {
        # Allow the current PowerShell process to bypass execution policies in order to download and run the chocolatey installer.
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }

}

Function CheckChocolateyInstall {
    # Test for installation of Chocolatey
}

Start-ChocolateyDip
