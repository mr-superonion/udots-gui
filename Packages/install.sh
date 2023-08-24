# basics
pacman -S --noconfirm locate pacman-contrib zsh locate sudo wget curl fzf \
    git neovim python-pynvim openssh lsusb diff-so-fancy

timedatectl
vim /etc/locale.gen
locale-gen
setfont ter-932b
# use this font as default
vim /etc/vconsole.conf
ls /usr/share/kbd/consolefonts/ter-*
hostnamectl set-hostname superonion
vim /etc/hostname
mkinitcpio -P
useradd -m user_name
passwd user_name
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

# netWork
sudo pacman --noconfirm -S  networkmanager
vim /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
nvim /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# change these two files
sudo nvim /etc/hosts
sudo nvim /etc/hostname
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service
sudo systemctl --type=service
umount -R /mnt

# terminal, non-GUI
sudo pacman -S --noconfirm zsh locate sudo wget curl fzf openssh \
        networkmanager git neovim python-pynvim lsof htop ipython \
        apparmor unzip ctags

# apparmor
sudo systemctl enable apparmor.service
sudo systemctl start apparmor.service

## bluetooth
sudo pacman --noconfirm -S  bluez bluez-utils blueman
## check the kernel module
lsmod | grep btusb
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

# WM
sudo pacman --noconfirm -S python-psutil qtile expect rsync thunar \
    lightdm-gtk-greeter thunar blueman-applet network-manager-applet\
    lxappearance feh xsel xclip scrot

sudo pacman --noconfirm -S python-pywayland wayland python-pywlroots

# audio
## install pulseaudio
sudo pacman --noconfirm  -S pavucontrol pulseaudio pulseaudio-bluetooth
yay -S pulseaudio-ctl

## start the service
systemctl --user enable pulseaudio.socket
systemctl --user start pulseaudio.socket
pavucontrol

# Display
sudo pacman -S edid-decode automake dos2unix xorg-xbacklight
# Wine
sudo pacman -S wine wine-mono wine-gecko

# Latex
sudo pacman -S texlive-basic texlive-latexextra texlive-latexrecommended \
    texlive-bibtexextra texlive-xetex texlive-fontsrecommended texlive-fontsextra \
    texlive-mathscience texlive-publishers texlive-binextra
