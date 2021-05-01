{ pkgs }:
{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; rec {
    myProfile = writeText "my-profile" ''
      export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/sbin:/bin:/usr/sbin:/usr/bin
      export MANPATH=$HOME/.nix-profile/share/man:/nix/var/nix/profiles/default/share/man:/usr/share/man
    '';
    myProfile = writeTxt "my-profile" ''
      export PATH=$HOME/.nix-profile/bin:
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        (runCommand "profile" {} ''
          mkdir -p $out/etc/profile.d
          cp ${myProfile} $out/etc/profile.d/my-profile.sh
        '')
        # fonts
        noto-fonts-cjk
        jetbrains-mono
        cascadia-code
        roboto
        source-code-pro
        nerdfonts
      ];
    };
    pathsToLink = [ "/share" "bin" ];
    extraOutputsToInstall = [ "man" "doc" "info" ];
    postBuild = ''
      if [ -x $out/bin/install-info -a -w $out/share/info ]; then
        shopt -s nullglob
        for i in $out/share/info/*.info $out/share/info/*.info.gz; do
          $out/bin/install-info $i $out/share/info/dir
        done
    '';
  };
  fonts.fonts = with pkgs; [
    noto-fonts-cjk
    jetbrains-mono
    cascadia-code
    roboto
    source-code-pro
    nerdfonts
  ];
}
