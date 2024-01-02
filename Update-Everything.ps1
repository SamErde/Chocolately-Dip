function Update-Everything {
    [CmdletBinding()]
    [Alias("upupdate")]
    param ()

    # Update all PowerShell modules
    Update-Module

    # Update all winget packages
    winget upgrade --silent --scope user --accept-package-agreements --accept-source-agreements --all

    # Upgrade Chocolatey packages
    choco upgrade all

}
