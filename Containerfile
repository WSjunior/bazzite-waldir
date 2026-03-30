# Imagem customizada baseada no Bazzite DX (NVIDIA)
# Adiciona Hyprland, fontes e drivers ODBC
FROM ghcr.io/ublue-os/bazzite-dx-nvidia:stable

# Hyprland via COPR sdegler (ecossistema completo para Fedora 43)
RUN curl -fsSL "https://copr.fedorainfracloud.org/coprs/sdegler/hyprland/repo/fedora-43/sdegler-hyprland-fedora-43.repo" \
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
