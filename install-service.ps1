# Elevate to admin if not already
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {  
    $arguments = "& '" +$myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

# Create service configuration
$serviceName = "MCPServer"
$serviceDisplayName = "MCP Command Server"
$serviceDescription = "Windows Command Server for Remote Administration"
$exePath = "`"$PSScriptRoot\node.exe`" `"$PSScriptRoot\dist\index.js`""

# Remove existing service if it exists
if (Get-Service $serviceName -ErrorAction SilentlyContinue) {
    Write-Host "Removing existing service..."
    sc.exe delete $serviceName
    Start-Sleep -s 2
}

# Install service using native Windows commands for maximum privileges
Write-Host "Installing service with SYSTEM privileges..."
sc.exe create $serviceName binPath= $exePath start= auto obj= "LocalSystem"
sc.exe description $serviceName $serviceDescription
sc.exe config $serviceName type= own

# Configure extended service permissions
$sddl = "D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;IU)(A;;CCLCSWLOCRRC;;;SU)"
sc.exe sdset $serviceName $sddl

# Configure service recovery options
sc.exe failure $serviceName reset= 86400 actions= restart/60000/restart/60000/restart/60000

# Start the service
Write-Host "Starting service..."
Start-Service $serviceName

Write-Host "Service installed and started successfully!"
Write-Host "Service Details:"
Write-Host "Name: $serviceName"
Write-Host "Path: $exePath"
Write-Host "Status: $((Get-Service $serviceName).Status)"
Write-Host ""
Write-Host "The service is now running with SYSTEM privileges and will auto-start on boot."