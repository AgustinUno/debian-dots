# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.9
# Custom for Augustine
# Feb 06, 2024


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# stty -ixon # Disables ctrl-s and ctrl-q (Used To Pause Term)

# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias install='sudo apt install'
alias update='sudo apt update'
alias upgrade='sudo nala upgrade'
alias uplist='nala list --upgradable'
alias remove='sudo nala autoremove'
alias l='exa -ll --color=always --group-directories-first'
alias ls='exa -al --header --icons --group-directories-first'
alias df='df -h'
alias free='free -h'
alias myip="ip -f inet address | grep inet | grep -v 'lo$' | cut -d ' ' -f 6,13 && curl ifconfig.me && echo ' external ip'"
alias x="exit"
# Dotfiles & Files
alias zs='nvim ~/.zshrc'
alias reload='source ~/.zshrc'
alias v="nvim"
alias vv="nvim ."
alias g.="cd ~/.config"
alias gd="cd ~/Downloads"
alias gdw="cd ~/.config/suckless/dwm"
alias gds="cd ~/.config/suckless/slstatus"
# Git aliases
alias gp="git push -u origin main"
alias gsave="git commit -m 'save'"
alias gs="git status"
alias gc="git clone"

alias ff="neofetch"

# Dunst
alias hi="notify-send 'Hi there!' 'Welcome to Justine's desktop! ' -i ''"

# Add Color
alias egrep='grep --color=auto'

# User Customization
alias hg='history | grep'
alias netcon='~/scripts/connect_wifi.sh'
alias sway-reboot='swaymsg reload'
alias t='tmux'
alias ss='nvim ~/.config/sway/config.d/custom.conf'

# PATH
#export SWAY_CONFIG=/etc/
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/.config/bspwm/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/node/bin:$PATH"
export PATH="/usr/local/nvim/bin:$PATH"
export PATH="$HOME/.config/rofi/scripts:$PATH"
export VISUAL=nvim
export EDITOR=nvim

export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"


# Zsh-Specific Features:
autoload -Uz compinit && compinit   # Initialize completion
setopt autocd                       # Change directories without `cd`
setopt correct                      # Auto-correct commands
setopt histignorealldups            # Ignore duplicate history entries

# Color codes
RED="%F{1}"
GREEN="%F{2}"
YELLOW="%F{3}"
BLUE="%F{4}"
MAGENTA="%F{5}"
CYAN="%F{6}"
WHITE="%F{7}"
ENDC="%f"

# Prompt (Zsh uses `PROMPT` instead of `PS1`)
if [[ -n "$SSH_CLIENT" ]]; then ssh_message="-ssh_session"; fi
PROMPT="${MAGENTA}[%*] ${GREEN}%n${WHITE}@${YELLOW}%m${RED}${ssh_message} ${WHITE}in ${BLUE}%~ \n${CYAN}%#${ENDC} "

# Load plugins if you use Oh My Zsh or zinit
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit   
source "${ZINIT_HOME}/zinit.zsh"

# powerlevel10k 
zinit ice depth=1; zinit light romkatv/powerlevel10k

# typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab


# Load completions
autoload -Uz compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
# setopt hist_ignore_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu hist_save_no_dups
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias fo="fzf_open"
alias cc='cliphist wipe && echo "Clipboard wiped!"'
alias lzg='lazygit'
# Shell integrations
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init --cmd cd zsh)"
fi

# eval "$(fzf --zsh)"
# eval "$(zoxide init --cmd cd zsh)"

# FZF Command to open file or directories
fzf_open() {
    local selected=$(fzf)

    if [[ -z "$selected" ]]; then
        return  # Do nothing if no selection
    elif [[ -d "$selected" ]]; then
        cd "$selected" || return  # If it's a directory, change to it
    elif [[ -f "$selected" ]]; then
        nvim "$selected"  # If it's a file, open in Neovim
    fi
}

# Check if cliphist is already running
if ! pgrep -x "wl-paste" > /dev/null; then
    wl-paste --watch cliphist store &
    rm ~/.cache/cliphist/db
fi
#    echo "clipboard already running..."



export PATH="$HOME/.local/bin:$PATH"
# export ZED_DISABLE_GPU=1
