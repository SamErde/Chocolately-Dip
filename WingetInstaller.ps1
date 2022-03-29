# Requires Winget via the Desktop App Installer package and the VC Lib 140 prerequesite.

winget install -e --id Microsoft.PowerShell
winget install -e --id JanDeDobbeleer.OhMyPosh

winget install -e --id Microsoft.VisualStudioCode
winget install -e --id Git.Git
winget install -e --id Microsoft.GitCredentialManagerCore
winget install -e --id GitHub.GitHubDesktop

winget install -e --id Twilio.Authy
winget install -e --id LogMeIn.LastPass

winget install -e --id Microsoft.PowerToys
winget install -e --id 7zip.7zip
winget install -e --id Dell.CommandUpdate
winget install -e --id Devolutions.RemoteDesktopManagerFree
winget install -e --id WinSCP.WinSCP
winget install -e --id SlackTechnologies.Slack

# PowerShell Modules
# Install these for Windows PowerShell 5.1 and PowerShell Core 7+
Install-Module Microsoft.Graph
Install-Module AzureAD
Install-Module Az
Install-Module ExchangeOnlineManagement
