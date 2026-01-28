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

export JAVA_HOME=/usr/lib/jvm/jdk-21.0.4+7
export ANDROID_HOME=$HOME/Android
export CHROME_EXECUTABLE=/usr/bin/chromium

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

##### -------------------------------
##### Cargo environment
##### -------------------------------

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
export PATH="$HOME/zig:$PATH"

##### -------------------------------
##### Optional: enable if installed
##### -------------------------------

# Autosuggestions
[[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting (must be last)
[[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
