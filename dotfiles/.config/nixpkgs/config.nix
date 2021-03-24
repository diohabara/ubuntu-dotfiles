{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "myPackages";
      paths = [
        # fonts
        noto-fonts-cjk
        jetbrains-mono

        # tools
        alacritty
        bash
        bat
        bazel
        buildifier
        ccls
        clang-tools
        cmake
        curl
        docker
        dotnet-sdk
        dust
        emacs
        exa
        fd
        ffmpeg
        fzf
        gcc
        gh
        ghc
        gibo
        git
        gitAndTools.delta
        golangci-lint
        groovy
        stack
        hyperfine
        jq
        llvm
        mysql
        neofetch
        neovim
        openssl
        pandoc
        pkg-config
        procs
        python39
        ripgrep
        rlwrap
        sd
        shellcheck
        starship
        tealdeer
        tectonic
        tmux
        tokei
        unzip
        vlc
        vscode
        wget
        zsh
      ];
    };
  };
}
