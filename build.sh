#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree \
    override remove noopenh264 \
    --install mozilla-openh264

rpm-ostree install -y --idempotent \
    distrobox \
    htop \
    ffmpeg \
    kdepim-addons \
    kde-connect \
    kdeconnectd \
    kontact \
    libvirt \
    mono-complete \
    podman-compose \
    plasma-workspace-x11 \
    usbguard \
    rpmfusion-free-release \
    rpmfusion-nonfree-release \
    virt-manager \
    xbindkeys \
    xdotool \
    xinput

# --add-repo=https://copr.fedorainfracloud.org/coprs/atim/starship/repo/fedora-%OS_VERSION%/atim-starship-fedora-%OS_VERSION%.repo \
rpm-ostree install -y --idempotent \
    igt-gpu-tools \
    intel-media-driver

# Browsers
flatpak install flathub -y --noninteractive org.mozilla.firefox
flatpak install -y --noninteractive io.github.ungoogled_software.ungoogled_chromium
flatpak install -y --noninteractive org.torproject.torbrowser-launcher

# Media
flatpak install -y --noninteractive \
    org.libreoffice.LibreOffice \
    org.kde.okular \
    org.kde.kwrite \
    org.videolan.VLC \
    com.stremio.Stremio \
    com.github.iwalton3.jellyfin-media-player \
    org.gnome.Shotwell \
    org.kde.gwenview \
    tv.kodi.Kodi \
    net.sapples.LiveCaptions
    # com.github.marinm.songrec
    # org.clementine_player.Clementine
    # com.obsproject.Studio

# Network
flatpak install -y --noninteractive \
    com.protonvpn.www \
    org.jdownloader.JDownloader \
    org.kde.ktorrent \
    org.kde.krdc

# Social
flatpak install -y --noninteractive \
    org.mozilla.Thunderbird \
    com.skype.Client \
    com.github.IsmaelMartinez.teams_for_linux \
    org.signal.Signal \
    io.github.mahmoudbahaa.outlook_for_linux \
    com.slack.Slack \
    com.discordapp.Discord \
    us.zoom.Zoom
    # eu.betterbird.Betterbird

# Developer tools
flatpak install -y --noninteractive
    com.vscodium.codium \
    org.fedoraproject.MediaWriter \
    org.kde.isoimagewriter
    # com.github.tchx84.Flatseal

# Others
flatpak install -y --noninteractive
    com.valvesoftware.Steam \
    net.lutris.Lutris \
    com.usebottles.bottles \
    com.dropbox.Client \
    org.zotero.Zotero \
    org.gnome.Calculator \
    io.github.prateekmedia.appimagepool \
    dev.lasheen.qr \
    org.kde.krename \
    xyz.xclicker.xclicker \
    com.nextcloud.desktopclient.nextcloud
     # org.gnome.OCRFeeder

mkdir -p /etc/systemd/journald.conf.d/
echo 'SystemMaxUse=400M' > /etc/systemd/journald.conf.d/max_size.conf

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
