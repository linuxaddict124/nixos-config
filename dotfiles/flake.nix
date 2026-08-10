{
  description = "LinuxAddict's NixOS Configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # If you plan to replace KDE Plasma with a different Desktop Environment, remove the below.
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # If you have a different architecture, set it on this string update the flake.
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.linuxaddict124 = import ./home.nix; # Replace linuxaddict124 with your username
            backupFileExtension = "backup";

            sharedModules = [
              plasma-manager.homeModules.plasma-manager
            ];
          };
        }
      ];
    };
  };
}
