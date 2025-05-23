# prompt
setopt PROMPT_SUBST
PROMPT='%(?.%F{green}⏺.%F{red}⏺ [%?])%f %n@%m %F{8}[%D %*]%f %1~ %# '

setopt AUTO_CD
setopt AUTO_PUSHD
setopt CORRECT
setopt CORRECT_ALL

# local executables
export PATH=$HOME/.local/bin:$PATH

# brew
eval $(/opt/homebrew/bin/brew shellenv)
export FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

[[ -f $HOME/.cargo/env ]] && source $HOME/.cargo/env

if type rustc &> /dev/null; then
    export FPATH="$(rustc --print sysroot)"/share/zsh/site-functions:$FPATH
fi

# autocompletion
autoload -Uz compinit && compinit
zstyle ':completion:*' rehash true

# rust
if type rustup &> /dev/null; then
    eval "$(rustup completions zsh)"
    #eval "$(rustup completions zsh cargo)"
fi


if type fzf &> /dev/null; then
    if type fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND="fd"
        export FZF_CTRL_T_COMMAND="fd"
        export FZF_ALT_C_COMMAND="fd --type d"
    elif type rg &> /dev/null; then
        export FZF_DEFAULT_COMMAND='rg --files'
    fi

    export FZF_COMPLETION_TRIGGER="??"

    eval "$(fzf --zsh)"
fi

if type direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi

if type uv &> /dev/null; then
    eval "$(uv generate-shell-completion zsh)"
fi

if type uvx &> /dev/null; then
    eval "$(uvx --generate-shell-completion zsh)"
fi


# aliases
alias ll="ls -alG"
alias brew-up="brew update && brew upgrade -g && brew autoremove && brew cleanup -s --prune=all && brew outdated --cask"
alias dnode="docker run --rm -it -v .:/src -w /src node $@"
alias dnpm="docker run --rm -it -v .:/src -w /src node npm $@"
alias dnpmrun="docker run --rm -it -v .:/src -w /src node npm run $@"

