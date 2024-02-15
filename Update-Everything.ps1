function Update-Everything {
    [CmdletBinding()]
    [Alias("update")]
    param ()

    # Update all PowerShell modules
    Write-Host -ForegroundColor Yellow -BackgroundColor Black "Updating PowerShell Modules"
    Update-Module

    # Update PowerShell Help
    Write-Host -ForegroundColor Yellow -BackgroundColor Black "Updating PowerShell Help"
    Update-Help -Recurse

    # Update all winget packages
    Write-Host -ForegroundColor Yellow -BackgroundColor Black "Updating Winget Packages"
    winget upgrade --silent --scope user --accept-package-agreements --accept-source-agreements --all

    # Upgrade Chocolatey packages
    Write-Host -ForegroundColor Yellow -BackgroundColor Black "Updating Chocolatey Packages"
    choco upgrade all
}
