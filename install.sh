#!/bin/sh

id="$(. /etc/os-release && echo "${ID:-}")"

if [[ "$id" != "nixos" ]]; then
    echo "This is only for NixOS, quitting..."
    exit 1
fi

if [ "$EUID" -ne 0 ]; then
  echo "Please run this in root."
  exit 1
fi

read -p "NOTE: This is extremely experimental and not suited for beginners. Continue? (y/n): " exper_choice
case "$exper_choice" in
    y|Y )
        echo "Continuing in 3 seconds... (Ctrl+C to cancel)"
        sleep 3
    ;;
    n|N )
        echo "Exiting..."
        exit 0
    ;;
    * )
        echo "Invaild option. Exiting with 1..."
        exit 1
    ;;
esac

read -p "Are you replacing your config or installing NixOS with this config? (Replace/Installation): " inst_choice
case "$inst_choice" in
    r|R|replace|Replace )
        read -p "You will not be able to recover your previous config. Are you sure? (y/n): " double_check
        case "$double_check" in
            y|Y )
                echo "Continuing..."
            ;;
            n|N )
                echo "Exiting..."
                exit 0
            ;;
            * )
                echo "Please type in a vaild option"
                exit 1
            ;;
        esac
        if [ ! -d ./dotfiles ]; then
            echo "Failed to file dotfiles folder. Exiting with 1..."
            exit 1
        fi
        rm /etc/nixos/configuration.nix
        if [-e "/etc/nixos/flake.nix"]; then
            rm /etc/nixos/flake.nix
        fi
        if [-e "/etc/nixos/flake.lock"]; then
            rm /etc/nixos/flake.lock
        fi
        if [-e "/etc/nixos/home.nix"]; then
            rm /etc/nixos/home.nix
        fi
        cp -r ./dotfiles/* /etc/nixos/
        echo "Make sure to modify the new config files to be like your current user."
        echo "Once you are done, run this command:"
        echo "sudo nixos-rebuild switch --flake /etc/nixos#nixos"
        exit 0
    ;;
    i|I|installation|Installation )
        echo "Attempting to install..."
        if mountpoint -q "/mnt"; then
            if [ ! -d ./dotfiles ]; then
                echo "Failed to file dotfiles folder. Exiting with 1..."
                exit 1
            fi
            nixos-generate-config --root /mnt
            rm /mnt/etc/nixos/configuration.nix
            cp -r ./dotfiles/* /mnt/etc/nixos/
            nixos-install --flake /mnt/etc/nixos#nixos
            echo "Set up your main user password"
            nixos-enter --root /mnt -c 'passwd user'
            read -p "Enter post-installation shell? (y/n): " root_choice
            case "$root_choice" in
                y|Y )
                    nixos-enter --root /mnt
                    exit 0
                ;;
                n|N )
                    echo "Exiting..."
                    exit 0
                ;;
                * )
                    echo "Please type in a vaild option."
                    exit 1
                ;;
            esac
        else
            echo "/mnt is not mounted, quitting..."
            exit 1
        fi
    ;;
    * )
        echo "Invaild option. Exiting with 1..."
        exit 1
    ;;
esac
