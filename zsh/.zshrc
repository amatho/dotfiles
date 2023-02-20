autoload -Uz compinit

# Generate completions once a day
setopt EXTENDEDGLOB
for dump in $ZDOTDIR/.zcompdump(#qN.m1); do
  compinit
  if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
    zcompile "$dump"
  fi
done
unsetopt EXTENDEDGLOB
compinit -C

zstyle ':completion:*' menu select

export NVM_LAZY_LOAD=true
source "$ZDOTDIR/zsh_plugins.sh"
source "$ZDOTDIR/zsh_platform.sh"

if [[ "$(uname -s)" == "Darwin" ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
alias la='ls -a'
alias ll='ls -l'
alias lal='ls -al'

alias g='git'
alias gst='git status'
alias ga='git add'
alias gdf='git diff'
alias gfe='git fetch'
alias gpl='git pull'
alias gp='git push'
alias gco='git checkout'
alias gc='git commit'
alias gcm='git commit -m'
alias gbr='git branch'
alias glg='git log'
alias gmr='git merge'
alias grb='git rebase'
alias gsw='git switch'
alias gcl='git clone'
alias grst='git reset'

# SDKMAN!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

eval "$(starship init zsh)"
