autoload -Uz compinit promptinit colors

if [[ ! -f "$HOME/.zcompdump" ]]; then
    compinit
else
    compinit -C
fi

promptinit
colors

export COLORTERM=truecolor

typeset -U path PATH

setopt PROMPT_SUBST

git_prompt() {
    git rev-parse --is-inside-work-tree &>/dev/null || return
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    [[ -n $branch ]] && echo "%F{magenta}[$branch]%f"
}

PROMPT='%F{cyan}%n@%m%f %F{yellow}%~%f $(git_prompt)
%F{green}❯%f '

precmd() { print }

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

setopt sharehistory
setopt histignorealldups
setopt histreduceblanks
setopt incappendhistory

bindkey -e

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

eval "$(dircolors -b)"

export ORACLE_HOME=/opt/oracle/instantclient_21_21

export ANDROID_SDK_ROOT=$HOME/android-sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export ANDROID_NDK_ROOT=$ANDROID_SDK_ROOT/ndk/25.1.8937393
export NDK_HOME=$ANDROID_NDK_ROOT

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

export LD_LIBRARY_PATH="$ORACLE_HOME:$LD_LIBRARY_PATH"

path=(
    $HOME/.local/bin
    $HOME/dev/flutter/bin
    /opt/nvim-linux-x86_64/bin
    $HOME/zig
    $HOME/Android/platform-tools
    $HOME/Android/cmdline-tools/latest/bin
    $JAVA_HOME/bin
    $ORACLE_HOME
    /usr/games
    /usr/sbin
    /sbin
    $path
)

export PATH

eval "$(zoxide init zsh)"

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
[[ -f "$HOME/.local/share/../bin/env" ]] && source "$HOME/.local/share/../bin/env"

alias volume="pactl set-sink-volume @DEFAULT_SINK@"
alias brave="brave-browser"
alias vim="NVIM_APPNAME=nvim-min nvim"

alias chatgpt="nohup brave-browser --profile-directory=Default --app-id=cadlkienfkclaiaibeoongdcgmdikeeg >/dev/null 2>&1 & disown"
alias jwlibrary="nohup brave-browser --profile-directory=Default --app-id=pahflhkiioelnjakapedhppihcjenhob >/dev/null 2>&1 & disown"
alias whatsapp="nohup brave-browser --profile-directory=Default --app-id=hnpfjngllnobngcgfapefoaidbinmjnm >/dev/null 2>&1 & disown"
alias discord="nohup brave-browser --profile-directory=Default --app-id=mfhpbolkhgobaabcbabdlnhidbjpoogc >/dev/null 2>&1 & disown"
alias jwhub="nohup brave-browser --profile-directory=Default --app-id=mhncldkpggffcpfbkfjkfhncedgghcih >/dev/null 2>&1 & disown"
alias github="nohup brave-browser --profile-directory=Default --app-id=mjoklplbddabcmpepnokjaffbmgbkkgg >/dev/null 2>&1 & disown"
alias gemini="nohup brave-browser --profile-directory=Default --app-id=gdfaincndogidkdcdkhapmbffkckdkhn >/dev/null 2>&1 & disown"

alias vpn="~/scripts/vpn.sh"
alias gitman="~/coding/gitman/target/release/gitman"
alias calc="~/coding/calc/target/release/calc"

# zsh-autosuggestions
if [[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#4C566A'
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# zsh-syntax-highlighting
if [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    ZSH_HIGHLIGHT_STYLES[command]='fg=#88C0D0'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=#B48EAD'
    ZSH_HIGHLIGHT_STYLES[path]='fg=#A3BE8C'
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=#EBCB8B'
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#BF616A,bold'
fi

oracle() {
    local pass
    read -s "pass?Enter Oracle password: "
    echo
    docker exec -it oracle-xe sqlplus system/${pass}@XE
}

to-mp4() {
    [[ $# -eq 2 ]] || {
        echo "Usage: to-mp4 input.mkv output.mp4"
        return 1
    }

    ffmpeg -hide_banner -loglevel error -stats \
        -i "$1" \
        -map 0 \
        -c:v libx264 -crf 23 -preset medium \
        -c:a aac -b:a 128k \
        -movflags +faststart \
        "$2"
}

# opencode
export PATH=/home/sham_404/.opencode/bin:$PATH
