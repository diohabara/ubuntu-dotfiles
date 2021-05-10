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

# misc
GHQ_ROOT="${HOME}/repo"
REPO_ROOT="${GHQ_ROOT}/github.com/diohabara/ubuntu-dotfiles"
DOTFILES_HOME="${REPO_ROOT}/dotfiles"

command mkdir -p "${ZSH_FUNCCOMP_DIR}"

function command_exists() {
  type "$1" &> /dev/null ;
}

: "remap keys" && {
  gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" # turn capslock into control
}

: "install packages by snap" && {
  sudo snap set system experimental.parallel-instances=true
  sudo snap install --classic flutter android-studio
}

: "install packages by apt" && {
  echo "deb http://security.ubuntu.com/ubuntu bionic-security main" | sudo tee -a /etc/apt/sources.list.d/bionic.list # https://askubuntu.com/questions/462094/unable-to-install-libssl1-0-0i386-due-to-unmet-dependencies/462471#462471
  sudo apt update
  sudo apt upgrade -y
  sudo apt purge -y --autoremove
  sudo apt install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    clang-format \
    gnupg \
    grep \
    lib32z1 \
    libblkid-dev \
    libbz2-1.0:i386 \
    libc6:i386 \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libfontconfig1-dev \
    libfreetype6-dev \
    libgraphite2-dev \
    libgtk-3-dev \
    libharfbuzz-dev \
    liblzma-dev \
    libncurses5:i386 \
    libssl-dev \
    libstdc++6:i386 \
    libtinfo-dev \
    libtool \
    libxcb-xfixes0-dev \
    lsb-release \
    neovim \
    ninja-build \
    pkg-config \
    rlwrap \
    software-properties-common \
    xclip \
    zlib1g-dev \

}

: "install nix" && {
  if ! command_exists nix; then
    # Doc: https://nixos.org/download.html
    curl -L https://nixos.org/nix/install | sh
    . "${HOME}/.nix-profile/etc/profile.d/nix.sh"
  fi

  if command_exists nix; then
    # Doc: https://nixos.org/manual/nix/stable/#ch-upgrading-nix
    nix-channel --update; nix-env -iA nixpkgs.nix
  fi

  : "install nixpkgs" && {
    if command_exists nix-env; then
      # Doc: https://nixos.org/manual/nixpkgs/stable/#sec-declarative-package-management
      nix-env -iA nixpkgs.myPackages
    fi
  }
}

: "install Doom Emacs" && {
  if ! [ -d "$HOME/.emacs.d" ]; then
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
  fi
}

: "install go" && {
  : "install go packages" && {
    if command_exists go; then
      go get -u github.com/bazelbuild/bazelisk # https://docs.bazel.build/versions/master/install-ubuntu.html
      go get -u github.com/bazelbuild/buildtools/buildifier # https://github.com/bazelbuild/buildtools/blob/master/buildifier/README.md
      go get -u github.com/cweill/gotests/...
      go get -u github.com/fatih/gomodifytags
      go get -u github.com/golangci/golangci-lint/cmd/golangci-lint # https://golangci-lint.run/usage/install/
      go get -u github.com/motemen/gore/cmd/gore
      go get -u github.com/stamblerre/gocode
      go get -u github.com/x-motemen/ghq # https://github.com/x-motemen/ghq
      go get -u golang.org/x/tools/cmd/godoc
      go get -u golang.org/x/tools/cmd/goimports
      go get -u golang.org/x/tools/cmd/gorename
      go get -u golang.org/x/tools/cmd/guru
    fi
  }
}

: "install python" && {
  : "install pyenv" && {
    if ! command_exists pyenv; then
      # Doc: https://github.com/pyenv/pyenv-installer
      rm -rf ~/.pyenv
      curl https://pyenv.run | bash
      # Doc: https://github.com/pyenv/pyenv
    fi
  }

  : "install via pip3" && {
    if command_exists pip3; then
      pip3 install --upgrade pip
      pip3 install black --user
      pip3 install isort --user
      pip3 install pyflakes --user 
      pip3 install pytest --user
      pip3 install python-language-server[all] --user
      pip3 install wakatime --user
      pip3 install atcoder-tools --user
    fi
  }
}

: "install rust packages" && {
  if ! command_exists rustup; then
    # Doc: https://www.rust-lang.org/tools/install
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    source "$HOME/.cargo/env"
  fi

  : "install rustup components" && {
    if command_exist rustup; then
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
    fi
  }

  : "install cargo packages" && {
    if command_exists cargo; then
      cargo install --locked bat # https://github.com/sharkdp/bat#from-source
      cargo install cargo-check
      cargo install cargo-raze
      cargo install cargo-vendor
      cargo install git-delta
    fi
  }
}

: "install npm packages" && {
  if command_exists npm; then
    sudo npm install -g npm
    sudo npm i -g bash-language-server
  fi
}

echo "Complete installation!"
