{
  allowUnfree = true;
  packageOverrides = pkgs:
    with pkgs; rec {
      myPackages = pkgs.buildEnv {
        name = "my-packages";
        paths = [
          alacritty
          cargo
          docker
          emacs
          firefox
          gibo
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
