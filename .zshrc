##### -------------------------------
##### Core initialization
##### -------------------------------

# Faster startup: cache completion
autoload -Uz compinit promptinit
if [[ ! -d "$HOME/.zcompdump" ]]; then
  compinit
else
  compinit -C
fi

promptinit

##### -------------------------------
##### Prompt: clean + git aware
##### -------------------------------

# Colors
autoload -Uz colors && colors
export COLORTERM=truecolor

setopt PROMPT_SUBST

git_prompt() {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  [[ -n $branch ]] && echo "%F{magenta}[$branch]%f"
}

PROMPT='%F{cyan}%n@%m%f %F{yellow}%~%f $(git_prompt)
%F{green}❯%f '

##### -------------------------------
##### History: shared, clean, useful
##### -------------------------------

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

setopt sharehistory
setopt histignorealldups
setopt histreduceblanks
setopt incappendhistory

##### -------------------------------
##### Keybindings
##### -------------------------------

# Emacs keys (change to -v if you want vim mode)
bindkey -e

##### -------------------------------
##### Completion styling
##### -------------------------------

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

eval "$(dircolors -b)"

##### -------------------------------
##### PATH: clean and deduplicated
##### -------------------------------

path=(
  $HOME/.local/bin
  $HOME/dev/flutter/bin
  /opt/nvim-linux-x86_64/bin
  $HOME/Android/platform-tools
  $HOME/Android/cmdline-tools/latest/bin
  /usr/sbin
  /sbin
  $path
)

export PATH

##### -------------------------------
##### Aliases
##### -------------------------------

alias volume="pactl set-sink-volume @DEFAULT_SINK@"

alias brave="brave-browser"

alias neovide="NVIM_APPNAME=nvim-blaze $HOME/Downloads/Neovide/neovide.AppImage"
alias nvchad="NVIM_APPNAME=nvim-nvchad nvim"
alias blaze="NVIM_APPNAME=nvim-blaze nvim"
alias vim="NVIM_APPNAME=nvim-min nvim"

alias chatgpt="nohup brave-browser --profile-directory=Default --app-id=cadlkienfkclaiaibeoongdcgmdikeeg >/dev/null 2>&1 & disown"
alias jwlibrary="nohup brave-browser --profile-directory=Default --app-id=pahflhkiioelnjakapedhppihcjenhob >/dev/null 2>&1 & disown"
alias whatsapp="nohup brave-browser --profile-directory=Default --app-id=hnpfjngllnobngcgfapefoaidbinmjnm >/dev/null 2>&1 & disown"
alias discord="nohup brave-browser --profile-directory=Default --app-id=mfhpbolkhgobaabcbabdlnhidbjpoogc >/dev/null 2>&1 & disown"
alias jwhub="nohup brave-browser --profile-directory=Default --app-id=mhncldkpggffcpfbkfjkfhncedgghcih >/dev/null 2>&1 & disown"
alias github="nohup brave-browser --profile-directory=Default --app-id=mjoklplbddabcmpepnokjaffbmgbkkgg >/dev/null 2>&1 & disown"
alias gemini="nohup brave-browser --profile-directory=Default --app-id=gdfaincndogidkdcdkhapmbffkckdkhn >/dev/null 2>&1 & disown"

alias vpn="~/scripts/vpn.sh"
alias gitman="~/coding/gitman/target/debug/gitman"
alias calc="~/coding/calc/target/debug/calc"


precmd() {
    print
}


##### -------------------------------
##### Cargo environment
##### -------------------------------

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
export PATH="$HOME/zig:$PATH"

## Oracle Instant Client
export ORACLE_HOME=/opt/oracle/instantclient_21_21
export LD_LIBRARY_PATH=$ORACLE_HOME:$LD_LIBRARY_PATH
export PATH=$ORACLE_HOME:$PATH#### Oracle environment

## Android sdk paths 
export ANDROID_SDK_ROOT=$HOME/android-sdk
export ANDROID_NDK_ROOT=$HOME/android-sdk/ndk/25.1.8937393
export ANDROID_HOME=$HOME/android-sdk
export NDK_HOME=$HOME/android-sdk/ndk/25.1.8937393

export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

## Java paths
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

##### -------------------------------
##### Optional: enable if installed
##### -------------------------------

# Autosuggestions
[[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting (must be last)
[[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

oracle() {
  local pass
  read -s "pass?Enter Oracle password: "
  echo
  # rlwrap -a -N -O '^SQL> $' -w -1 docker exec -i oracle-xe sh -c "sqlplus system/${pass}@XE"   
  docker exec -it oracle-xe sqlplus system/${pass}@XE   
}   

to-mp4() {
    if [[ $# -ne 2 ]]; then
        echo "Usage: to-mp4 input.mkv output.mp4"
        return 1
    fi

    ffmpeg -hide_banner -loglevel error -stats \
        -i "$1" \
        -map 0 \
        -c:v libx264 -crf 23 -preset medium \
        -c:a aac -b:a 128k \
        -movflags +faststart \
        "$2"
}
export PATH=$PATH:/usr/games
