{ config, pkgs, inputs, ... }:

{
  home = {
    username = "linuxaddict124"; # Set it to your current username.
    homeDirectory = "/home/linuxaddict124"; # Set it to your home directory.
    stateVersion = "26.05";
  };

  programs = {
    git.enable = true;
    bash = {
      enable = true;
      shellAliases = {
        nuh-uh = "echo Yuh uh";
        yuh-uh = "echo Nuh uh";
      };
    };
    plasma = {
      enable = true;
      overrideConfig = true;
      workspace = {
        theme = "org.kde.breezedark.desktop";
        colorScheme = "BreezeDark";
        iconTheme = "Papirus-Dark";
        cursor.theme = "Bibata-Modern-Classic";
        cursor.size = 24;
      };
      panels = [
        {
          location = "bottom";
          widgets = [
            "org.kde.plasma.kickoff"
            {
              iconTasks = {
                launchers = [
                  "applications:org.kde.systemsettings.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:firefox.desktop"
                ];
              };
            }
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.systemtray"
            "org.kde.plasma.digitalclock"
          ];
          height = 40;
          lengthMode = "fit";
          opacity = "translucent";
        }
      ];
      fonts = {
        general = {
          family = "JetBrainsMono Nerd Font";
          pointSize = 10;
        };
        small = {
          family = "JetBrainsMono Nerd Font";
          pointSize = 8;
        };
        toolbar = {
          family = "JetBrainsMono Nerd Font";
          pointSize = 10;
        };
        menu = {
          family = "JetBrainsMono Nerd Font";
          pointSize = 10;
        };
        windowTitle = {
          family = "JetBrainsMono Nerd Font";
          pointSize = 10;
        };
      };
    };
  };

  home.packages = with pkgs; [
    prismlauncher
    vscodium
  ];
}
