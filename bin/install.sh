#!/usr/bin/env bash
set -eu
export LC_ALL=C
export LANG=C
IFS="$(printf " \t\nx")"

# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_DATA_HOME="${HOME}/.share"

# data direcotory for zsh
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

ZSH_FUNCCOMP_DIR="${ZDOTDIR}/func_comp"
GHQ_ROOT="${HOME}/repo"
REPO_ROOT="${GHQ_ROOT}/github.com/diohabara/ubuntu-dotfiles"
DOTFILES_HOME="${REPO_ROOT}/dotfiles"

command mkdir -p "${ZSH_FUNCCOMP_DIR}"

function command_exists() {
  type "$1" &> /dev/null ;
}

function installing() {
  echo "Installing $1..."
}

function installed() {
  echo "$1 is installed!"
}

function already() {
  echo "$1 is already installed"
}


: "install nix" && {
  if ! command_exists nix-env; then
    installing 'nix'
    # Doc: https://nixos.org/guides/install-nix.html
    sh <(curl -L https://nixos.org/nix/install)
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable
    nix-channel --update
    installed 'nix'
  else
    already 'nix'
  fi
}

# write in nix
# : "install packages by brew" && {
#   echo "Installing packages by brew..."
#   # Doc: https://homebrew-file.readthedocs.io/en/latest/usage.html
#   brew bundle install --file "${REPO_ROOT}/.Brewfile" --no-lock
#   echo "Installed packages by brew!"
# }

: "install python packages" && {
  if ! command_exists poetry; then
    installing 'poetry'
    # Doc: https://python-poetry.org/docs/
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3
    installed 'poetry'
  else
    already 'poetry'
  fi
}

: "install rust packages" && {
  if ! command_exists rustup; then
    installing 'Rust'
    # Doc: https://www.rust-lang.org/tools/install
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    # Doc: https://rust-lang.github.io/rustup/installation/index.html#enable-tab-completion-for-bash-fish-zsh-or-powershell
    rustup completions zsh > "${ZSH_FUNCCOMP_DIR}/_rustup"
    # For rust-analyzer
    # Doc: https://rust-analyzer.github.io/manual.html#installation
    rustup component add rust-src
    installed 'Rust'
  else
    rustup update
  fi
}

: "install pip3 packages" && {
  if command_exists pip3; then
    already 'pip3'
    pip3 install wakatime
  fi
}

: "install cargo packages" && {
  if command_exists cargo; then
    already 'cargo'
    cargo install cargo-raze
    cargo install cargo-vendor
    cargo install mdbook
  fi
}

: "install haskell packages" && {
  if ! command_exists stack; then
    installing 'Haskell-Stack'
    # Doc: https://docs.haskellstack.org/en/stable/README/
    curl -sSL https://get.haskellstack.org/ | sh -s - -f
    installed 'Haskell-Stack'
  else
    already 'Haskell-Stack'
  fi

  if ! command_exists ghcup; then
    installing 'ghcup'
    # Doc: https://gitlab.haskell.org/haskell/ghcup-hs
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
    installed 'ghcup'
  else
    already 'ghcup'
  fi
}

echo "Complete installation!"
