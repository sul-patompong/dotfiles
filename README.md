# Dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

## Prerequisites (macOS)

Before installation, install the following:

1. **Homebrew**

   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **chezmoi**

   ```sh
   brew install chezmoi
   ```

## Installation

```sh
chezmoi init --apply <your-github-username>
```
