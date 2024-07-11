Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName PresentationFramework
Add-Type -TypeDefinition @'
using System.Runtime.InteropServices;
public class ProcessDPI {
    [DllImport("user32.dll", SetLastError=true)]
    public static extern bool SetProcessDPIAware();      
}
'@
$null = [ProcessDPI]::SetProcessDPIAware()
[System.Windows.Forms.Application]::EnableVisualStyles()

$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "Browser Downloader"
$objForm.ClientSize = '795,350'
$objForm.StartPosition = "CenterScreen"
$objForm.BackColor = "White"
$objForm.KeyPreview = $True
$objform.MaximizeBox = $False
$objForm.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog

$objForm.SuspendLayout()
$objForm.AutoScaleDimensions =  New-Object System.Drawing.SizeF(100, 100)
$objForm.AutoScaleMode  = [System.Windows.Forms.AutoScaleMode]::Dpi

$Version = New-Object System.Windows.Forms.Label
$Version.Text = "Version 1.0"
$Version.AutoSize = $true
$Version.Location = New-Object System.Drawing.Size(710,304)
$objForm.Controls.Add($Version)

###########################
#                         #
#     Browser Section     #
#                         #
###########################

#Browser GroupBox
$BrowserGroupBox = New-Object System.Windows.Forms.GroupBox
$BrowserGroupBox.Location = New-Object System.Drawing.Size(10,18)
$BrowserGroupBox.Size = New-Object System.Drawing.Size(260,275)
$BrowserGroupBox.Text = "Choose which browser you want to download :"

##########

$BlinkGroupBox = New-Object System.Windows.Forms.GroupBox
$BlinkGroupBox.Location = New-Object System.Drawing.Size(10,20)
$BlinkGroupBox.Size = New-Object System.Drawing.Size(240,70)
$BlinkGroupBox.Text = "Blink based browser"
$BrowserGroupBox.Controls.Add($BlinkGroupBox)

#Brave Box
$BraveButton = New-Object System.Windows.Forms.CheckBox
$BraveButton.text = "Brave"
$BraveButton.Checked  = $false
$BraveButton.AutoSize = $true
$BraveButton.Location = New-Object System.Drawing.Size(10,20) 
$BlinkGroupBox.Controls.Add($BraveButton)

#Ungoogled-Chromium Box
$UngoogledChromiumButton = New-Object System.Windows.Forms.CheckBox
$UngoogledChromiumButton.text = "Ungoogled-Chromium"
$UngoogledChromiumButton.Checked  = $false
$UngoogledChromiumButton.AutoSize = $true
$UngoogledChromiumButton.Location = New-Object System.Drawing.Size(10,40) 
$BlinkGroupBox.Controls.Add($UngoogledChromiumButton)

##########

$GeckoGroupBox = New-Object System.Windows.Forms.GroupBox
$GeckoGroupBox.Location = New-Object System.Drawing.Size(10,100)
$GeckoGroupBox.Size = New-Object System.Drawing.Size(240,90)
$GeckoGroupBox.Text = "Gecko based browser"
$BrowserGroupBox.Controls.Add($GeckoGroupBox)

#Firefox Box
$FirefoxButton = New-Object System.Windows.Forms.CheckBox
$FirefoxButton.text = "Firefox"
$FirefoxButton.Checked  = $false
$FirefoxButton.AutoSize = $true
$FirefoxButton.Location = New-Object System.Drawing.Size(10,20) 
$GeckoGroupBox.Controls.Add($FirefoxButton)

#Firefox ESR Box
$FirefoxESRButton = New-Object System.Windows.Forms.CheckBox
$FirefoxESRButton.text = "Firefox ESR"
$FirefoxESRButton.Checked  = $false
$FirefoxESRButton.AutoSize = $true
$FirefoxESRButton.Location = New-Object System.Drawing.Size(115,20) 
$GeckoGroupBox.Controls.Add($FirefoxESRButton)

