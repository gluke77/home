# prompt
setopt PROMPT_SUBST
PROMPT='%(?.%F{green}⏺.%F{red}⏺ [%?])%f %n@%m %F{8}[%D %*]%f %1~ %# '

setopt AUTO_CD
setopt AUTO_PUSHD
setopt CORRECT
setopt CORRECT_ALL

# brew
eval $(/opt/homebrew/bin/brew shellenv)
export FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

# rust
export FPATH=$(brew --prefix)/opt/rustup/share/zsh/site-functions:$FPATH
export FPATH=$HOME/.rustup/toolchains/stable-aarch64-apple-darwin/share/zsh/site-functions:$FPATH
#export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
[[ -f $HOME/.cargo/env ]] && source $HOME/.cargo/env

# autocompletion
autoload -Uz compinit && compinit
zstyle ':completion:*' rehash true

# fzf
if type fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND="fd"
    export FZF_CTRL_T_COMMAND="fd"
    export FZF_ALT_C_COMMAND="fd --type d"
elif type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
fi

export FZF_COMPLETION_TRIGGER="??"

if type fzf &> /dev/null; then
    eval "$(fzf --zsh)"
fi

if type direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi

# local executables
export PATH=$HOME/.local/bin:$PATH

# aliases
alias ll="ls -alG"
alias brew-up="brew update && brew upgrade -g && brew autoremove && brew cleanup -s --prune=all && brew outdated --cask"
