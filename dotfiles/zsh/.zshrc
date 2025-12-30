# Terminal history
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Setting up nvim and wezterm interaction
[ -n "$WEZTERM_PANE" ] && export NVIM_LISTEN_ADDRESS="/tmp/nvim$WEZTERM_PANE"
#alias wezterm='flatpak run org.wezfurlong.wezterm'

# Starship
eval "$(starship init zsh)"

# CLI completion and suggestion
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Eza and zoxide
alias ls="eza --icons=always"

eval "$(zoxide init zsh)"
alias cd="z"

# fd
alias fd="fdfind"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
