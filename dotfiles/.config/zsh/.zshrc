# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_DATA_HOME="${HOME}/.share"

# Autocompletion
autoload -Uz compinit
compinit -u
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
eval "$(gh completion -s zsh)"

# divided files
source ${XDG_CONFIG_HOME}/zsh/".alias"

# PATH
export PATH="/usr/local/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"

# Doom Emacs
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
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:${HOME}/.go/bin"

# Shell prompt
eval "$(starship init zsh)"
source <("/home/jio/.cargo/bin/starship" init zsh --print-full-init)
export STARSHIP_CONFIG=~/.config/starship.toml

## Toolchain
# Doc: https://github.com/riscv/riscv-gnu-toolchain
export PATH="${PATH}:${HOME}/opt/riscv/bin"

## WSL2
# Doc: https://github.com/microsoft/WSL/issues/4106#issuecomment-501885675
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
