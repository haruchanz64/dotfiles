# haruchanz64/dotfiles

My personal fresh install script for CachyOS. Tired of setting things up manually — this does it all in one shot via `pacman` and `paru`.

## Usage

```bash
git clone https://github.com/haruchanz64/dotfiles
cd dotfiles
chmod +x install.sh
./install.sh
```

> Do not run as root.

## What gets installed

### via pacman (official repos)

| Package | App |
|---|---|
| `firefox` | Firefox |
| `discord` | Discord |
| `docker` | Docker |
| `obs-studio` | OBS Studio |
| `telegram-desktop` | Telegram |
| `vlc` | VLC |
| `filezilla` | FileZilla |
| `jdk-openjdk` | Java JDK |
| `dotnet-sdk` | .NET SDK |
| `nodejs` + `npm` | Node.js |
| `p7zip` + `7-zip` | 7-Zip |

### via paru (AUR)

| Package | App |
|---|---|
| `bitwarden` | Bitwarden |
| `brave-bin` | Brave Browser |
| `dbeaver-ce` | DBeaver Community |
| `github-desktop-bin` | GitHub Desktop |
| `google-chrome` | Google Chrome |
| `jetbrains-toolbox` | JetBrains Toolbox |
| `localsend-bin` | LocalSend |
| `notepadqq` | Notepadqq |
| `visual-studio-code-bin` | Visual Studio Code |
| `obsidian` | Obsidian |
| `onlyoffice-bin` | OnlyOffice |
| `postman-bin` | Postman |
| `slack-desktop` | Slack |
| `spotify` | Spotify |
| `todoist` | Todoist |
| `unityhub` | Unity Hub |
| `roslynpad` | RoslynPad |
| `flutter` | Flutter SDK |
| `supabase-bin` | Supabase CLI |
| `filen-desktop-bin` | Filen |
| `mcontrolcenter-bin` | MControlCenter |

## Notes

- **Docker** — log out and back in after install for group permissions to apply, or run `newgrp docker`
- **MControlCenter** — requires the `msi-ec` kernel driver. Verify with:
  ```bash
  cat /sys/devices/platform/msi-ec/shift_mode
  ```
- **Flutter** — run `flutter doctor` after install to verify the setup
- **RoslynPad** — requires `.NET SDK`, already included
- **Filen** — E2E encrypted cloud storage, 10GB free tier. Based in Germany.

## Machine

**MSI Thin A15 B7UCX** (Cosmos Gray)

| | |
|---|---|
| **CPU** | AMD Ryzen 5 7535HS (6 cores, 3.3GHz up to 4.55GHz) |
| **GPU** | NVIDIA GeForce RTX 2050 4GB GDDR6 |
| **RAM** | 16GB DDR5-4800 |
| **Storage** | 2TB NVMe SSD (PCIe Gen4) |
| **Display** | 15.6" FHD (1920x1080), 144Hz, IPS |
| **Wi-Fi** | Wi-Fi 6E + Bluetooth 5.3 |
| **Battery** | 3-Cell, 52.4Whr / 120W adapter |
| **OS** | CachyOS (KDE) |