if status is-interactive
    set -g fish_greeting
end

export PATH="$PATH:/home/pbeam1992/.dotnet/tools"
export PATH="$HOME/.local/bin:$PATH"

starship init fish | source
