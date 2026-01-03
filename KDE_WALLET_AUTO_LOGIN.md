# KDE Wallet Auto-Login Configuration

This document describes the KDE Wallet auto-login setup managed by this chezmoi configuration.

## Overview

KDE Wallet can be configured to automatically unlock when you log in, eliminating the need to enter your wallet password separately. This is accomplished using PAM (Pluggable Authentication Modules) integration.

## What Was Configured

### 1. Package Installation
- Added `kwallet-pam` to the package list in `run_once_01_install-packages_linux.sh`
- This package provides PAM integration for KWallet

### 2. KWallet Configuration
- Added `dot_config/kwalletrc` with settings:
  - `First Use=false` - Marks wallet as already set up
  - `Prompt on Open=false` - Disables prompts when opening the wallet
  - `apiEnabled=true` - Enables the freedesktop.org secrets API

### 3. PAM Configuration (SDDM)
- For SDDM users (which you're using), the PAM configuration is already included in `/etc/pam.d/sddm`
- The following lines enable kwallet-pam:
  ```
  -auth       optional    pam_kwallet5.so
  -session    optional    pam_kwallet5.so         auto_start
  ```

### 4. Autostart
- The `kwallet-pam` package provides `/etc/xdg/autostart/pam_kwallet_init.desktop`
- This automatically starts `/usr/lib/pam_kwallet_init` on login to establish the PAM connection

## Requirements

For KDE Wallet auto-login to work, you MUST meet these requirements:

1. **Same Password**: Your KWallet password MUST be the same as your login password
   - If they differ, auto-login will not work
   - You can change your wallet password in System Settings → KDE Wallet

2. **Default Wallet Name**: Your wallet must be named `kdewallet` (this is the default)
   - Check in `~/.local/share/kwalletd/` for `kdewallet.kwl` and `kdewallet.salt`

3. **Blowfish Encryption**: The wallet must use standard Blowfish encryption (not GPG keys)
   - This is the default for KDE Wallet

## How to Set Up on a New Machine

1. Run `chezmoi apply` to install all configurations
2. The `run_once_01_install-packages_linux.sh` script will install `kwallet-pam`
3. On first login after installation:
   - KWallet will prompt you to create a new wallet
   - **Important**: Set the wallet password to match your login password
4. Log out and log back in
5. KWallet should now unlock automatically

## Changing Your Wallet Password

If you need to change your wallet password to match your login password:

1. Open System Settings
2. Go to KDE Wallet
3. Change the password for the `kdewallet` wallet
4. Make sure it matches your login password exactly
5. Log out and log back in to test

## Troubleshooting

### Wallet Still Prompts for Password

1. Verify your wallet password matches your login password
2. Check that kwallet-pam is installed: `pacman -Q kwallet-pam`
3. Verify PAM configuration in `/etc/pam.d/sddm` includes kwallet lines
4. Check that `/usr/lib/pam_kwallet_init` exists and is executable
5. Look for errors in system logs: `journalctl -b | grep -i kwallet`

### After System Upgrade

If auto-login stops working after a system upgrade:
1. Verify kwallet-pam is still installed
2. Check if `/etc/pam.d/sddm` was modified
3. Reboot the system

## Limitations

- Does not work with fingerprint readers (no password to capture)
- Does not work with auto-login (same reason - no password)
- Only works with Blowfish-encrypted wallets (not GPG)
- Wallet password must always match login password

## References

- [KDE Wallet ArchWiki](https://wiki.archlinux.org/title/KDE_Wallet)
- [kwallet-pam GitHub](https://github.com/KDE/kwallet-pam)

## Date Configured

2026-01-03
