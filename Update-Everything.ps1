function Update-Everything {
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'Colors are beautiful')]
    [Alias("update")]
    param ()

    # Update all PowerShell modules
    Write-Host -ForegroundColor Yellow -BackgroundColor Black "Updating PowerShell Modules"
    Update-Module

    # Update PowerShell Help
    Write-Host -ForegroundColor Yellow -BackgroundColor Black "Updating PowerShell Help"
    Update-Help -ErrorAction SilentlyContinue

    # Update all winget packages
    Write-Host -ForegroundColor Yellow -BackgroundColor Black "Updating Winget Packages"
    winget upgrade --silent --scope user --accept-package-agreements --accept-source-agreements --all

    # Upgrade Chocolatey packages
    if (Get-Command "choco.exe" -ErrorAction SilentlyContinue) {
        Write-Host -ForegroundColor Yellow -BackgroundColor Black "Updating Chocolatey Packages"
        choco upgrade all
    } else {
        Write-Host -ForegroundColor Yellow -BackgroundColor Black "Chocolatey is not installed. Skipping choco update."
    }

}
