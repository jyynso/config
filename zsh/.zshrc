export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="minimal"

zstyle ':omz:update' mode reminder

# ENABLE_CORRECTION="true"

# COMPLETION_WAITING_DOTS="true"

# plugins
plugins=(
   git
   zsh-autosuggestions
   zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

#alias
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias ff="fastfetch"
alias lg="lazygit"
