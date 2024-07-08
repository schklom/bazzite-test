#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install \
    # run any os in containers easily 
    distrobox \
    # Better "top" 
    htop \
    ffmpeg \
    kdepim-addons \ # For the Event Calendar widget, to work with external calendars 
    kde-connect \
    kdeconnectd \
    kontact \ # Calendar + Contact + Task manager. If installed via Flatpak, it will not work with Event  Calendar.
    libvirt \ # Run VMs 
    mono-complete \ # KeePass 
    mozilla-openh264 \ # Video support on Firefox 
    podman-compose \ # Use docker.compose.yml files with podman 
    plasma-workspace-x11 \ # Fedora decided to remove X11, so I have to add it back 
    usbguard \ # Protect against unknown USB devices 
    rpmfusion-free-release \
    rpmfusion-nonfree-release \
    virt-manager \ # Run VMs 
    xbindkeys \ # Shortcuts 
    xdotool \ # KeePass 
    xinput \ # KeePass

# --add-repo=https://copr.fedorainfracloud.org/coprs/atim/starship/repo/fedora-%OS_VERSION%/atim-starship-fedora-%OS_VERSION%.repo \
rpm-ostree install igt-gpu-tools \ # To check GPU usage via sudo intel_gpu_top
    intel-media-driver # Hardware acceleration with Intel (c.f. https://wiki.archlinux.org/title/Hardware_video_acceleration)

rpm-ostree uninstall \
    firefox \
    noopenh264

flatpak install -y \
    \ # Browsers
    org.mozilla.firefox \
    io.github.ungoogled_software.ungoogled_chromium \
    org.torproject.torbrowser-launcher \
    \
    \ # Media
    org.libreoffice.LibreOffice \
    org.kde.okular \
    org.kde.kwrite \
    org.videolan.VLC \
    com.stremio.Stremio \
    \ # com.obsproject.Studio
    com.github.iwalton3.jellyfin-media-player \
    org.gnome.Shotwell \
    org.kde.gwenview \
    tv.kodi.Kodi \
    \ # org.clementine_player.Clementine
    net.sapples.LiveCaptions \
    \ # com.github.marinm.songrec
    \
    \ # Network
    com.protonvpn.www \
    org.jdownloader.JDownloader \
    org.kde.ktorrent \
    org.kde.krdc \
    \
    \ # Social
    org.mozilla.Thunderbird \
    \ # eu.betterbird.Betterbird
    com.skype.Client \
    com.github.IsmaelMartinez.teams_for_linux \
    org.signal.Signal \
    io.github.mahmoudbahaa.outlook_for_linux \
    com.slack.Slack \
    com.discordapp.Discord \
    us.zoom.Zoom \
    \
    \ # Developer tools
    com.vscodium.codium \
    org.fedoraproject.MediaWriter \
    org.kde.isoimagewriter \
    \ # com.github.tchx84.Flatseal
    \
    \ # Others
    com.valvesoftware.Steam \
    net.lutris.Lutris \
    com.usebottles.bottles \
    com.dropbox.Client \
    org.zotero.Zotero \
    \ # org.gnome.OCRFeeder
    org.gnome.Calculator \
    io.github.prateekmedia.appimagepool \
    dev.lasheen.qr \
    org.kde.krename \
    xyz.xclicker.xclicker \
    com.nextcloud.desktopclient.nextcloud

mkdir -p /etc/systemd/journald.conf.d/
echo 'SystemMaxUse=400M' > /etc/systemd/journald.conf.d/max_size.conf

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
