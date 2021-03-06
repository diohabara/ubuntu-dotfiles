{
  allowUnfree = true;

  packageOverrides = pkgs:
    with pkgs; rec {
      myPackages = pkgs.buildEnv {
        name = "my-packages";
        paths = [
          alacritty
          bash
          bat
          ccls
          clang_12
          cmake
          coreutils
          curl
          docker
          emacsGcc
          fcitx-engines.mozc
          fd
          ffmpeg
          firefox
          fzf
          gdb
          gibo
          git
          gitAndTools.gh
          go
          google-chrome
          gzip
          jdk8_headless
          jq
          llvm
          neofetch
          nixfmt
          nodePackages.npm
          nodejs
          poetry
          python38Packages.pip
          python39
          shellcheck
          tcl
          tmux
          typora
          unzip
          wget
          zsh
          # cargo
          du-dust
          exa
          fd
          hyperfine
          mdbook
          procs
          ripgrep
          sd
          starship
          starship
          tectonic
          tldr
          tokei
        ];
        extraOutputsToInstall = [ "man" "doc" "info" ];
      };
      fonts.fonts = with pkgs; [
        cascadia-code
        dejavu_fonts
        jetbrains-mono
        nerdfonts
        noto-fonts-cjk
        powerline-fonts
        roboto
        source-code-pro
      ];
    };
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = (epkgs: [ epkgs.vterm ]);
  };
}
