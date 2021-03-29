if [ -e /home/jio/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jio/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Doc: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

# Doc: https://golang.org/doc/install#install
export PATH="${PATH}:/usr/local/go/bin"

# Doc: https://danielmangum.com/posts/vivado-2020-x-ubuntu-20-04/
if [ -d "/tools/Xilinx/Vivado/2020.2/bin" ]; then
  export PATH="${PATH}:/tools/Xilinx/Vivado/2020.2/bin"
fi
