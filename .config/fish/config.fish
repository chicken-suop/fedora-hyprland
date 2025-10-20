function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive # Commands to run in interactive sessions can go here
    # Hayase alias
    alias hayase='/home/elliot/Applications/linux-hayase-6.4.26-linux.AppImage'

    # No greeting
    set fish_greeting

    # Set code as default editor
    set -gx EDITOR code
    set -gx VISUAL code

    # Qt/Wayland environment variables for better compatibility
    set -gx QT_QPA_PLATFORM wayland
    set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION 1
    set -gx QT_AUTO_SCREEN_SCALE_FACTOR 1
    set -gx QT_WAYLAND_FORCE_DPI 96

    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    alias pamcan pacman
    alias ls 'eza --icons'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'
    alias pramdb-tunnel 'autossh -M 0 -N pram-tunnel'
    alias record-audio 'ffmpeg -f pulse -i alsa_input.usb-K66_K66_20190805V001-00.analog-stereo -f pulse -i alsa_output.usb-Schiit_Audio_Schiit_USB_Multibit-00.analog-stereo.monitor -map 0:0 -ac 2 -ar 96000 -sample_fmt s32 input.wav -map 1:0 -ac 2 -ar 96000 -sample_fmt s32 output.wav'

    # Kitty integration
    if test "$TERM" = "xterm-kitty"
        alias s 'kitty +kitten ssh'
        alias icat "kitty +kitten icat"
        alias d "kitty +kitten diff"
        alias hg "kitten hyperlinked_grep"
    end

end

# BUN environment variable
set -gx BUN_INSTALL "$HOME/.bun"

# Add Bun to PATH
fish_add_path $HOME/.bun/bin

# Add NVM Node.js to PATH
fish_add_path $HOME/.nvm/versions/node/v24.4.1/bin

# Pyenv configuration
set -gx PYENV_ROOT "$HOME/.pyenv"
fish_add_path "$PYENV_ROOT/bin"
pyenv init - fish | source
pyenv virtualenv-init - fish | source

# pnpm
set -gx PNPM_HOME "/home/elliot/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
alias git-redate="git rebase --exec \"GIT_COMMITTER_DATE=\\\"\$(date)\\\" git commit --amend --no-edit --date=\\\"\$(date)\\\""
