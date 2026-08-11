{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_18;
    loader = {
      grub = {
        enable = true;
        device = "nodev"; # Set it to your boot drive if you don't have UEFI.
        efiSupport = true; # Not required if your PC doesn't have UEFI support.
      };
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true; # Recommended to remove if you don't have UEFI
    };
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  services = {
    desktopManager.plasma6.enable = true;
    displayManager = {
      sddm.enable = false;
      ly.enable = true;
      defaultSession = "plasma";
    };
    flatpak.enable = true;
    # If you need anymore services, put them down here.
    
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    elisa
    okular
    khelpcenter
    qrca
  ];

  services.xserver.xkb.layout = "us"; # Change this if required.

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  users.users.linuxaddict124 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    nano
    papirus-icon-theme
    bibata-cursors
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
