# Elevate to admin if not already
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {  
    $arguments = "& '" +$myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

$serviceName = "MCPServer"

# Stop and remove service
if (Get-Service $serviceName -ErrorAction SilentlyContinue) {
    Write-Host "Stopping service..."
    Stop-Service $serviceName -Force
    
    Write-Host "Removing service..."
    sc.exe delete $serviceName
    
    Write-Host "Service removed successfully!"
} else {
    Write-Host "Service not found!"
}