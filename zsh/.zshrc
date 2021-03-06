# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_DISABLE_COMPFIX=true
ZSH_THEME="powerlevel10k/powerlevel10k"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git zsh-autosuggestions node kube-ps1 pyenv)

source $ZSH/oh-my-zsh.sh

### p10k ###
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Powerlevel9k settings supported by p10k
POWERLEVEL9K_VCS_GIT_ICON=$''
POWERLEVEL9K_CUSTOM_KUBE_PS1='kube_ps1'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv pyenv custom_kube_ps1 status root_indicator background_jobs battery time)

### NVM initialization ###
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### Pyenv initialization ###
eval "$(pyenv init -)"

### Golang ###
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

### Alias ###
alias encrypt=~/encrypt.sh
alias decrypt=~/decrypt.sh
alias k=kubectl
alias kg='kubectl get'
alias kgpo='kubectl get pods'
alias kgno='kubectl get nodes'
alias ka='kubectl apply'

### kube-ps1 ###
KUBE_PS1_PREFIX='' # default (
KUBE_PS1_SUFFIX='' # default )
KUBE_PS1_NS_COLOR=blue
# This shortens the cluster name based on our EKS cluster naming pattern,
# taking just the characters between the first and second dashes after "cluster/".
# It should not affect other cluster names, so should be safe as default.
get_cluster_short() { if [[ "$1" =~ ^arn:aws:eks ]]; then echo "$1" | rev | cut -d'/' -f 1 | rev; fi; }
KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short
