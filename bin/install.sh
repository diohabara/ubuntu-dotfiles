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
    emacs \
    ffmpeg \
    firefox \
    fzf \
    gnupg \
    grep \
    gzip \
    ibus-mozc \
    jq \
    libfontconfig1-dev \
    libfreetype6-dev \
    libgraphite2-dev \
    libharfbuzz-dev \
    libtinfo-dev \
    libssl-dev \
    libtool \
    libxcb-xfixes0-dev \
    llvm \
    lsb-release \
    neofetch \
    neovim \
    pkg-config \
    python3 \
    python3-pip \
    rlwrap \
    shellcheck \
    software-properties-common \
    tmux \
    unzip \
    wget \
    xclip \
    zlib1g-dev \
    zsh \

}

: "install fonts" && {
  # Doc: https://github.com/JetBrains/JetBrainsMono
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y \
    fonts-dejavu-core \
    fonts-firacode \
    fonts-noto-cjk \
    fonts-powerline \

}

: "install Docker" && {
  if ! command_exists docker; then
    # Doc: https://docs.docker.com/engine/install/ubuntu/
    sudo apt update
    sudo apt-get install -y \
                          apt-transport-https \
                          ca-certificates \
                          curl \
                          gnupg \
                          lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
  fi
}

: "install gh" && {
  if ! command_exists gh; then
    # Doc: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
    sudo apt-add-repository https://cli.github.com/packages
    sudo apt update
    sudo apt install -y gh
  fi
}

: "install visual studio code" && {
  if ! command_exists code; then
    # Doc: https://code.visualstudio.com/docs/setup/linux
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install -y code # or code-insiders
  fi
}

: "install Google Chrome" && {
  if ! command_exists google-chrome; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ./google-chrome-stable_current_amd64.deb
    rm -rf google-chrome-stable_current_amd64.deb
  fi
}

: "install Doom Emacs" && {
  if ! [ -d "$HOME/.emacs.d" ]; then
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
  fi
}

: "install go packages" && {
  if ! command_exists go; then
    # Doc: https://github.com/golang/go/wiki/Ubuntu
    curl -LO "https://get.golang.org/$(uname)/go_installer" && chmod +x go_installer && ./go_installer && rm -rf go_installer
  fi
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

: "install python" && {
  : "install pyenv" && {
    if ! command_exists pyenv; then
      # Doc: https://github.com/pyenv/pyenv-installer
      rm -rf ~/.pyenv
      curl https://pyenv.run | bash
      # Doc: https://github.com/pyenv/pyenv
    fi
  }

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
      pip3 install black
      pip3 install isort
      pip3 install pyflakes
      pip3 install pytest
      pip3 install python-language-server[all]
      pip3 install wakatime
    fi
  }
}

: "install rust packages" && {
  if ! command_exists rustup; then
    installing 'Rust'
    # Doc: https://www.rust-lang.org/tools/install
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    source "$HOME/.cargo/env"
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

  : "install alacritty" && {
    if ! command_exists alacritty; then
      # Doc: https://github.com/alacritty/alacritty/blob/master/INSTALL.md#desktop-entry
      # install required tools
      sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3

      # download and build alacritty
      git clone https://github.com/alacritty/alacritty.git
      cd alacritty
      rustup override set stable
      rustup update stable
      cargo build --release

      # desktop entry
      sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
      sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
      sudo desktop-file-install extra/linux/Alacritty.desktop
      sudo update-desktop-database

      # manual page
      sudo mkdir -p /usr/local/share/man/man1
      gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null

      # use alacritty as default desktop terminal
      gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/alacritty

      # remote temporary dir
      cd ..
      rm -rf alacritty
    fi
  }
}

echo "Complete installation!"
