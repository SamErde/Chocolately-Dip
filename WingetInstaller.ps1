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

foreach ($package in $install) { winget install -e --id $package }
