{
  allowUnfree = true;
  packageOverrides = pkgs:
    with pkgs; rec {
      myPackages = pkgs.buildEnv {
        name = "my-packages";
        nixpkgs.overlays = [
          (import (builtins.fetchTarball
            "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz"))
        ];
        paths = [
          alacritty
          cargo
          clang
          coreutils
          docker
          emacsUnstable
          fcitx-engines.mozc
          fd
          firefox
          gibo
          git
          gitAndTools.gh
          go
          google-chrome
          ibus-engines.mozc
          neovim
          nixfmt
          nodePackages.npm
          nodejs
          poetry
          python38Packages.pip
          python39
          rustup
          typora
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
