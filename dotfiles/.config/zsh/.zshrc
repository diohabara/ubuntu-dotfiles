# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_DATA_HOME="${HOME}/.share"

# Autocompletion
autoload -Uz compinit
compinit -u
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
eval "$(gh completion -s zsh)"

# Shell prompt
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship.toml

# history
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history
export HISTFILE=${XDG_CONFIG_HOME}/zsh/.zsh_history # where to save
export HISTSIZE=1000 # max size in memory
export SAVEHIST=100000 # max size in .zsh_history
setopt hist_ignore_dups # never save duplicates

# divided files
source ${XDG_CONFIG_HOME}/zsh/".alias"

# PATH
export PATH="/usr/local/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="${HOME}/.emacs.d/bin:${PATH}"

## LLVM
export PATH="/usr/local/opt/llvm/bin:${PATH}" # LLVM
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

# Languages
## Python
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init -)"
### poetry
source "${HOME}/.poetry/env"

## Rust
export PATH="${HOME}/.cargo/bin:${PATH}"
export PKG_CONFIG_PATH="${HOME}/bin/convert"

## Go
export GOPATH="${HOME}/go" # https://github.com/golang/go/wiki/SettingGOPATH
export PATH="${PATH}:/usr/local/go/bin"
export PATH="${PATH}:${HOME}/go/bin"

