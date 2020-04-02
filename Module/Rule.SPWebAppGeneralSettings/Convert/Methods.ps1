# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.
#region Method Functions

#Begin SPWebAppGeneralSettings region

<#
        .SYNOPSIS
            This is a placeholder for the SPWebAppGeneralSettingsRuleGetScript block.
        
        .DESCRIPTION
            
        
        .PARAMETER CheckContent
            
#>

function Get-SPWebAppGeneralSettingsRuleGetScript
{
    [CmdletBinding()]
    [OutputType([string])]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        $CheckContent
    )

    return
}

<#
    .SYNOPSIS
        Placeholder for SPWebAppGeneralSettingsRuleTestScript

    .DESCRIPTION
        
    .PARAMETER CheckContent
        
#>

function Get-SPWebAppGeneralSettingsRuleTestScript
{
    [CmdletBinding()]
    [OutputType([string])]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        $CheckContent
    )

        return
    
}

function Get-SPWebAppGeneralSettingsRuleSetScript
{
    [CmdletBinding()]
    [OutputType([string])]
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [AllowEmptyString()]
        [string[]]
        $FixText,    

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        $CheckContent
    )

        return
}

#End SPWebAppGeneralSettings region


#Begin Manual region



#End Manual region


#Begin RuleType region

<#
    .SYNOPSIS
        Labels a rule as a specific type to retrieve the proper script used to enforce the STIG rule.

    .DESCRIPTION
        This functions labels a rule as a specific type so the proper scripts can dynamically be retrieved.

    .PARAMETER CheckContent
        This is the 'CheckContent' derived from the STIG raw string and holds the query that will be returned
#>

function Get-SPWebAppGeneralSettingsRuleSubType
{
    [CmdletBinding()]
    [OutputType([string])]
    param
    (
        [Parameter(Mandatory = $true)]
        [string[]]
        $CheckContent
    )

    $content = $CheckContent -join " "

    switch ($content)
    {
        
        {
            $PSItem -Match "DoDI 8552.01" -or #V-59957
            $PSItem -Match "session time-out" -or #V-59919
            $PSItem -Match "Unique session IDs" -or #V-59977
            $PSItem -Match "MSNBC online gallery" #V-59991
        }
        {
            $ruleType = "SPWebAppGeneralSettings"
        }
<#
        {
            $PSItem -Match "Active Directory Users and Computers" -or #V-59997, V-60001
            $PSItem -Match "WSS_RESTRICTED_WPG" #V-60391
        }
        {
            $ruleType = "ActiveDirectoryDsc"
        }

        {
            $PSItem -Match "SQL Server Management Console" #V-59999, V-60003
        }
        {
            $ruleType = "SqlServerDsc" #SqlServerDsc > ServerRole
        }

        {
            $PSItem -Match "Configure information rights management" -or #V-59941, 59945, 59947, 59973
            $PSItem -Match "isolation boundary" #V-59981, V-59983
        }
        {
            $ruleType = "SPIrmSettings"
        }
        
#>   
        <#
            Default parser if not caught before now - if we end up here we haven't trapped for the rule sub-type.
            These should be able to get, test, set via Get-Query cleanly
        #>
        default
        {
            $ruleType = 'Manual'
        }
    }

    return $ruleType
}

#End RuleType region

#Begin Helper function region

function Test-VariableRequired
{
    [CmdletBinding()]
    [OutputType([string])]
    param
    (
        [Parameter(Mandatory = $true)]
        [string]
        $Rule
    )

    $requiresVariableList = @(
        ''
    )

    return ($Rule -in $requiresVariableList)
}

#End Helpfer function region