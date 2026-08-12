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
      configFile = {
        "kcminputrc" = {
          "Libinput" = {
            "DisableWhileTyping" = false;
          };
        };
      };
      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        iconTheme = "Papirus-Dark";
        wallpaper = "/etc/nixos/img/wallpaper.png";
        wallpaperFillMode = "preserveAspectCrop";
        cursor.theme = "Bibata-Modern-Classic";
        cursor.size = 24;
      };
      kwin = {
        virtualDesktops = {
          number = 1;
          rows = 1;
        };
        effects = {
          blur = {
            enable = true;
            strength = 8;
            noiseStrength = 0;
          };
          translucency.enable = true;
        };
      };
      panels = [
        {
          location = "bottom";
          height = 40;
          lengthMode = "fit";
          opacity = "translucent";
          floating = true;
          widgets = [
            "org.kde.plasma.kickoff"
            {
              iconTasks = {
                launchers = [
                  "applications:systemsettings.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:firefox.desktop"
                ];
              };
            }
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.systemtray"
            "org.kde.plasma.digitalclock"
          ];
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
    fastfetch
    cmatrix
  ];
}
