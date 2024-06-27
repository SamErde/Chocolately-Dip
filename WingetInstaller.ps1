function Start-WinDip {

[CmdletBinding()]
param(
  [switch]$InstallApps,
  [switch]$UpdateApps,
  [switch]$InstallWinget
)

# Requires Winget via the Desktop App Installer package and the VC Lib 140 prerequesite.
$Packages = @(
  "Microsoft.PowerShell"
  "JanDeDobbeleer.OhMyPosh"
  "Microsoft.VisualStudioCode"
  "Git.Git"
  "Microsoft.GitCredentialManagerCore"
  "GitHub.GitHubDesktop"
  "Twilio.Authy"
  "LogMeIn.LastPass"
  "Microsoft.PowerToys"
  "7zip.7zip"
  "Dell.CommandUpdate"
  "Devolutions.RemoteDesktopManagerFree"
  "WinSCP.WinSCP"
  "SlackTechnologies.Slack"
)

if ($InstallApps) {
    #Install each package that is listed in the multi-line string variable.
    foreach ($package in $Packages) {
        winget install -e --id $package
    }
}

if ($UpdateApps) {
    #Update all installed winget packages. This will ugprade all packages which are installed on the computer and which are located in the msstore or winget sources.
    #Running this command will also upgrade packages which were installed directly but for which there is a package in the msstore or winget sources.
    winget upgrade -e --accept-package-agreements --all
}

if ($InstallWinget) {
    if (!(Test-Path -Path "$Env:WinDir\Temp\WinGetInstall")) {
        New-Item -ItemType Directory -Name "WinGetInstall" -Path "$Env:WinDir\Temp"
    }
    Set-Location -Path "$Env:WinDir\Temp\WinGetInstall"

    $DownloadLinks = ( ((Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/latest" -UseBasicParsing).Links).Where({
        $_.outerHtml -like "*/releases/download/*" }) ).href | ForEach-Object {
            -join ("https://github.com", $_)
        }

    ForEach ($Link in $DownloadLinks) {
        $FileName = $Link -replace '^.*/'
        Invoke-WebRequest -Uri $Link -OutFile $FileName
    }

    $Packages = $DownloadLinks.Where({ $_ -like "*.msixbundle" }) | ForEach-Object {
        $_ -replace '^.*/'
    }

    # Add step to install the package.
        # Add-AppxPackage only works in Windows PowerShell (not 7).
        # Invoke-Item is interactive and probably should not be used for deployment scripts.
}

}

Start-WinDip
