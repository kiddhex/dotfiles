{
  description = "Nix Global System Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      user = "blisshex";

      # Helper to generate config for any architecture
      mkSystem = system: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ({ pkgs, ... }: {
            home.username = user;
            home.homeDirectory = if pkgs.stdenv.isDarwin
              then "/Users/${user}"
              else "/home/${user}";

            home.stateVersion = "24.05";

            # 1. GLOBAL PACKAGES
            home.packages = with pkgs; [
              nil
              # git, ripgrep, starship, etc.
            ];

            # 2. GLOBAL SETTINGS
            # Enable Flakes & Nix Command automatically on every machine
            nix.package = pkgs.nix;
            nix.settings.experimental-features = [ "nix-command" "flakes" ];

            programs.home-manager.enable = true;
          })
        ];
      };
    in {
      homeConfigurations."blisshex-mac" = mkSystem "aarch64-darwin";

      homeConfigurations."blisshex-linux" = mkSystem "x86_64-linux";
    };
}
