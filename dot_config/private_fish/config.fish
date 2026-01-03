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

# .NET configuration
set -gx DOTNET_ROOT /usr/share/dotnet
fish_add_path ~/.dotnet/tools

starship init fish | source
