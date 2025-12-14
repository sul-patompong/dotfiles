if status is-interactive
    set -g fish_greeting

    # eza aliases
    if command -q eza
        alias ls='eza -lh --group-directories-first --icons=auto'
        alias lsa='ls -a'
        alias lt='eza --tree --level=2 --long --icons --git'
        alias lta='lt -a'
    end
end

export PATH="$PATH:/home/pbeam1992/.dotnet/tools"
export PATH="$HOME/.local/bin:$PATH"

# asdf (installed via pacman on Arch)
fish_add_path ~/.asdf/shims

starship init fish | source
