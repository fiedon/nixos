{
  description = "NixOS configuration for ryzen-nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    
    # Create an overlay to include unstable packages
    overlay-unstable = final: prev: {
      unstable = nixpkgs-unstable.legacyPackages.${prev.system};
    };
  in
  {
    nixosConfigurations = {
      ryzen-nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { 
          inherit inputs pkgs-unstable; 
        };
        modules = [
          # Apply the overlay
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
          
          ./configuration.nix
          ./hardware-configuration.nix
          
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.fiedon = import ./home.nix;
          }
        ];
      };
    };

    # Development shell for flake development
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        git
        nixos-rebuild
      ];
      shellHook = ''
        echo "NixOS Flake Development Environment"
        echo "Available commands:"
        echo "  nixos-rebuild switch --flake .#ryzen-nixos"
        echo "  home-manager switch --flake .#fiedon"
      '';
    };

    # Formatter for nix files
    formatter.${system} = pkgs.nixpkgs-fmt;
  };
}
