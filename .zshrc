if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_THEME="eastwood"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=100"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export LOGIN_AS_INSTANCE=templatesb
export LOGIN_AS_USER_EMAIL=stephen@ortto.com
export LOGIN_AS_USER_ID=604abbaee590b135847639de

alias edge="cd ~/src/ortto/api/ap3-edge && ./start.sh"

alias edge-crm="(edge --crm-ui)"
alias edge-campaigns="(edge --campaigns-ui)"
alias edge-assets="(edge --assets-ui)"
alias edge-capture="(edge --capture-ui)"
alias edge-app="(edge --ui)"
alias edge-activities="(edge --activities-ui)"
alias edge-reports="(edge --reports-ui)"
alias edge-audiences="(edge --audiences-ui)"
alias edge-dashboard="(edge --dashboard-ui)"
alias edge-data-sources="(edge --data-sources-ui)"
alias edge-foundations="(edge --foundations-ui)"
alias edge-messages="(edge --messages-ui)"
alias edge-setup="(edge --setup-ui)"
alias edge-signup="(edge --signup-ui)"
alias edge-home="(edge --home-ui)"
alias edge-asset-manager="(edge --asset-manager-ui)"
alias edge-knowledge-base="(edge --knowledge-base-ui)"

ap3() {
  cd "${HOME}/src/ortto/client/ap3-${1}-ui"
}

ap3s() {
  cd "${HOME}/src/ortto/api/"
}

ap3env() {
  tmuxinator start ap3 ${@:1}
}

# Colorise the top Tabs of Iterm2 with the same color as background
# Just change the 18/26/33 wich are the rgb values
echo -e "\033]6;1;bg;red;brightness;18\a"
echo -e "\033]6;1;bg;green;brightness;26\a"
echo -e "\033]6;1;bg;blue;brightness;33\a"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

alias vim='nvim'
export EDITOR='nvim'
alias luamake=/Users/stephenbland/tools/lua-language-server/3rd/luamake/luamake

# speed up nvm
chpwd() {
  if [ -f ./.nvmrc ]
  then
    current=`nvm current`
    req=`cat ./.nvmrc`
    if [ "$current" != "$req" ]
    then
        nvm use
    fi
  fi
}

# lazygit alias
alias lg='lazygit'

clean_branches() {
	branches=`git branch --merged=master | grep -v master`
  if [[ ! -z $branches ]]
        then
                git branch -d $(git branch --merged=master | grep -v master)
                git fetch --prune
        fi
	}
alias cb=clean_branches

alias nvimconfig="cd ~/.config/nvim"
