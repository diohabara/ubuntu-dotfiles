{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "myPackages";
      paths = [
        # fonts
        noto-fonts-cjk
        jetbrains-mono
        cascadia-code
        roboto
        source-code-pro
        nerdfonts
      ];
    };
  };
}
