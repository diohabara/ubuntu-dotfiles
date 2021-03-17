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


: "install packages by nix" && {
  echo "Installing packages by nix..."
  nix-env -iA nixpkgs.myPackages
  # Doc: https://nixos.org/manual/nixpkgs/stable/#sec-declarative-package-management
  nix-env -iA nixpkgs.myPackages
  echo "Installed packages by brew!"
}


: "install go packages" && {
  if command_exists go; then
    go get -u github.com/motemen/gore/cmd/gore
    go get -u github.com/stamblerre/gocode
    go get -u golang.org/x/tools/cmd/godoc
    go get -u golang.org/x/tools/cmd/goimports
    go get -u golang.org/x/tools/cmd/gorename
    go get -u golang.org/x/tools/cmd/guru
    go get -u github.com/cweill/gotests/...
    go get -u github.com/fatih/gomodifytags
  fi
}

: "install haskell" && {
  : "install ghcup" && {
    if ! command_exists ghcup; then
      installing 'ghcup'
      # Doc: https://gitlab.haskell.org/haskell/ghcup-hs
      curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
      installed 'ghcup'
    else
      already 'ghcup'
    fi
  }
  : "install haskell package" && {
    if ! command_exists stack; then
      stack setup
      stack install ghc-mod
      stack install hoogle
    fi

    if ! command_exists ghcup; then
      ghcup install hls
    fi
  }
}

: "install ocaml" && {
  : "install opam packages" && {
    if command_exists opam; then
      opam install merlin
      opam install utop
      opam install ocp-indent
      opam install dune
      opam install ocamlformat
    fi
  }
}

: "install python" && {
  : "install poetry" && {
    if ! command_exists poetry; then
        # Doc: https://python-poetry.org/docs/
      curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3
      installed 'poetry'
    else
      already 'poetry'
    fi
  }
  : "install via pip3" && {
    if command_exists pip3; then
      already 'pip3'
      pip3 install wakatime
      pip3 install pytest
      pip3 install black
      pip3 install pyflakes
      pip3 install isort
      pip3 install python-language-server[all]
    fi
  }
}

: "install rust packages" && {
  if ! command_exists rustup; then
    installing 'Rust'
    # Doc: https://www.rust-lang.org/tools/install
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    installed 'Rust'
  fi
  : "install rustup components" && {
    rustup toolchain install stable
    rustup toolchain install nightly
    rustup update
    # Doc: https://rust-lang.github.io/rustup/installation/index.html#enable-tab-completion-for-bash-fish-zsh-or-powershell
    rustup completions zsh > "${ZSH_FUNCCOMP_DIR}/_rustup"
    # For rust-analyzer
    # Doc: https://rust-analyzer.github.io/manual.html#installation
    rustup component add rust-src
    # Doc: https://github.com/hlissner/doom-emacs/blob/d62c82ddbe0c9fa603be24f5eb8e563d16f5e45f/modules/lang/rust/README.org
    rustup component add rustfmt-preview
    rustup component add clippy-preview
    # For rls
    # Doc: https://github.com/rust-lang/rls
    rustup component add rls
    rustup component add rust-analysis
    rustup component add rust-src
  }

  : "install cargo packages" && {
    if command_exists cargo; then
      already 'cargo'
      cargo install cargo-check
      cargo install cargo-raze
      cargo install cargo-vendor
      cargo install mdbook
    fi
  }
}

: "install npm packages" && {
  if command_exists npm; then
    sudo npm i -g bash-language-server
    sudo npm install -g pyright
  fi
}

echo "Complete installation!"
