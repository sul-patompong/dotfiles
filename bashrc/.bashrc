# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
# source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# File system
if command -v eza &>/dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# Make an alias for invoking commands you use constantly
# alias p='python'

# asdf version manager
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Add .NET Core SDK tools
export PATH="$PATH:/home/pbeam1992/.dotnet/tools"

# asdf version manager
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
