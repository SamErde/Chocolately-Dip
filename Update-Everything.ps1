function Update-Everything {
    <#
    .SYNOPSIS
    Update all the things!

    .DESCRIPTION
    A script to automatically update all PowerShell modules, PowerShell Help, winget packages, and Chocolatey packages.

    .EXAMPLE
    PS> Update-Everything

    Updates everything it can!

    .INPUTS
    None. You can't pipe objects to Update-Everything.

    .OUTPUTS
    None. Update-Everything does not return any objects.

    .LINK
    GitHub Repository: https://github.com/SamErde/Chocolatey-Dip
    Twitter / X: https://twitter.com/SamErde

    .NOTES
    Author: Sam Erde
    Version: 0.2.0
    Modified: 2024/07/22

    Ideas to do:
        - Check for Windows or Linux
        - Check for elevation/admin rights
        - Update PowerShell
        - Update Linux packages
    #>

    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'Using colors to format interactive output')]
    [Alias("uatt")] # = "Update All The Things!"
    param ()


    # Get all installed PowerShell modules
    Write-Host "[1] Getting Installed PowerShell Modules"
    # Update the primary progress bar
    $PercentCompleteOuter = 1
    $ProgressParam0 = @{
        Id = 0
        Activity = 'Update Everything'
        CurrentOperation = 'Getting Installed PowerShell Modules'
        Status = "Progress: $PercentCompleteOuter`% Complete"
        PercentComplete = $PercentCompleteOuter
    }
    Write-Progress @ProgressParam0
    $Modules = (Get-InstalledModule)[0..15]


    # Update all PowerShell modules
    Write-Host "[2] Updating PowerShell Modules"
    # Estimate 10% progress so far and 70% at the next step
    $PercentCompleteOuter_10 = 10
    $ModuleCount = $Modules.Count
    $Module_i = 0

    foreach ($module in $Modules) {
        # Update the module loop counter and percent complete for both progress bars
        ++$Module_i
        [double]$PercentCompleteInner = [math]::ceiling((($Module_i / $ModuleCount)*100))
        [double]$PercentCompleteOuter = [math]::round( $PercentCompleteOuter_10 + (60*($PercentCompleteInner/100)), 2)

        # Update the parent progress bar
        $ProgressParam0 = @{
            Id = 0
            Activity = 'Update Everything'
            Status = "Progress: $PercentCompleteOuter`% Complete"
            PercentComplete = $PercentCompleteOuter
        }
        Write-Progress @ProgressParam0

        # Update the child progress bar
        $ProgressParam1 = @{
            Id = 1
            ParentId = 0
            Activity = 'Updating PowerShell Modules'
            CurrentOperation = "$($module.Name)"
            Status = "Progress: $PercentCompleteInner`% Complete"
            PercentComplete = $PercentCompleteInner
        }
        Write-Progress @ProgressParam1
        # Update the current module
        try {
            Update-Module $ -ErrorAction SilentlyContinue
        } catch [Microsoft.PowerShell.Commands.WriteErrorException] {
            Write-Verbose $_
        }
    }
    Write-Progress -Id 1 -Completed

    # Update PowerShell Help
    Write-Host "[3] Updating PowerShell Help"
    $PercentCompleteOuter = 70
    $ProgressParam0 = @{
        Id = 0
        Activity = 'Update Everything'
        CurrentOperation = 'Updating PowerShell Help'
        Status = "Progress: $PercentCompleteOuter`% Complete"
        PercentComplete = $PercentCompleteOuter
    }
    Write-Progress @ProgressParam0
    Update-Help -ErrorAction SilentlyContinue


    # Update all winget packages
    Write-Host "[4] Updating Winget Packages"
    $PercentCompleteOuter = 80
    $ProgressParam0 = @{
        Id = 0
        Activity = 'Update Everything'
        CurrentOperation = 'Updating Winget Packages'
        Status = "Progress: $PercentCompleteOuter`% Complete"
        PercentComplete = $PercentCompleteOuter
    }
    Write-Progress @ProgressParam0
    <# Check for Windows and/or winget.exe
    if () { }
    #>
    winget upgrade --silent --scope user --accept-package-agreements --accept-source-agreements --all


    # Upgrade Chocolatey packages
    <# Check for admin
    if () {
        Write-Information -MessageData "It is recommended to update Chocolatey while running as an administrator." -InformationAction Continue
        return
    }
    #>
    if (Get-Command "choco.exe" -ErrorAction SilentlyContinue) {
        $PercentCompleteOuter = 90
        $ProgressParam0 = @{
            Id = 0
            Activity = 'Update Everything'
            CurrentOperation = 'Updating Chocolatey Packages'
            Status = "Progress: $PercentCompleteOuter`% Complete"
            PercentComplete = $PercentCompleteOuter
        }
        Write-Progress @ProgressParam0
        Write-Host "[5] Updating Chocolatey Packages"
        choco upgrade chocolatey --limitoutput --yes
        choco upgrade all --limitoutput --yes
    } else {
        Write-Host "[5] Chocolatey is not installed. Skipping choco update."
    }

    $PercentCompleteOuter = 100
    $ProgressParam0 = @{
        Id = 0
        Activity = 'Update Everything'
        CurrentOperation = 'Finished'
        Status = "Progress: $PercentCompleteOuter`% Complete"
        PercentComplete = $PercentCompleteOuter
    }
    Write-Progress @ProgressParam0
    Write-Progress -Id 0 -Activity 'Update Everything' -Completed

}