#Librewolf Box
$LibrewolfButton = New-Object System.Windows.Forms.CheckBox
$LibrewolfButton.text = "Librewolf"
$LibrewolfButton.Checked  = $false
$LibrewolfButton.AutoSize = $true
$LibrewolfButton.Location = New-Object System.Drawing.Size(10,40) 
$GeckoGroupBox.Controls.Add($LibrewolfButton)

#Waterfox Box
$WaterfoxButton = New-Object System.Windows.Forms.CheckBox
$WaterfoxButton.text = "Waterfox"
$WaterfoxButton.Checked  = $false
$WaterfoxButton.AutoSize = $true
$WaterfoxButton.Location = New-Object System.Drawing.Size(10,60) 
$GeckoGroupBox.Controls.Add($WaterfoxButton)

#Tooltip creation
$RegistryInfo = New-Object System.Windows.Forms.ToolTip
$RegistryInfo.InitialDelay = 100     
$RegistryInfo.ReshowDelay = 100 
$RegistryInfo.SetToolTip($BrowserGroupBox, "Here, you can choose one or multiple browser to download")

$BrowserGroupBox.add_MouseEnter({

    #Capture mouse position
    $BrowserGroupBox.PointToClient([System.Windows.Forms.Control]::MousePosition)

})

$objForm.Controls.Add($BrowserGroupBox)

##################################
#                                #
#     Output Console Section     #
#                                #
##################################

#Output Console
$OutputConsoleGroupBox = New-Object System.Windows.Forms.GroupBox
$OutputConsoleGroupBox.Location = New-Object System.Drawing.Size(280,18)
$OutputConsoleGroupBox.Size = New-Object System.Drawing.Size(505,275)
$OutputConsoleGroupBox.Text = "Output Console"

$ConsoleOutput = New-Object System.Windows.Forms.RichTextBox
$ConsoleOutput.BackColor = [System.Drawing.Color]::DarkBlue
$ConsoleOutput.ForeColor = [System.Drawing.Color]::White
$ConsoleOutput.Font = New-Object System.Drawing.Font("Consolas", 10)
$ConsoleOutput.Multiline = $true
$ConsoleOutput.ScrollBars = "Vertical"
$ConsoleOutput.Location = New-Object System.Drawing.Size(10,20)
$ConsoleOutput.Size = New-Object System.Drawing.Size(485,245)
$ConsoleOutput.Anchor = "Left","Top","Right","Bottom"
$ConsoleOutput.ReadOnly = $true
$ConsoleOutput.BorderStyle = "Fixed3d"
$OutputConsoleGroupBox.Controls.Add($ConsoleOutput)

$objForm.Controls.Add($OutputConsoleGroupBox)

################################
#                              #
#     Progress Bar Section     #
#                              #
################################

$ProgressBarGroupBox = New-Object System.Windows.Forms.GroupBox
$ProgressBarGroupBox.Location = New-Object System.Drawing.Size(10,200)
$ProgressBarGroupBox.Size = New-Object System.Drawing.Size(240,60)
$ProgressBarGroupBox.Text = "Processing"
$BrowserGroupBox.Controls.Add($ProgressBarGroupBox)

$ProgressBar = New-Object System.Windows.Forms.ProgressBar
$ProgressBar.Minimum = 0
$ProgressBar.Maximum = 100
$ProgressBar.Location = new-object System.Drawing.Size(10,25)
$ProgressBar.size = new-object System.Drawing.Size(220,20)
$ProgressBarGroupBox.Controls.Add($ProgressBar)

#Dark Mode
$DarkModeButton = New-Object System.Windows.Forms.CheckBox
$DarkModeButton.text = "Dark Mode"
$DarkModeButton.Checked  = $false
$DarkModeButton.AutoSize = $true
$DarkModeButton.Location = New-Object System.Drawing.Size(15,304) 
$objForm.Controls.Add($DarkModeButton) 

