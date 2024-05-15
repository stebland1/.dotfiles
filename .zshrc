export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
	git
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

alias nvimconfig="cd ~/dotfiles/.config/nvim"
alias vim="nvim"
alias lg="lazygit"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
