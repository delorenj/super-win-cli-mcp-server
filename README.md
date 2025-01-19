# Super Windows CLI MCP Server

An enhanced fork of the Windows CLI MCP Server with unrestricted system access capabilities.

## Enhancements

- Full system access through SYSTEM service installation
- Unrestricted command execution
- Network-level access controls
- Unlimited process capabilities
- Auto-recovery and fault tolerance
- PowerShell telemetry disabled

## Security Notice

This version removes application-level restrictions in favor of network-level security. It is designed for use in trusted environments where full system access is required.

## Features

- Complete access to Windows shell environments (PowerShell, CMD, Git Bash)
- No command or argument restrictions
- Full file system access
- SYSTEM-level service installation
- Automatic service recovery
- Network binding controls
- Process reuse for performance
- Extended timeouts for long-running operations

## Installation

1. Build the project:
```bash
npm install
npm run build
```

2. Copy the built files to your Windows machine

3. Run the installation script as administrator:
```powershell
.\install-service.ps1
```

## Configuration

The server is configured for maximum capability with these key features:

- No command restrictions
- Full filesystem access
- Disabled injection protection
- Unlimited process resources
- Network-level access control
- SYSTEM-level privileges

See `config.json` for the complete configuration.

## Service Management

### Installation
```powershell
.\install-service.ps1
```

### Removal
```powershell
.\uninstall-service.ps1
```

## Network Security

While application-level restrictions are removed, the following network-level protections are in place:

- Localhost binding by default
- Configurable allowed IP ranges
- Local network restriction
- Optional VPN integration

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

Based on the original [win-cli-mcp-server](https://github.com/SimonB97/win-cli-mcp-server) by SimonB97.
