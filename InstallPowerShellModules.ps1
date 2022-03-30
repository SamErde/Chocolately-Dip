# Install PowerShell modules from PSGallery
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

# Make your prompt better:
    Install-Module -Name posh-git
    # Provides prompt with Git status summary information and tab completion for Git commands, parameters, remotes and branch names.

    Install-Module -Name oh-my-posh
    # A prompt theme engine for any shell. Will also want special fonts.

    Install-Module -Name PSScriptAnalyzer
    # PSScriptAnalyzer provides script analysis and checks for potential code defects in the scripts by applying a group of built-in or customized rules on the scripts being analyzed.


# General Infrastructure Operations
    Install-Module -Name SwisPowerShell
    # This PowerShell module contains cmdlets for managing SolarWinds Orion.

    Install-Module -Name PSPKI
    # This module contains public key infrastructure and certificate management functions.

    Install-Module -Name PSCertificateEnrollment
    # Extends the Built-In PKIClient Module.

    Install-Module -Name NTFSSecurity
    # Windows PowerShell Module for managing file and folder security on NTFS volumes.

    Install-Module -Name Carbon
    # Carbon is a PowerShell module for automating the configuration Windows 7, 8, 2008, and 2012 and automation the installation and configuration of Windows applications, websites, and services.


# Datacenter Infrastructure Configuration and Management
    Install-Module -Name Cisco.UCS.Core
    Install-Module -Name Cisco.UCS.Common
    Install-Module -Name Cisco.UCSManager
    Install-Module -Name Cisco.IMC
    Install-Module -Name Intersight.PowerShell

    Install-Module -Name Citrix-Networking
    Install-Module -Name NetScaler

    Install-Module -Name Dell.PowerStore
    Install-Module -Name Dell.Unity

    Install-Module -Name VMware.PowerCLI


# Microsoft 365 and Azure
    Install-Module -Name Microsoft.Graph
    # Graph is becoming the overall go-to method for interacting with M365 and Azure, and slowly replacing other modules.
    
    Install-Module -Name MSOnline
    Install-Module -Name Az
    Install-Module -Name AzureAD
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
