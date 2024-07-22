function Update-Everything {
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'Colors are beautiful')]
    [Alias("update")]
    param ()


    # Get all installed PowerShell modules
    Write-Host -ForegroundColor Yellow -BackgroundColor Black "Getting Installed PowerShell Modules"
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
    $Modules = Get-Module -ListAvailable | Where-Object {$_.RepositorySourceLocation -ne "*"}


    # Update all PowerShell modules
    Write-Host -ForegroundColor Yellow -BackgroundColor Black "Updating PowerShell Modules"
    # Estimate 10% progress so far and 70% at the next step
    $PercentCompleteOuter = 10
    $ModuleCount = $Modules.Count
    $Module_i = 0

    foreach ($module in $Modules) {
        # Update the module loop counter and percent complete for both progress bars
        ++$Module_i
        [int]$PercentCompleteInner = [math]::ceiling((($Module_i / $ModuleCount)*100))
        $PercentCompleteOuter = [math]::Round(($PercentCompleteOuter + ($PercentCompleteInner / 70)),2)

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
            Activity = "Updating PowerShell Modules"
            CurrentOperation = "$($module.Name)"
            Status = "Progress: $PercentCompleteInner`% Complete"
            PercentComplete = $PercentCompleteInner
        }
        Write-Progress @ProgressParam1
        # Update the current module
        Update-Module $module
    }


    # Update PowerShell Help
    Write-Host -ForegroundColor Yellow -BackgroundColor Black "Updating PowerShell Help"
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
    Write-Host -ForegroundColor Yellow -BackgroundColor Black "Updating Winget Packages"
    $PercentCompleteOuter = 80
    $ProgressParam0 = @{
        Id = 0
        Activity = 'Update Everything'
        CurrentOperation = 'Updating Winget Packages'
        Status = "Progress: $PercentCompleteOuter`% Complete"
        PercentComplete = $PercentCompleteOuter
    }
    Write-Progress @ProgressParam0
    winget upgrade --silent --scope user --accept-package-agreements --accept-source-agreements --all

    # Upgrade Chocolatey packages
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
        Write-Host -ForegroundColor Yellow -BackgroundColor Black "Updating Chocolatey Packages"
        choco upgrade all
    } else {
        Write-Host -ForegroundColor Yellow -BackgroundColor Black "Chocolatey is not installed. Skipping choco update."
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

}
