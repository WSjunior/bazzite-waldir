# Imagem customizada baseada no Bazzite DX (NVIDIA)
# Adiciona Hyprland, Chrome, drivers ODBC e pacotes extras
FROM ghcr.io/ublue-os/bazzite-dx-nvidia:stable

# Hyprland via COPR (não está nos repos oficiais do Fedora 43)
RUN curl -fsSL "https://copr.fedorainfracloud.org/coprs/ashbuk/Hyprland-Fedora/repo/fedora-43/ashbuk-Hyprland-Fedora-fedora-43.repo" \
    -o /etc/yum.repos.d/hyprland.repo \
    && rpm-ostree install \
    hyprland \
    hyprpaper \
    hyprlock \
    hypridle \
    xdg-desktop-portal-hyprland \
    kitty \
    waybar \
    rofi-wayland \
    mako \
    grim \
    slurp \
    wl-clipboard \
    uwsm \
    swaybg \
    hyprpicker \
    hyprsunset \
    playerctl \
    pamixer \
    brightnessctl \
    satty \
    imv \
    && rpm-ostree cleanup -m

# Google Chrome (adiciona repo oficial e instala)
RUN curl -fsSL https://dl.google.com/linux/linux_signing_key.pub \
    | gpg --dearmor -o /etc/pki/rpm-gpg/google-chrome.gpg \
    && echo -e "[google-chrome]\nname=Google Chrome\nbaseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64\nenabled=1\ngpgcheck=1\ngpgkey=file:///etc/pki/rpm-gpg/google-chrome.gpg" \
    > /etc/yum.repos.d/google-chrome.repo \
    && rpm-ostree install google-chrome-stable \
    && rpm-ostree cleanup -m

# TeamViewer (RPM oficial)
RUN curl -fsSL https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm \
    -o /tmp/teamviewer.rpm \
    && rpm-ostree install /tmp/teamviewer.rpm \
    && rm /tmp/teamviewer.rpm \
    && rpm-ostree cleanup -m

# Fontes
RUN rpm-ostree install \
    fontawesome-fonts-all \
    jetbrains-mono-fonts-all \
    cascadia-code-nf-fonts \
    cascadiamono-nerd-fonts \
    && rpm-ostree cleanup -m

# Fontes Microsoft (copiadas do host)
COPY fonts/ /usr/share/fonts/microsoft/
RUN fc-cache -f

# Drivers ODBC - SQL Server e Firebird (elimina dependência do brew para isso)
RUN curl -fsSL https://packages.microsoft.com/config/fedora/43/prod.repo \
    -o /etc/yum.repos.d/mssql-release.repo \
    && ACCEPT_EULA=Y rpm-ostree install \
    unixODBC \
    msodbcsql18 \
    && rpm-ostree cleanup -m