$DarkModeButtonButton_OnClick = {
        if ($DarkModeButton.Checked -eq $true)
            {
                $objForm.BackColor = "#474d58"
                $objForm.ForeColor = "#ffffff"
                $BrowserGroupBox.ForeColor = "#ffffff"
                $BlinkGroupBox.ForeColor = "#ffffff"
                $GeckoGroupBox.ForeColor = "#ffffff"
                $OutputConsoleGroupBox.ForeColor = "#ffffff"
                $ProgressBarGroupBox.ForeColor = "#ffffff"
            }
        elseif ($DarkModeButton.Checked -eq $false)
            {
                $objForm.BackColor = "#ffffff"
                $objForm.ForeColor = "#000000"
                $BrowserGroupBox.ForeColor = "#000000"
                $BlinkGroupBox.ForeColor = "#000000"
                $GeckoGroupBox.ForeColor = "#000000"
                $OutputConsoleGroupBox.ForeColor = "#000000"
                $ProgressBarGroupBox.ForeColor = "#000000"
            }
    }
$DarkModeButton.Add_Click($DarkModeButtonButton_OnClick)

If((Get-ItemPropertyValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme") -eq "1"){
    $DarkModeButton.Checked = $false
    $objForm.BackColor = "#ffffff"
    $objForm.ForeColor = "#000000"
    $BrowserGroupBox.ForeColor = "#000000"
    $BlinkGroupBox.ForeColor = "#000000"
    $GeckoGroupBox.ForeColor = "#000000"
    $OutputConsoleGroupBox.ForeColor = "#000000"
    $ProgressBarGroupBox.ForeColor = "#000000"
}
Else{
    $DarkModeButton.Checked = $true
    $objForm.BackColor = "#474d58"
    $objForm.ForeColor = "#ffffff"
    $BrowserGroupBox.ForeColor = "#ffffff"
    $BlinkGroupBox.ForeColor = "#ffffff"
    $GeckoGroupBox.ForeColor = "#ffffff"
    $OutputConsoleGroupBox.ForeColor = "#ffffff"
    $ProgressBarGroupBox.ForeColor = "#ffffff"
}

#Tooltip creation
$DarkModeText = New-Object System.Windows.Forms.ToolTip
$DarkModeText.InitialDelay = 100     
$DarkModeText.ReshowDelay = 100 
$DarkModeText.SetToolTip($DarkModeButton, "You can change the application style to light or dark mode")

$DarkModeButton.add_MouseEnter({

    #Capture mouse position
    $DarkModeButton.PointToClient([System.Windows.Forms.Control]::MousePosition)

})

#Run Button
$RunButton = New-Object System.Windows.Forms.Button
$RunButton.Location = New-Object System.Drawing.Size(100,300)
$RunButton.AutoSize = $true
$RunButton.Text = "Run"
$objForm.Controls.Add($RunButton)

$objForm.ResumeLayout()

##################################
##################################

########################
#                      #
#     Color Output     #
#                      #
########################

$yellowBrush = [System.Drawing.Color]::Yellow
$greenBrush = [System.Drawing.Color]::Green
$redBrush = [System.Drawing.Color]::Red

#################################
#                               #
#     Check OS architecture     #
#                               #
#################################

If(((wmic OS Get OSArchitecture) -match "64 bits") -and (($env:PROCESSOR_ARCHITECTURE) -match "ARM64")){

    $ConsoleOutput.SelectionColor = $yellowBrush
    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
    $ConsoleOutput.ScrollToCaret()
    $ConsoleOutput.AppendText("[WARNING] Your computer run under ARM architecture. Some browsers may work but with degraded performance`r`n")
    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor

}
ElseIf(((wmic OS Get OSArchitecture) -notmatch "64 bits") -and (($env:PROCESSOR_ARCHITECTURE) -notmatch "AMD64")){

    $ConsoleOutput.SelectionColor = $redBrush
    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
    $ConsoleOutput.ScrollToCaret()
    $ConsoleOutput.AppendText("[ERROR] Unsupported architecture. This software is only made for 64 bits OS`r`n")
    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
    $RunButton.Enabled = $false

}

##########################
#                        #
#     Check Internet     #
#                        #
##########################

$AllNetConnectionProfiles = Get-NetConnectionProfile
If(($AllNetConnectionProfiles.IPv4Connectivity -eq 'Internet') -or ($AllNetConnectionProfiles.IPv6Connectivity -eq 'Internet')){
   
    $GetIPv4Interface = (Get-NetIPInterface | Select-Object InterfaceAlias, AddressFamily, ConnectionState | Where-Object ConnectionState -eq "Connected" | Where-Object InterfaceAlias -notlike "Loopback*" | Where-Object AddressFamily -eq "IPv4").InterfaceAlias
    $GetIPv6Interface = (Get-NetIPInterface | Select-Object InterfaceAlias, AddressFamily, ConnectionState | Where-Object ConnectionState -eq "Connected" | Where-Object InterfaceAlias -notlike "Loopback*" | Where-Object AddressFamily -eq "IPv6").InterfaceAlias
    $GetIPv4 = (Get-NetIPAddress | Select-Object InterfaceAlias, IPAddress, AddressFamily | Where-Object InterfaceAlias -like $GetIPv4Interface | Where-Object AddressFamily -eq "IPv4").IPAddress
    $GetIPv6 = (Get-NetIPAddress | Select-Object InterfaceAlias, IPAddress, AddressFamily | Where-Object InterfaceAlias -like $GetIPv6Interface | Where-Object AddressFamily -eq "IPv6").IPAddress
        
    If(($AllNetConnectionProfiles.IPv4Connectivity -eq 'Internet') -and ($AllNetConnectionProfiles.IPv6Connectivity -eq 'Internet')){
        $ConsoleOutput.SelectionColor = $yellowBrush
        $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
        $ConsoleOutput.ScrollToCaret()
        $ConsoleOutput.AppendText("[INFO] Connected to Internet in IPv4 and IPv6`r`n")
        $ConsoleOutput.SelectionColor = $yellowBrush
        $ConsoleOutput.AppendText("[INFO] Your IPv4 address is : $GetIPv4`r`n")
        $ConsoleOutput.SelectionColor = $yellowBrush
        $ConsoleOutput.AppendText("[INFO] Your IPv6 address is : $GetIPv6`r`n")
        $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
    }
    ElseIf($AllNetConnectionProfiles.IPv4Connectivity -eq 'Internet'){
        $ConsoleOutput.SelectionColor = $yellowBrush
        $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
        $ConsoleOutput.ScrollToCaret()
        $ConsoleOutput.AppendText("[INFO] Connected to Internet in IPv4`r`n")
        $ConsoleOutput.SelectionColor = $yellowBrush
        $ConsoleOutput.AppendText("[INFO] Your IPv4 address is : $GetIPv4`r`n")
        $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
    }
    ElseIf($AllNetConnectionProfiles.IPv6Connectivity -eq 'Internet'){
        $ConsoleOutput.SelectionColor = $yellowBrush
        $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
        $ConsoleOutput.ScrollToCaret()
        $ConsoleOutput.AppendText("[INFO] Connected to Internet in IPv6`r`n")
        $ConsoleOutput.SelectionColor = $yellowBrush
        $ConsoleOutput.AppendText("[INFO] Your IPv6 address is : $GetIPv6`r`n")
        $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
    }
}
Else{
    $ConsoleOutput.SelectionColor = $redBrush
    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
    $ConsoleOutput.ScrollToCaret()
    $ConsoleOutput.AppendText("[ERROR] You must have an internet connection`r`n")
    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
    $RunButton.Enabled = $false
}

##################################
##################################

$RunButton.Add_Click({
            
            If(($BraveButton.Checked -eq $false) -and ($UngoogledChromiumButton.Checked -eq $false) -and ($FirefoxButton.Checked -eq $false) -and ($FirefoxESRButton.Checked -eq $false) -and ($LibrewolfButton.Checked -eq $false) -and ($WaterfoxButton.Checked -eq $false)){

                $ConsoleOutput.SelectionColor = $redBrush
                $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                $ConsoleOutput.ScrollToCaret()
                $ConsoleOutput.AppendText("[ERROR] No browser selected`r`n")
                $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
            } 

            ############################
            #                          #
            #     Download Browser     #
            #                          #
            ############################            

            If($BraveButton.Checked -eq $true){
            
                $ConsoleOutput.SelectionColor = $yellowBrush
                $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                $ConsoleOutput.ScrollToCaret()
                $ConsoleOutput.AppendText("[INFO] Downloading Brave, please wait...`r`n")
                $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor

                Try{
              
                    $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee

                    $url = "https://github.com/brave/brave-browser/releases/latest/download/BraveBrowserStandaloneSetup.exe"
                    $outFile = "$env:LOCALAPPDATA\Temp\Brave-x64.exe"

                    $webClient = New-Object System.Net.WebClient
                    $webClient.DownloadFileAsync($url, $outFile)
                       
                    While($webClient.IsBusy){
                        Start-Sleep -Milliseconds 100
                        [System.Windows.Forms.Application]::DoEvents()
                    }
                        
                    $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous                   
                    
                    $ConsoleOutput.SelectionColor = $greenBrush
                    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                    $ConsoleOutput.ScrollToCaret()
                    $ConsoleOutput.AppendText("[SUCCESS] Downloading Brave completed`r`n")
                    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
                }
                Catch{
                    $ConsoleOutput.SelectionColor = $redBrush
                    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                    $ConsoleOutput.ScrollToCaret()
                    $ConsoleOutput.AppendText("[ERROR] Can't download Brave. An error has occured : $($_.Exception.Message)`r`n")
                    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
                }
                Finally{
                        $webClient.Dispose()
                }  

            }

            If($UngoogledChromiumButton.Checked -eq $true){

                $ConsoleOutput.SelectionColor = $yellowBrush
                $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                $ConsoleOutput.ScrollToCaret()
                $ConsoleOutput.AppendText("[INFO] Downloading Ungoogled-Chromium, please wait...`r`n")
                $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor

                Try{
            
                    $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee

                    $ProgressPreference = 'SilentlyContinue'
                    $GetWin64Exe = (Invoke-WebRequest -Uri "https://github.com/macchrome/winchrome/releases" -UseBasicParsing).Links.Href -like "https://github.com/macchrome/winchrome/releases/download/*.exe"
                    $url = $GetWin64Exe[0]
                    $outFile = "$env:LOCALAPPDATA\Temp\UngoogledChromium-x64.exe"

                    $webClient = New-Object System.Net.WebClient
                    $webClient.DownloadFileAsync($url, $outFile)
                       
                    While($webClient.IsBusy){
                        Start-Sleep -Milliseconds 100
                        [System.Windows.Forms.Application]::DoEvents()
                    }
                        
                    $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous                   
                    
                    $ConsoleOutput.SelectionColor = $greenBrush
                    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                    $ConsoleOutput.ScrollToCaret()
                    $ConsoleOutput.AppendText("[SUCCESS] Downloading Ungoogled-Chromium completed`r`n")
                    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
                }
                Catch{
                    $ConsoleOutput.SelectionColor = $redBrush
                    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                    $ConsoleOutput.ScrollToCaret()
                    $ConsoleOutput.AppendText("[ERROR] Can't download Ungoogled-Chromium. An error has occured : $($_.Exception.Message)`r`n")
                    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
                }
                Finally{
                        $webClient.Dispose()
                }

                $ConsoleOutput.SelectionColor = $yellowBrush
                $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                $ConsoleOutput.ScrollToCaret()
                $ConsoleOutput.AppendText("[INFO] Downloading Ungoogled-Chromium Updater, please wait...`r`n")
                $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor

                Try{
            
                    $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee

                    If(!(Test-Path -Path "$env:APPDATA\Chromium Updater")){
                        New-Item -Path "$env:APPDATA" -Name "Chromium Updater" -ItemType Directory
                    }

                    $url = "https://github.com/mkorthof/chrupd/raw/master/chrupd.cmd"
                    $outFile = "$env:APPDATA\Chromium Updater\chrupd.cmd"

                    $webClient = New-Object System.Net.WebClient
                    $webClient.DownloadFileAsync($url, $outFile)
                       
                    While($webClient.IsBusy){
                        Start-Sleep -Milliseconds 100
                        [System.Windows.Forms.Application]::DoEvents()
                    }

                    Get-ChildItem "$env:APPDATA\Chromium Updater" | ForEach-Object {
                        ## If contains UNIX line endings, replace with Windows line endings
                        if (Get-Content $_.FullName -Delimiter "`0" | Select-String "[^`r]`n")
                        {
                            $content = Get-Content $_.FullName
                            $content | Set-Content $_.FullName
                        }
                    }
                        
                    $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous                   
                    
                    $ConsoleOutput.SelectionColor = $greenBrush
                    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                    $ConsoleOutput.ScrollToCaret()
                    $ConsoleOutput.AppendText("[SUCCESS] Downloading Ungoogled-Chromium Updater completed`r`n")
                    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
                }
                Catch{
                    $ConsoleOutput.SelectionColor = $redBrush
                    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                    $ConsoleOutput.ScrollToCaret()
                    $ConsoleOutput.AppendText("[ERROR] Can't download Ungoogled-Chromium Updater. An error has occured : $($_.Exception.Message)`r`n")
                    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
                }
                Finally{
                        $webClient.Dispose()
                }

            }

            If($FirefoxButton.Checked -eq $true){

                $ConsoleOutput.SelectionColor = $yellowBrush
                $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                $ConsoleOutput.ScrollToCaret()
                $ConsoleOutput.AppendText("[INFO] Downloading Firefox, please wait...`r`n")
                $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor

                Try{
            
                    $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee

                    $GetWindowsLanguage = (Get-WinSystemLocale).Name
                    $FirefoxLanguage = $GetWindowsLanguage.Substring(0, [Math]::Min($GetWindowsLanguage.Length, 2))

                    $url = "https://download.mozilla.org/?product=firefox-msi-latest-ssl&os=win64&lang=$FirefoxLanguage"
                    $outFile = "$env:LOCALAPPDATA\Temp\Firefox-x64.msi"

                    Try{
                        $webClient = New-Object System.Net.WebClient
                        $webClient.DownloadFileAsync($url, $outFile)
                    } Catch{
                        $Exception = $_.Exception.Response
                    }

                    If($Exception.StatusCode -match "NotFound"){
                        $FirefoxLanguage = $GetWindowsLanguage
                        $webClient = New-Object System.Net.WebClient
                        $webClient.DownloadFileAsync($url, $outFile)
                    }
                       
                    While($webClient.IsBusy){
                        Start-Sleep -Milliseconds 100
                        [System.Windows.Forms.Application]::DoEvents()
                    }
                        
                    $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous                   
                    
                    $ConsoleOutput.SelectionColor = $greenBrush
                    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                    $ConsoleOutput.ScrollToCaret()
                    $ConsoleOutput.AppendText("[SUCCESS] Downloading Firefox completed`r`n")
                    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
                }
                Catch{
                    $ConsoleOutput.SelectionColor = $redBrush
                    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                    $ConsoleOutput.ScrollToCaret()
                    $ConsoleOutput.AppendText("[ERROR] Can't download Firefox. An error has occured : $($_.Exception.Message)`r`n")
                    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
                }
                Finally{
                        $webClient.Dispose()
                }
                
            }

            If($FirefoxESRButton.Checked -eq $true){

                $ConsoleOutput.SelectionColor = $yellowBrush
                $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                $ConsoleOutput.ScrollToCaret()
                $ConsoleOutput.AppendText("[INFO] Downloading Firefox ESR, please wait...`r`n")
                $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor

                Try{
            
                    $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee

                    $GetWindowsLanguage = (Get-WinSystemLocale).Name
                    $FirefoxLanguage = $GetWindowsLanguage.Substring(0, [Math]::Min($GetWindowsLanguage.Length, 2))

                    $url = "https://download.mozilla.org/?product=firefox-esr-msi-latest-ssl&os=win64&lang=$FirefoxLanguage"
                    $outFile = "$env:LOCALAPPDATA\Temp\FirefoxESR-x64.msi"

                    Try{
                        $webClient = New-Object System.Net.WebClient
                        $webClient.DownloadFileAsync($url, $outFile)
                    } Catch{
                        $Exception = $_.Exception.Response
                    }

                    If($Exception.StatusCode -match "NotFound"){
                        $FirefoxLanguage = $GetWindowsLanguage
                        $webClient = New-Object System.Net.WebClient
                        $webClient.DownloadFileAsync($url, $outFile)
                    }
                       
                    While($webClient.IsBusy){
                        Start-Sleep -Milliseconds 100
                        [System.Windows.Forms.Application]::DoEvents()
                    }
                        
                    $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous                   
                    
                    $ConsoleOutput.SelectionColor = $greenBrush
                    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                    $ConsoleOutput.ScrollToCaret()
                    $ConsoleOutput.AppendText("[SUCCESS] Downloading Firefox ESR completed`r`n")
                    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
                }
                Catch{
                    $ConsoleOutput.SelectionColor = $redBrush
                    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                    $ConsoleOutput.ScrollToCaret()
                    $ConsoleOutput.AppendText("[ERROR] Can't download Firefox ESR. An error has occured : $($_.Exception.Message)`r`n")
                    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
                }
                Finally{
                        $webClient.Dispose()
                }

            }

            If($LibrewolfButton.Checked -eq $true){

                $ConsoleOutput.SelectionColor = $yellowBrush
                $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                $ConsoleOutput.ScrollToCaret()
                $ConsoleOutput.AppendText("[INFO] Downloading Librewolf, please wait...`r`n")
                $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor

                Try{
              
                    $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee

                    $ProgressPreference = 'SilentlyContinue'
                    $GetWin64Exe = (Invoke-WebRequest -Uri "https://librewolf.net/installation/windows/" -UseBasicParsing).Links.Href -like "*windows-x86_64-setup.exe"
                    $url = $GetWin64Exe[0]
                    $outFile = "$env:LOCALAPPDATA\Temp\Librewolf-x64.exe"

                    $webClient = New-Object System.Net.WebClient
                    $webClient.DownloadFileAsync($url, $outFile)
                       
                    While($webClient.IsBusy){
                        Start-Sleep -Milliseconds 100
                        [System.Windows.Forms.Application]::DoEvents()
                    }
                        
                    $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous                   
                    
                    $ConsoleOutput.SelectionColor = $greenBrush
                    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                    $ConsoleOutput.ScrollToCaret()
                    $ConsoleOutput.AppendText("[SUCCESS] Downloading Librewolf completed`r`n")
                    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
                }
                Catch{
                    $ConsoleOutput.SelectionColor = $redBrush
                    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                    $ConsoleOutput.ScrollToCaret()
                    $ConsoleOutput.AppendText("[ERROR] Can't download Librewolf. An error has occured : $($_.Exception.Message)`r`n")
                    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
                }
                Finally{
                        $webClient.Dispose()
                }

            }

            If($WaterfoxButton.Checked -eq $true){

                $ConsoleOutput.SelectionColor = $yellowBrush
                $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                $ConsoleOutput.ScrollToCaret()
                $ConsoleOutput.AppendText("[INFO] Downloading Waterfox, please wait...`r`n")
                $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor

                Try{
              
                    $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee

                    $ProgressPreference = 'SilentlyContinue'
                    $GetWin64Exe = (Invoke-WebRequest -Uri "https://www.waterfox.net/download/" -UseBasicParsing).Links.Href -like "*WINNT_x86_64*"
                    $url = $GetWin64Exe[0]
                    $outFile = "$env:LOCALAPPDATA\Temp\Waterfox-x64.exe"

                    $webClient = New-Object System.Net.WebClient
                    $webClient.DownloadFileAsync($url, $outFile)
                       
                    While($webClient.IsBusy){
                        Start-Sleep -Milliseconds 100
                        [System.Windows.Forms.Application]::DoEvents()
                    }
                        
                    $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous                   
                    
                    $ConsoleOutput.SelectionColor = $greenBrush
                    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                    $ConsoleOutput.ScrollToCaret()
                    $ConsoleOutput.AppendText("[SUCCESS] Downloading Waterfox completed`r`n")
                    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
                }
                Catch{
                    $ConsoleOutput.SelectionColor = $redBrush
                    $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                    $ConsoleOutput.ScrollToCaret()
                    $ConsoleOutput.AppendText("[ERROR] Can't download Waterfox. An error has occured : $($_.Exception.Message)`r`n")
                    $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor
                }
                Finally{
                        $webClient.Dispose()
                }

            }

            If(
                $BraveButton.Checked -or
                $UngoogledChromiumButton.Checked -or
                $FirefoxButton.Checked -or
                $FirefoxESRButton.Checked -or
                $LibrewolfButton.Checked -or
                $WaterfoxButton.Checked
            ){
        
                $InstallationBox =  [System.Windows.MessageBox]::Show('Do you want to proceed to installation ?','Installation','YesNo','Information')

                switch ($InstallationBox){
                  
                    'Yes'{

                        If(Test-Path -Path "$env:LOCALAPPDATA\Temp\Brave-x64.exe"){
                            $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee
                            Start-Process "$env:LOCALAPPDATA\Temp\Brave-x64.exe"
                            $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
                        }
                        If(Test-Path -Path "$env:LOCALAPPDATA\Temp\UngoogledChromium-x64.exe"){
                            $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee
                            Start-Process "$env:LOCALAPPDATA\Temp\UngoogledChromium-x64.exe"
                            Start-Process "$env:APPDATA\Chromium Updater\chrupd.cmd" -ArgumentList "-name Marmaduke -channel stable -arch 64bit -force -crTask"
                            $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
                        }
                        If(Test-Path -Path "$env:LOCALAPPDATA\Temp\Firefox-x64.msi"){
                            $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee
                            Start-Process "$env:LOCALAPPDATA\Temp\Firefox-x64.msi"
                            $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
                        }
                        If(Test-Path -Path "$env:LOCALAPPDATA\Temp\FirefoxESR-x64.msi"){
                            $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee
                            Start-Process "$env:LOCALAPPDATA\Temp\FirefoxESR-x64.msi"
                            $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
                        }
                        If(Test-Path -Path "$env:LOCALAPPDATA\Temp\Librewolf-x64.exe"){
                            $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee
                            Start-Process "$env:LOCALAPPDATA\Temp\Librewolf-x64.exe"
                            $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
                        }
                        If(Test-Path -Path "$env:LOCALAPPDATA\Temp\Waterfox-x64.exe"){
                            $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee
                            Start-Process "$env:LOCALAPPDATA\Temp\Waterfox-x64.exe"
                            $ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
                        }

                    }
                    'No'{

                        $ConsoleOutput.SelectionColor = $yellowBrush
                        $ConsoleOutput.Select($ConsoleOutput.Text.Length, 0)
                        $ConsoleOutput.ScrollToCaret()
                        $ConsoleOutput.AppendText("[INFO] You can find your installation files here : '$env:LOCALAPPDATA\Temp'`r`n")
                        $ConsoleOutput.SelectionColor = $ConsoleOutput.ForeColor

                    }

                }

            }

})

[void] $objForm.ShowDialog()