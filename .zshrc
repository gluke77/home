# prompt
setopt PROMPT_SUBST
PROMPT='%(?.%F{green}⏺.%F{red}⏺ [%?])%f %n@%m %F{8}[%D %*]%f %1~ %# '

setopt AUTO_CD
setopt AUTO_PUSHD
setopt CORRECT
setopt CORRECT_ALL

# local executables
export PATH=$HOME/.local/bin:$PATH

export EDITOR=/usr/bin/vim

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

#functions
function mcd {
    mkdir -p $1 && cd $_
}

# aliases
alias ll="ls -alG"
alias ddu="du -h -d 1 2>/dev/null"
alias ddf="df -h"
alias brew-up="brew update && brew upgrade -g && brew autoremove && brew cleanup -s --prune=all && brew outdated --cask"

# node, typescript
if ! type node &> /dev/null; then
    alias node="docker run --rm -it -v .:/src -w /src node $@"
    alias npm="node npm $@"
    alias npx="node npx $@"
    alias npr="npm run $@"
fi

alias tsrun="node -r esbuild-register $@"
alias tsr="tsrun src/index.ts"
alias tsbuild="npx esbuild src/index.ts --bundle --outdir=dist --platform=node $@"

alias tsconfig-init='cat > tsconfig.json <<EOF
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "NodeNext",
    "rootDir": "./src",
    "outDir": "./dist"
  },
  "include": ["src/**/*.ts"],
  "extends": "@tsconfig/strictest/tsconfig.json"
}
EOF
'

alias ts-init="npm init -y && npm add -D typescript @types/node esbuild esbuild-register @tsconfig/strictest && npx tsc --init && mkdir src && echo 'console.log(\"Hello, world!\");' > src/index.ts"

if type pnpm &> /dev/null; then
    alias pts-init="pnpm init && pnpm add -D typescript esbuild esbuild-register @types/node @tsconfig/strictest && pnpm tsc --init && mkdir src && echo 'console.log(\"Hello, world!\");' >> src/index.ts"
fi

