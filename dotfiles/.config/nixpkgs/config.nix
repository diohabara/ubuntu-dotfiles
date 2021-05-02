{
  allowUnfree = true;
  packageOverrides = pkgs:
    with pkgs; rec {
      myPackages = pkgs.buildEnv {
        name = "my-packages";
        paths = [
          nixfmt
          typora
          alacritty
          gibo
          poetry
          google-chrome
          docker
          go
          firefox
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
