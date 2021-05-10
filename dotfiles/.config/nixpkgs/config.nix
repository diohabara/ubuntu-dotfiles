{
  allowUnfree = true;

  packageOverrides = pkgs:
    with pkgs; rec {
      myPackages = pkgs.buildEnv {
        name = "my-packages";
        paths = [
          alacritty
          android-studio
          ccls
          clang
          coreutils
          docker
          emacs
          fcitx-engines.mozc
          fd
          firefox
          flutter
          gcc
          gdb
          gibo
          git
          gitAndTools.gh
          go
          google-chrome
          jetbrains.idea-community
          llvm
          neofetch
          nixfmt
          nodePackages.npm
          nodejs
          poetry
          python38Packages.pip
          python39
          typora
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
}
