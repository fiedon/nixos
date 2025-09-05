# NixOS Flake Configuration for ryzen-nixos

This flake contains the NixOS configuration for the `ryzen-nixos` system with home-manager integration.

## Structure

- `flake.nix` - Main flake configuration
- `configuration.nix` - NixOS system configuration
- `hardware-configuration.nix` - Hardware-specific configuration
- `home.nix` - Home-manager configuration for user `fiedon`

## Usage

### Switch to Flake-based Configuration

To switch your system to use this flake configuration, run:

```bash
sudo nixos-rebuild switch --flake .#ryzen-nixos
```

### Updating the System

To update your system with the latest packages from the channels:

```bash
# Update flake inputs
nix flake update

# Rebuild with updated inputs
sudo nixos-rebuild switch --flake .#ryzen-nixos
```

### Home Manager

Home-manager is integrated into the system configuration. When you rebuild the system, home-manager changes will also be applied automatically.

### Development Environment

Enter a development shell with useful tools for managing this flake:

```bash
nix develop
```

### Available Packages

The flake provides access to both stable (25.05) and unstable packages:
- Stable packages: Use normally with `pkgs.packagename`
- Unstable packages: Use with `pkgs.unstable.packagename`

## Converting from Legacy Configuration

If you're converting from the legacy `/etc/nixos` configuration:

1. This flake directory contains your converted configuration
2. The original home-manager fetchTarball method has been replaced with proper flake inputs
3. Your existing packages and settings have been preserved

## Customization

- Edit `configuration.nix` for system-wide changes
- Edit `home.nix` for user-specific home-manager configuration
- Add new flake inputs in `flake.nix` if you need additional packages or modules

## Troubleshooting

If you encounter issues:

1. Check flake syntax: `nix flake check`
2. Test build without switching: `nixos-rebuild build --flake .#ryzen-nixos`
3. View detailed error output: `nixos-rebuild switch --flake .#ryzen-nixos --show-trace`

## Alias Commands

Your bash aliases from the original configuration are preserved:
- `btw` - Echo "i use nixos btw"
- `nrs` - Rebuild system (note: you may want to update this to use the flake)

Consider updating the `nrs` alias in `home.nix` to:
```bash
nrs = "sudo nixos-rebuild switch --flake ~/flake#ryzen-nixos";
```
