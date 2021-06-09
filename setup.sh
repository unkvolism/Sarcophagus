#!/bin/bash

title="sora rice setup script"

downloadDependencies() {
    if grep "Arch\|Artix\|EndeavourOS\|Manjaro" /etc/*-release; then
        clear 
        echo "[*] Running an system update..."
        sudo pacman --noconfirm -Syu

        mkdir -p $HOME/.setup-scripto
        sleep 0.5
        clear

        if [[ -e /usr/bin/paru ]]; then
            echo -e "[*] paru detected. Installing dependencies..."
            paru -S bspwm w3m slim sxhkd rofi polybar mpd imagemagick mpv ncmpcpp cava lxappearance alacritty dunst picom brightnessctl playerctl dunst feh neofetch viewnior GIMP xclip bsp-layout
        elif [[ -e /usr/bin/yay ]]; then
            echo -e "[*] yay detected. Installing dependencies..."
            yay -S bspwm w3m slim sxhkd rofi polybar mpd imagemagick mpv ncmpcpp cava lxappearance alacritty dunst picom brightnessctl playerctl dunst feh neofetch viewnior GIMP xclip bsp-layout
        else
            # Line from https://github.com/Axarva/dotfiles-2.0/blob/9f0a71d7b23e1213383885f2ec641da48eb01681/install-on-arch.sh#L67
            read -r -p "Would you like to install yay? [Y/n]: " yay
            sleep 1.5

            case $yay in
                [yY][*])
                    git clone https://aur.archlinux.org/yay.git $HOME/.setup-scripto
                    (cd $HOME/.setup-scripto && makepkg -si)

                    echo "[*] yay installed. Installing dependencies..."
                    yay -S bspwm w3m slim sxhkd rofi polybar mpd imagemagick mpv ncmpcpp cava lxappearance alacritty dunst picom brightnessctl playerctl dunst feh neofetch viewnior GIMP xclip bsp-layout
                    ;;
                [nN])
                    echo "[*] Okay. Will not install yay."
                    ;;
            esac 
        fi

        sleep 1
    else
        clear
        echo "[*] Not on a Arch based system. Failed to download dependencies. Please manually install it."

        sleep 1
    fi
}

copyFiles() {
    clear
    
    sleep 1
    echo "[*] Copying files..."
    echo "[*] Will make backups if there are configurations found."

    if [[ -d $HOME/.config/alacritty ]]; then
        mkdir $HOME/.config/alacritty.bak && mv $HOME/.config/alacritty/* $HOME/.config/alacritty.bak
        cp -r ./rice/alacritty/* $HOME/.config/alacritty/
    else
        mkdir $HOME/.config/alacritty && cp -r ./rice/alacritty/* $HOME/.config/alacritty
    fi

    if [[ -d $HOME/.config/bspwm ]]; then
        mkdir $HOME/.config/bspwm.bak && mv $HOME/.config/bspwm/* $HOME/.config/bspwm.bak
        cp -r ./rice/bspwm/* $HOME/.config/bspwm/
    else
        mkdir $HOME/.config/bspwm && cp -r ./rice/bspwm/* $HOME/.config/bspwm
    fi

    if [[ -d $HOME/.config/cava ]]; then
        mkdir $HOME/.config/cava.bak && mv $HOME/.config/cava/* $HOME/.config/cava.bak
        cp -r ./rice/cava/* $HOME/.config/cava/
    else
        mkdir $HOME/.config/cava && cp -r ./rice/cava/* $HOME/.config/cava
    fi

    if [[ -d $HOME/.config/GIMP ]]; then
        mkdir $HOME/.config/GIMP && mv $HOME/.config/GIMP/* $HOME/.config/GIMP.bak
        cp -r ./rice/GIMP/* $HOME/.config/GIMP/
    else
        mkdir $HOME/.config/GIMP && cp -r ./rice/GIMP/* $HOME/.config/GIMP
    fi

    if [[ -d $HOME/.config/dunst ]]; then
        mkdir $HOME/.config/dunst.bak && mv $HOME/.config/dunst/* $HOME/.config/dunst.bak
        cp -r ./rice/dunst/* $HOME/.config/dunst/
    else
        mkdir $HOME/.config/dunst && cp -r ./rice/dunst/* $HOME/.config/dunst
    fi

    if [[ -d $HOME/.config/htop ]]; then
        mkdir $HOME/.config/htop.bak && mv $HOME/.config/htop/* $HOME/.config/htop.bak
        cp -r ./rice/htop/* $HOME/.config/htop/
    else
        mkdir $HOME/.config/htop && cp -r ./rice/htop/* $HOME/.config/htop
    fi

    if [[ -d $HOME/.config/mpd ]]; then
        mkdir $HOME/.config/mpd.bak && mv $HOME/.config/mpd/* $HOME/.config/mpd.bak
        cp -r ./rice/mpd/* $HOME/.config/mpd/
    else
        mkdir $HOME/.config/mpd && cp -r ./rice/mpd/* $HOME/.config/mpd
    fi

    if [[ -d $HOME/.config/mpv ]]; then
        mkdir $HOME/.config/mpv.bak && mv $HOME/.config/mpv/* $HOME/.config/mpv.bak
        cp -r ./rice/mpv/* $HOME/.config/mpv/
    else
        mkdir $HOME/.config/mpv && cp -r ./rice/mpv/* $HOME/.config/mpv
    fi

    if [[ -d $HOME/.config/ncmpcpp ]]; then
        mkdir $HOME/.config/ncmpcpp.bak && mv $HOME/.config/ncmpcpp/* $HOME/.config/ncmpcpp.bak
        cp -r ./rice/ncmpcpp/* $HOME/.config/ncmpcpp/
    else
        mkdir $HOME/.config/ncmpcpp && cp -r ./rice/ncmpcpp/* $HOME/.config/ncmpcpp
    fi

    if [[ -d $HOME/.config/neofetch ]]; then
        mkdir $HOME/.config/neofetch.bak && mv $HOME/.config/neofetch/* $HOME/.config/neofetch.bak
        cp -r ./rice/neofetch/* $HOME/.config/neofetch/
    else
        mkdir $HOME/.config/nefetch && cp -r ./rice/mpv/* $HOME/.config/neofetch
    fi

    if [[ -d $HOME/.config/picom ]]; then
        mkdir $HOME/.config/picom.bak && mv $HOME/.config/picom/* $HOME/.config/picom.bak
        cp -r ./rice/picom/* $HOME/.config/picom/
    else
        mkdir $HOME/.config/picom && cp -r ./rice/picom/* $HOME/.config/picom
    fi

    if [[ -d $HOME/.config/polybar ]]; then
        mkdir $HOME/.config/polybar.bak && mv $HOME/.config/polybar/* $HOME/.config/polybar.bak
        cp -r ./rice/polybar/* $HOME/.config/polybar/
    else
        mkdir $HOME/.config/polybar && cp -r ./rice/polybar/* $HOME/.config/polybar
    fi

    if [[ -d $HOME/.config/sxhkd ]]; then
        mkdir $HOME/.config/sxhkd.bak && mv $HOME/.config/sxhkd/* $HOME/.config/sxhkd.bak
        cp -r ./rice/sxhkd/* $HOME/.config/sxhkd/
    else
        mkdir $HOME/.config/sxhkd && cp -r ./rice/sxhkd/* $HOME/.config/sxhkd
    fi

    if [[ -d $HOME/.config/rofi ]]; then
        mkdir $HOME/.config/rofi.bak && mv $HOME/.config/rofi/* $HOME/.config/rofi.bak
        cp -r ./rice/rofi/* $HOME/.config/rofi/
    else
        mkdir $HOME/.config/rofi && cp -r ./rice/rofi/* $HOME/.config/rofi
    fi

    if [ -d $HOME/.local/share/fonts ]; then
        cp -r ./fonts/* /usr/share/fonts
    else
        mkdir /usr/share/fonts && cp -r ./fonts/* /usr/share/fonts
    fi

    if [ -d $HOME/.themes ]; then
        cp -r ./themes/* $HOME/.themes
    else
        mkdir $HOME/.themes && cp -r ./themes/* $HOME/.themes
    fi


    sleep 1
    echo "[*] Copied files successfully."
    sleep 0.7
}

finalizeChanges() {
    clear
    echo "[*] Refreshing font cache..."
    fc-cache -v

    clear
    sleep 1.3

    clear
    echo "[*] Finalizing changes..."
    sleep 3
    clear
}

fuckUser() {
    clear
    echo "[*] An error occured. Exiting."
    exit
}

welcome() {
    whiptail --title "$title" \
        --no-button "Exit" --yes-button "Continue" \
        --yesno "This process will download the needed dependencies and copy the config files to $HOME/.config. Would you like to continue?" 10 70
}

success() {
    # Remove the custom directory made by the script
    rm -rf $HOME/.setup-scripto

    whiptail --title "$title" \
        --msgbox "Setup success. Please restart BSPWM if you are on an active session. Check notes on the repository's README." 20 50
}

echo "[*] Starting setup script..."
sleep 0.5

# Prompt user the welcome dialog
welcome || fuckUser

# Download dependencies
downloadDependencies

# Copy files from the repo to $HOME/.config
copyFiles

# Restart everything lol
finalizeChanges

# Show the success dialog when everything is fine
success && clear
