{
  allowUnfree = true;

  packageOverrides = pkgs:
    with pkgs; rec {
      myPackages = pkgs.buildEnv {
        name = "my-packages";
        paths = [
          alacritty
          clang
          coreutils
          docker
          emacs
          fcitx-engines.mozc
          fd
          firefox
          flutter
          gibo
          git
          gitAndTools.gh
          go
          google-chrome
          nixfmt
          nodePackages.npm
          nodejs
          poetry
          python38Packages.pip
          python39
          rustup
          typora
          jetbrains.idea-community
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
