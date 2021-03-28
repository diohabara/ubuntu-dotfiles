# Doc: http://zsh.sourceforge.net/Doc/Release/Files.html
export ZDOTDIR="${HOME}/.config/zsh"
. "${ZDOTDIR}/.zshenv"

### XDG Base Directory ###
# Doc: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"${HOME}/.config"}"

if [ -e /home/jio/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jio/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
