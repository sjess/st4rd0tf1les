cinst -y vscode

$Extensions = @(
    Shan.code-settings-sync
)
        
ForEach ($Extension in $Extensions) {
    Write-Output "Installing $Extension"
    code --install-extension $Extension
}