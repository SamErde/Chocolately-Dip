function Install-MyModules {
    [CmdletBinding()]
    param (
        # A switch to install all listed modules
        [Parameter(ParameterSetName = 'All')]
        [switch]$All,

        # Give the user a grid view to select which modules to install
        [Parameter(ParameterSetName = 'SelectFromList')]
        [switch]$SelectFromList,

        # Select modules by tag
        [Parameter(ParameterSetName = 'SelectFromList')]
        [Parameter(ParameterSetName = 'Tag')]
        [string]$Tag
    )
    
    begin {
        # Populate the list of modules to install
        $ModuleList = [System.Collections.ArrayList]::new()
        $null = $ModulesToInstall.Add(([PSCustomObject]@{
            Name            = 'Microsoft.PowerShell.ConsoleGuiTools'
            Description     = ''
            Url             = ''
            Tags            = @('Utilities','UI')
            UsePreRelease   = $false
        }))
        $null = $ModulesToInstall.Add(([PSCustomObject]@{
            Name            = 'PSPKI'
            Description     = ''
            Url             = ''
            Tags            = @('PKI','security','ActiveDirectory','ADCS')
            UsePreRelease   = $false
        }))
        $null = $ModuleList.Add(([PSCustomObject]@{
            Name            = 'Locksmith'
            Description     = ''
            Url             = ''
            Tags            = @('PKI','security','ActiveDirectory','ADCS')
            UsePreRelease   = $false
        }))
        $null = $ModuleList.Add(([PSCustomObject]@{
            Name            = 'Terminal-Icons'
            Description     = 'Make the Windows Terminal look better.'
            Url             = ''
            Tags            = @('Windows-Terminal','UI')
            UsePreRelease   = $false
        }))
        $null = $ModuleList.Add(([PSCustomObject]@{
            Name            = 'Posh'
            Description     = 'Make PowerShell look better...'
            Url             = ''
            Tags            = @('UI')
            UsePreRelease   = $false
        }))
        $null = $ModuleList.Add(([PSCustomObject]@{
            Name            = 'posh-git'
            Description     = 'Work with GitHub'
            Url             = ''
            Tags            = @('git')
            UsePreRelease   = $false
        }))
        $null = $ModuleList.Add(([PSCustomObject]@{
            Name            = 'PowerShellHumanizer'
            Description     = ''
            Url             = ''
            Tags            = @('UI','Utilities','Useful-Functions')
            UsePreRelease   = $false
        }))
        # Finished populating the ModuleList

        # Use the PowerShell Gallery to install modules and set it as a trusted source.
        Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

    } # begin
    
    process {
        # Let the user select modules to install from a grid view.
        if ( $SelectFromList ) {
            $GridViewTitle = 'Select the modules to install and press Enter or click OK to continue...'
        
            # Check for Out-GridView or Out-ConsoleGridView
            # Pipe the sorted module list to a grid view and save the selected list
            if ((Get-Command Out-ConsoleGridView -ErrorAction SilentlyContinue) -and ($PSVersionTable.PSVersion.Major -ge 7)) {
                [array]$ModulesToInstall = ( $ModuleList | 
                    Select-Object Name,Category,Description | 
                        Sort-Object -Property Name | 
                            Out-ConsoleGridView -OutputMode Multiple -Title $GridViewTitle )
            }
            elseif (Get-Command -Name Out-GridView -ErrorAction SilentlyContinue) {
                [array]$ModulesToInstall = ( $ModuleList | 
                    Select-Object Name,Category,Description  | 
                        Sort-Object -Property Name | 
                            Out-GridView -PassThru -Title $GridViewTitle )
            }
            else {
                # To Do: Check for admin and prompt to install features/modules or revert to 'All'.
                Write-Information "Out-GridView and Out-ConsoleGridView were not found on your system. Would you like to install them?"
            }
        }
 
        if ($All) {
            foreach ($module in $ModuleList) {
                [array]$ModulesToInstall = $ModuleList
            }
        }

        if ($Tag) {
            Write-Output "You used the Tag parameter. This will be used in the future to select all modules that have the specified tag."
        }

        # Exit instead of installing if the user did not select either switch
        if ( -not $All -and -not $SelectFromList ) {
            Write-Information -MessageData "No modules were selected for installation. Exiting..."
            break
        }

        # Install the chosen modules
        foreach ($module in $ModulesToInstall) {
            $InstallSplat = @{
                Name                = $module.Name
                AllowClobber        = $true
                AllowPrerelease     = $module.UsePrerelease
                ErrorAction         = 'Stop'
                Force               = $true
                Scope               = 'CurrentUser'
                SkipPublisherCheck  = $true
            }
            try {
                Write-Information -MessageData "`nInstalling module: $($module.Name)" -InformationAction Continue
                Install-Module @InstallSplat
                Write-Information -MessageData "Installed module: $($module.Name)" -InformationAction Continue
            }
            catch {
                Write-Error -Message "Failed to install module: $($module.Name)"
            }
        }
    }

    end {
    }
}

<#
    # Microsoft 365 and Azure
        Install-Module -Name Microsoft.Graph
        # Graph is becoming the overall go-to method for interacting with M365 and Azure, and slowly replacing other modules.

        # Install-Module -Name MSOnline
        Install-Module -Name Az
        # Install-Module -Name AzureAD
        Install-Module -Name ExchangeOnlineManagement
        Install-Module -Name MicrosoftTeams
        Install-Module -Name Microsoft.Online.SharePoint.PowerShell


    # Microsoft 3rd Party Extended
        Install-Module -Name DSInternals
        # The DSInternals PowerShell Module exposes several internal features of Active Directory and Azure Active Directory.

        Install-Module -Name PnP.PowerShell
        # Microsoft 365 Patterns and Practices PowerShell Cmdlets

        Install-Module -Name Microsoft365DSC
        # This DSC module is used to configure and monitor Microsoft tenants, including SharePoint Online, Exchange, Teams, etc.
#>
