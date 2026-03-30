# bazzite-waldir

Imagem customizada do Bazzite DX (NVIDIA) com adições pessoais.

## Base

`ghcr.io/ublue-os/bazzite-dx-nvidia:stable`

## Adições sobre a base

- **Hyprland** (hyprland, hyprpaper, hyprlock, hypridle) - compositor tiling alternativo ao KDE
- **Google Chrome** - instalação nativa (sem Flatpak)
- **ODBC** - msodbcsql18 + unixODBC nativos na imagem

## Uso

```bash
sudo bootc switch ghcr.io/wsjunior/bazzite-waldir:latest
```

## Build automático

GitHub Actions rebuilda diariamente (06:00 UTC) para acompanhar atualizações da imagem base.
