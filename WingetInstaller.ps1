# Requires Winget via the Desktop App Installer package and the VC Lib 140 prerequesite.
$install = @(
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

param(
  [Parameter(Mandatory=$False)]
  [switch]$install,
  [switch]$update
)

If($install){
#Install each package that is listed in the multi-line string variable.
foreach ($package in $install) { winget install -e --id $package }
}

If($update){
#Update all installed winget packages. This will ugprade all packages which are installed on the computer and which are located in the msstore or winget sources.
#Running this command will also upgrade packages which were installed directly but for which there is a package in the msstore or winget sources.
winget upgrade -e --accept-package-agreements --all
}