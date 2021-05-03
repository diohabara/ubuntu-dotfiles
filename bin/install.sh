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

function installing() {
  echo "Installing $1..."
}

function installed() {
  echo "$1 is installed!"
}

function already() {
  echo "$1 is already installed"
}

: "remapping" && {
  gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']" # turn capslock into control
}

: "uninstall packages by apt" && {
  sudo apt purge -y --autoremove
}

#: "add packages via ppa" && {
  # Doc: https://ubuntuhandbook.org/index.php/2020/09/install-emacs-27-1-ppa-ubuntu-20-04/
  # sudo add-apt-repository ppa:kelleyk/emacs
#}

: "install packages by apt" && {
  echo "deb http://security.ubuntu.com/ubuntu bionic-security main" | sudo tee -a /etc/apt/sources.list.d/bionic.list # https://askubuntu.com/questions/462094/unable-to-install-libssl1-0-0i386-due-to-unmet-dependencies/462471#462471
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y \
    apt-transport-https \
    bash \
    build-essential \
    ca-certificates \
    ccls \
    clang-format \
    cmake \
    curl \
    ffmpeg \
    fzf \
    gdb \
    gnupg \
    grep \
    gzip \
    jq \
    libfontconfig1-dev \
    libfreetype6-dev \
    libgraphite2-dev \
    libharfbuzz-dev \
    libssl-dev \
    libtinfo-dev \
    libtool \
    libxcb-xfixes0-dev \
    llvm \
    lsb-release \
    neofetch \
    neovim \
    pkg-config \
    rlwrap \
    shellcheck \
    software-properties-common \
    tcl \
    tmux \
    unzip \
    wget \
    xclip \
    zlib1g-dev \
    zsh \

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
      echo "Installing packages by nix..."
      # Doc: https://nixos.org/manual/nixpkgs/stable/#sec-declarative-package-management
      nix-env -iA nixpkgs.myPackages
      echo "Installed packages by nix!"
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
      already 'pip3'
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
      already 'cargo'
      cargo install --locked bat # https://github.com/sharkdp/bat#from-source
      cargo install cargo-check
      cargo install cargo-raze
      cargo install cargo-vendor
      cargo install du-dust
      cargo install exa
      cargo install fd-find
      cargo install git-delta
      cargo install hyperfine
      cargo install mdbook
      cargo install procs
      cargo install ripgrep
      cargo install sd
      cargo install starship
      cargo install tealdeer
      cargo install tectonic
      cargo install tokei
    fi
  }
}

: "install npm packages" && {
  if command_exists npm; then
    sudo npm i -g bash-language-server
  fi
}

echo "Complete installation!"
