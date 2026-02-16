# Dotfiles

Managed with [chezmoi](https://www.chezmoi.io/). Supports **macOS** (MacBook) and **Arch Linux** (Fedora/ThinkPad).

## What's included

### Shared (both OS)

| Config | Path |
|---|---|
| Neovim (LazyVim) | `~/.config/nvim/` |
| tmux | `~/.config/tmux/tmux.conf` |
| Starship prompt | `~/.config/starship/starship.toml` |
| Lazygit | `~/.config/lazygit/config.yml` (Linux) / `~/Library/Application Support/lazygit/config.yml` (macOS) |
| Ghostty | `~/.config/ghostty/config` |
| Kanata | `~/.config/kanata/kanata.kbd` |
| SSH | `~/.ssh/config` |
| Zsh | `~/.zshrc` |

### macOS only

- Aerospace (tiling WM) — `~/.config/aerospace/`
- Karabiner-Elements — `~/.config/karabiner/`
- Homebrew packages, casks, and fonts installed via run script

### Linux only

- Hyprland, Waybar, Mako, Satty, Wallpapers
- Fontconfig, systemd user services
- Packages installed via yay (Arch)
- Kanata udev/permissions setup
- TLP power management (ThinkPad-specific)
- iwd standalone wireless + bluetooth

## Repository structure

```
.chezmoiscripts/
  darwin/              # macOS-only run scripts
    run_once_01_install-packages.sh
    run_once_02_install-tmux-tpm.sh
  linux/               # Linux-only run scripts
    run_once_01_install-packages.sh
    run_once_02_add-hypr-custom-source.sh
    run_once_03_setup-kanata.sh
    run_once_04_install-tmux-tpm.sh
    run_once_05_setup-power-profile-permissions.sh
    run_once_06_apply-tlp-config.sh.tmpl
    run_once_99_setup-iwd.sh
.chezmoitemplates/
  lazygit-config.yml   # Shared lazygit config template
dot_config/            # ~/.config/*
dot_zshrc.tmpl         # ~/.zshrc (templated per OS)
```

OS-specific scripts are filtered via `.chezmoiignore.tmpl` so only the relevant scripts run on each machine.

## Installation

### macOS

```sh
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install chezmoi and apply
brew install chezmoi
chezmoi init --apply sul-patompong
```

### Arch Linux

```sh
# Install chezmoi
sudo pacman -S chezmoi

# Apply
chezmoi init --apply sul-patompong
```

## Usage

```sh
chezmoi diff          # Preview changes before applying
chezmoi apply         # Apply changes to home directory
chezmoi edit ~/.zshrc # Edit a managed file
chezmoi update        # Pull latest from remote and apply
```
