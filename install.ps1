if (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $GlobalStopWatch = New-Object System.Diagnostics.Stopwatch
    $GlobalStopWatch.Start()
    Write-Output "`n [ START ] Configuring System Run"
    Set-ExecutionPolicy Unrestricted -Force
    $StopWatch = [System.Diagnostics.Stopwatch]::StartNew()
    $ComputerName = Get-Random -InputObject "Turing", "Knuth", "Berners-Lee", "Torvalds", "Hopper", "Ritchie", "Stallman", "Gosling", "Church", "Dijkstra", "Cooper", "Gates", "Jobs", "Wozniak", "Zuckerberg", "Musk", "Nakamoto", "Dotcom", "Snowden", "Kruskal", "Neumann"
    $StopWatch.Stop()
    $StopWatchElapsed = $StopWatch.Elapsed.TotalSeconds
    Write-Output " [ DONE ] Configuring System Run ... $StopWatchElapsed seconds`n"

    $FirstRun = Read-Host -Prompt "`n First time running script? (Y/n)"
    if ([string]::IsNullOrWhiteSpace($FirstRun) -Or $FirstRun -eq 'Y' -Or $FirstRun -eq 'y') {
        Write-Output "`n [ START ] Installing Common Requirements"
        $StopWatch = [System.Diagnostics.Stopwatch]::StartNew()
        Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        RefreshEnv
        cinst -y boxstarter
        
        $StopWatch.Stop()
        $StopWatchElapsed = $StopWatch.Elapsed.TotalSeconds
        Write-Output " [ DONE ] Installing Common Requirements ... Restarting Powershell ... start the script again
        $StopWatchElapsed seconds`n"
        Start-Process PowerShell
        exit
    }

    $WindowsUpdate = Read-Host -Prompt "`n Windows Update? (Y/n)"
    if ([string]::IsNullOrWhiteSpace($WindowsUpdate) -Or $WindowsUpdate -eq 'Y' -Or $WindowsUpdate -eq 'y') {
        Write-Output "`n [ START ] Windows Update"
        $StopWatch = [System.Diagnostics.Stopwatch]::StartNew()
        Enable-UAC
        Enable-MicrosoftUpdate
        Update-Help
        Install-WindowsUpdate -acceptEula
        Disable-WindowsUpdate
        Disable-UAC
        $StopWatch.Stop()
        $StopWatchElapsed = $StopWatch.Elapsed.TotalSeconds
        Write-Output " [ DONE ] Windows Update ... $StopWatchElapsed seconds`n"
    }

    $WindowsConfig = Read-Host -Prompt "`n Do wish configure Windows and remove unnecessary Bloatware? (Y/n)"
    if ([string]::IsNullOrWhiteSpace($WindowsConfig) -Or $WindowsConfig -eq 'Y' -Or $WindowsConfig -eq 'y') {
        Write-Output "`n [ DOING ] Setting network category to private"
        Set-NetConnectionProfile -NetworkCategory Private
        Write-Output "`n [ DOING ] Setting light theme as default"
        Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 1
        Write-Output "`n [ DOING ] Show hidden files, Show protected OS files, Show file extensions"
        Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions
        Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced HideFileExt "0"
        Write-Output "`n [ DOING ] Taskbar where window is open for multi-monitor"
        Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2
        Write-Output "`n [ DOING ] Disable Quick Access: Recent Files"
        Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowRecent -Type DWord -Value 0
        Write-Output "`n [ DOING ] Disable Quick Access: Frequent Folders"
        Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowFrequent -Type DWord -Value 0
        Stop-Process -processName: Explorer -force # This will restart the Explorer service to make this work.

        Write-Output "`n [ START ] Uninstall Windows10 Unnecessary and Blotware Apps"
        $StopWatch = [System.Diagnostics.Stopwatch]::StartNew()
        $AppXApps = @(
            "*Microsoft.BingNews*"
            "*Microsoft.GetHelp*"
            "*Microsoft.Getstarted*"
            "*Microsoft.Messaging*"
            "*Microsoft.Microsoft3DViewer*"
            "*Microsoft.MicrosoftOfficeHub*"
            "*Microsoft.MicrosoftSolitaireCollection*"
            "*Microsoft.NetworkSpeedTest*"
            "*Microsoft.Office.Sway*"
            "*Microsoft.OneConnect*"
            "*Microsoft.People*"
            "*Microsoft.Print3D*"
            "*Microsoft.SkypeApp*"
            "*Microsoft.CommsPhone*"
            "*Microsoft.WindowsAlarms*"
            "*Microsoft.WindowsCamera*"
            "*microsoft.windowscommunicationsapps*"
            "*Microsoft.WindowsFeedbackHub*"
            "*Microsoft.WindowsMaps*"
            "*Microsoft.WindowsSoundRecorder*"
            "*Microsoft.Xbox.TCUI*"
            "*Microsoft.XboxApp*"
            "*Microsoft.XboxGameOverlay*"
            "*Microsoft.XboxIdentityProvider*"
            "*Microsoft.XboxSpeechToTextOverlay*"
            "*Microsoft.ZuneMusic*"
            "*Microsoft.People*"
            "*Microsoft.ZuneVideo*"
        )
        foreach ($App in $AppXApps) {
            Write-Output " [ DOING ] Removing $App from registry"
            Get-AppxPackage -Name $App | Remove-AppxPackage -ErrorAction SilentlyContinue
            Get-AppxPackage -Name $App -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
            Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $App | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
        }
        [regex]$WhitelistedApps = 'Microsoft.Paint3D|Microsoft.WindowsCalculator|Microsoft.WindowsStore|Microsoft.Windows.Photos|CanonicalGroupLimited.UbuntuonWindows|Microsoft.XboxGameCallableUI|Microsoft.XboxGamingOverlay|Microsoft.Xbox.TCUI|Microsoft.XboxGamingOverlay|Microsoft.XboxIdentityProvider|Microsoft.MicrosoftStickyNotes|Microsoft.MSPaint*'
        Get-AppxPackage -AllUsers | Where-Object { $_.Name -NotMatch $WhitelistedApps } | Remove-AppxPackage
        Get-AppxPackage | Where-Object { $_.Name -NotMatch $WhitelistedApps } | Remove-AppxPackage
        Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -NotMatch $WhitelistedApps } | Remove-AppxProvisionedPackage -Online
        $StopWatch.Stop()
        $StopWatchElapsed = $StopWatch.Elapsed.TotalSeconds
        Write-Output " [ DONE ] Unistall Windows10 Unnecessary and Blotware Apps ... $StopWatchElapsed seconds`n"
        Write-Output "`n [ START ] Remove Unnecessary Windows Registries"
        $StopWatch = [System.Diagnostics.Stopwatch]::StartNew()
        $Keys = @(
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            #Windows File
            "HKCR:\Extensions\ContractId\Windows.File\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            #Registry keys to delete if they aren't uninstalled by RemoveAppXPackage/RemoveAppXProvisionedPackage
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            #Scheduled Tasks to delete
            "HKCR:\Extensions\ContractId\Windows.PreInstalledConfigTask\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
            #Windows Protocol Keys
            "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            #Windows Share Target
            "HKCR:\Extensions\ContractId\Windows.ShareTarget\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        )
        ForEach ($Key in $Keys) {
            Write-Output " [ DOING ] Removing $Key from registry"
            Remove-Item $Key -Recurse
        }
        $StopWatch.Stop()
        $StopWatchElapsed = $StopWatch.Elapsed.TotalSeconds
        Write-Output " [ DONE ] Remove Unnecessary Windows Registries ... $StopWatchElapsed seconds`n"
        if ($env:computername -ne $ComputerName) {
            Rename-Computer -NewName $ComputerName
        }
    }

    Write-Output " ( PRESS KEY '1' FOR EXPRESS INSTALL )
 ( PRESS KEY '2' FOR CUSTOM INSTALL )"
    $InstallationType = Read-Host -Prompt " Option"
    $AllPrograms = Get-Content 'bootstrap\w10-settings.json' | Out-String | ConvertFrom-Json
    if ($InstallationType -eq '1') {
        Write-Output "`n [ START ] Software Installation List"
        $StopWatch = [System.Diagnostics.Stopwatch]::StartNew()
        $DefaultProgram = Read-Host -Prompt "`n Use default program installation (y/N)"
        ForEach ($row in $AllPrograms.programs) {
            if ($DefaultProgram -eq 'Y' -Or $DefaultProgram -eq 'y') {
                $row.installation = $row.default
            }
        }
        $AllPrograms | ConvertTo-Json -depth 100 | Out-File -Encoding UTF8 'bootstrap\w10-settings.json'
        ForEach ($row in $AllPrograms.programs) {
            $ProgramName = $row.name
            $ProgramInstallation = $row.installation
            Write-Output "$ProgramName : $ProgramInstallation"
        }
        Start-Sleep -s 3
        $StopWatch.Stop()
        $StopWatchElapsed = $StopWatch.Elapsed.TotalSeconds
        Write-Output " [ DONE ] Software Installation List ... $StopWatchElapsed seconds`n"
    } elseif ($InstallationType -eq '2') {
        ForEach ($row in $AllPrograms.programs) {
            $ProgramName = $row.name
            $ProgramDefault = $row.default
            if ($row.default -eq $true) {
                $DefaultOption = '(Y/n)'
            }
            else {
                $DefaultOption = '(y/N)'
            }
            $ProgramOption = Read-Host -Prompt "`n Install $ProgramName ? $DefaultOption"
            if ($ProgramOption -eq 'Y' -Or $ProgramOption -eq 'y') {
                $ProgramInstallation = $true
            }
            elseif ([string]::IsNullOrWhiteSpace($ProgramOption)) {
                $ProgramInstallation = $ProgramDefault
            }
            else {
                $ProgramInstallation = $false
            }
            $row.installation = $ProgramInstallation
        }
        $AllPrograms | ConvertTo-Json -depth 100 | Out-File -Encoding UTF8 'bootstrap\w10-settings.json'
    }
    Write-Output "`n [ DOING ] Enable developer mode on the system"
    Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1
    Disable-UAC
    $Programs = @(
        #Fonts
        #Default Install
        "7zip"
        "heidisql"
        "googlechrome"
        "firefox"
        "vlc"
        "notepadplusplus.install"
        "git.install"
        "nodejs.install"
        "teamviewer"
        "winscp.install"
        "yarn"
        "googledrive"
        "cmder"
    )
    ForEach ($Program in $Programs) {
        Write-Output "`n [ START ] $Program"
        $StopWatch = [System.Diagnostics.Stopwatch]::StartNew()
        cinst -y $Program
        $StopWatch.Stop()
        $StopWatchElapsed = $StopWatch.Elapsed.TotalSeconds
        Write-Output " [ DONE ] $Program ... $StopWatchElapsed seconds`n"
    }
    $AllPrograms = Get-Content 'bootstrap\w10-settings.json' | Out-String | ConvertFrom-Json
    ForEach ($row in $AllPrograms.programs) {
        $ProgramName = $row.name
        $ProgramInstallation = $row.installation
        if ($ProgramInstallation -eq $true) {
            Write-Output "`n [ START ] $ProgramName"
            $StopWatch = [System.Diagnostics.Stopwatch]::StartNew()
            $ProgramSlug = $row.program
            Invoke-Expression ".\programs\$ProgramSlug.ps1"
            $StopWatch.Stop()
            $StopWatchElapsed = $StopWatch.Elapsed.TotalSeconds
            Write-Output " [ DONE ] $ProgramName ... $StopWatchElapsed  seconds`n"
        }
    }
    Enable-UAC
    RefreshEnv
    function Set-DefaultBrowser {
        param($defaultBrowser)
        $regKey = "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\{0}\UserChoice"
        $regKeyHttp = $regKey -f 'http'
        $regKeyHttps = $regKey -f 'https'
        switch -Regex ($defaultBrowser.ToLower()) {
            # Internet Explorer
            'ie|internet|explorer' {
                Set-ItemProperty $regKeyHttp  -name ProgId IE.HTTP
                Set-ItemProperty $regKeyHttps -name ProgId IE.HTTPS
                break
            }
            # Firefox
            'ff|firefox' {
                Set-ItemProperty $regKeyHttp  -name ProgId FirefoxURL
                Set-ItemProperty $regKeyHttps -name ProgId FirefoxURL
                break
            }
            # Google Chrome
            'cr|google|chrome' {
                Set-ItemProperty $regKeyHttp  -name ProgId ChromeHTML
                Set-ItemProperty $regKeyHttps -name ProgId ChromeHTML
                break
            }
            # Safari
            'sa*|apple' {
                Set-ItemProperty $regKeyHttp  -name ProgId SafariURL
                Set-ItemProperty $regKeyHttps -name ProgId SafariURL
                break
            }
            # Opera
            'op*' {
                Set-ItemProperty $regKeyHttp  -name ProgId Opera.Protocol
                Set-ItemProperty $regKeyHttps -name ProgId Opera.Protocol
                break
            }
        }
    }
    Set-DefaultBrowser chrome
    $GlobalStopWatch.Stop()
    $GlobalStopWatchElapsed = $StopWatch.Elapsed.TotalSeconds
    Write-Output "`n Total Execution Time ... $GlobalStopWatchElapsed seconds`n" 
} else {
    Write-Output "`n [ ERROR ] You must execute this script with administrator privileges`n"
}
