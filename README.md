# Dotfiles

Managed with [chezmoi](https://www.chezmoi.io/). Currently configured for **macOS** (MacBook). The repo structure also supports adding a Linux machine later — see "Adding Linux back" below.

## What's included

### Shared

| Config | Path |
|---|---|
| Neovim (LazyVim) | `~/.config/nvim/` |
| tmux | `~/.config/tmux/tmux.conf` |
| Starship prompt | `~/.config/starship/starship.toml` |
| Lazygit | `~/.config/lazygit/config.yml` |
| Ghostty | `~/.config/ghostty/config` |
| SSH | `~/.ssh/config` |
| Zsh | `~/.zshrc` |

### macOS only

- Aerospace (tiling WM) — `~/.config/aerospace/`
- Karabiner-Elements — `~/.config/karabiner/`
- Sketchybar — `~/.config/sketchybar/`
- Homebrew packages, casks, and fonts installed via run script

## Repository structure

```
.chezmoiscripts/
  darwin/              # macOS-only run scripts
    run_once_01_install-packages.sh
    run_once_02_install-tmux-tpm.sh
  # linux/             # (scaffold) Linux-only run scripts go here
.chezmoitemplates/
  lazygit-config.yml   # Shared lazygit config template
dot_config/            # ~/.config/*
dot_zshrc.tmpl         # ~/.zshrc (templated per OS)
```

OS-specific scripts and files are filtered via `.chezmoiignore.tmpl` so only the relevant ones apply on each machine.

## Installation

### macOS

```sh
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install chezmoi and apply
brew install chezmoi
chezmoi init --apply sul-patompong
```

## Usage

```sh
chezmoi diff          # Preview changes before applying
chezmoi apply         # Apply changes to home directory
chezmoi edit ~/.zshrc # Edit a managed file
chezmoi update        # Pull latest from remote and apply
```

## Adding Linux back

The repo is scaffolded to support a Linux machine alongside macOS:

1. Drop Linux dotfiles under `dot_config/...` and list any Linux-only paths in the `{{ if ne .chezmoi.os "linux" }} … {{ end }}` block in `.chezmoiignore.tmpl`.
2. Create `.chezmoiscripts/linux/` and add run-once scripts there.
3. For cross-platform templates that need an OS-specific value (e.g. `dot_config/ghostty/config.tmpl`), wrap the differing value in `{{ if eq .chezmoi.os "darwin" }} … {{ else }} … {{ end }}`.
4. `.chezmoi.toml.tmpl` already prompts for `machineType` (workstation/server) on Linux — use it to gate GUI-only configs in `.chezmoiignore.tmpl`.
