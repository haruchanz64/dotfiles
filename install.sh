#!/bin/bash
# ============================================================
#  CachyOS Fresh Install Script
#  Installs all listed applications via pacman + paru (AUR)
# ============================================================

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# ── Sanity checks ────────────────────────────────────────────
if [ "$EUID" -eq 0 ]; then
  error "Do NOT run this script as root. Run it as your normal user."
  exit 1
fi

if ! command -v paru &>/dev/null; then
  error "paru not found. On CachyOS it should be pre-installed."
  error "If missing, install it with: sudo pacman -S paru"
  exit 1
fi

# ── System update first ──────────────────────────────────────
info "Updating system before installing packages..."
paru -Syu --noconfirm

# ── Official repo packages (pacman) ─────────────────────────
PACMAN_PACKAGES=(
  firefox           # Firefox
  discord           # Discord
  docker            # Docker
  obs-studio        # OBS Studio
  telegram-desktop  # Telegram
  vlc               # VLC
  filezilla         # FileZilla
  jdk-openjdk       # Java JDK
  dotnet-sdk        # .NET SDK
  nodejs            # Node.js
  npm               # Node Package Manager
  p7zip             # 7-Zip CLI (7z command)
  7-zip             # 7-Zip (full GUI + CLI)
  gnome-keyring     # Keyring support (fixes GitHub Desktop on KDE)
  libsecret         # Secret storage library
)

info "Installing official repo packages..."
sudo pacman -S --needed --noconfirm "${PACMAN_PACKAGES[@]}"

# ── AUR packages (paru) ──────────────────────────────────────
AUR_PACKAGES=(
  bitwarden               # Bitwarden
  brave-bin               # Brave Browser
  dbeaver-ce              # DBeaver Community
  github-desktop-bin      # GitHub Desktop
  google-chrome           # Google Chrome
  jetbrains-toolbox       # JetBrains Toolbox
  localsend-bin           # LocalSend
  notepadqq               # Notepadqq (native Notepad++ alternative)
  visual-studio-code-bin  # Visual Studio Code (Microsoft build)
  obsidian                # Obsidian
  onlyoffice-bin          # OnlyOffice
  postman-bin             # Postman
  slack-desktop           # Slack
  spotify                 # Spotify
  todoist                 # Todoist
  unityhub                # Unity Hub
  roslynpad               # RoslynPad (C# scratchpad, LINQPad alternative)
  flutter                 # Flutter SDK
  supabase-bin            # Supabase CLI
  filen-desktop-bin       # Filen (E2E encrypted cloud storage)
  mcontrolcenter-bin      # MControlCenter (MSI laptop settings)
  auto-cpufreq            # Automatic CPU frequency scaling
  envycontrol             # NVIDIA GPU switching (integrated/hybrid/dedicated)
)

info "Installing AUR packages..."
paru -S --needed --noconfirm "${AUR_PACKAGES[@]}"

# ── VS Code Extensions ───────────────────────────────────────
if [ -f "$(dirname "$0")/extensions.txt" ]; then
  info "Installing VS Code extensions..."
  cat "$(dirname "$0")/extensions.txt" | xargs -L 1 code --install-extension
else
  warn "extensions.txt not found, skipping VS Code extensions."
fi

# ── Power management ─────────────────────────────────────────
info "Enabling auto-cpufreq service..."
sudo systemctl enable --now auto-cpufreq

# ── Docker post-install ──────────────────────────────────────
info "Enabling Docker service and adding user to docker group..."
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
warn "Docker: Log out and back in (or run 'newgrp docker') for group changes to take effect."

# ── Done ─────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}  All applications installed successfully!  ${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
warn "MControlCenter: Requires the msi-ec kernel driver. Run: cat /sys/devices/platform/msi-ec/shift_mode to verify it is active."
warn "A reboot or re-login is recommended to apply all group/env changes."
echo ""