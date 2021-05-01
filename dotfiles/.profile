if [ -e /home/jio/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jio/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Doc: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"${HOME}/.config"}"

# Doc: https://danielmangum.com/posts/vivado-2020-x-ubuntu-20-04/
if [ -d "/tools/Xilinx/Vivado/2020.2/bin" ]; then
  export PATH="${PATH}:/tools/Xilinx/Vivado/2020.2/bin"
  sudo ln -s /lib/x86_64-linux-gnu/libtinfo.so.6 /lib/x86_64-linux-gnu/libtinfo.so.5
fi

# Python
export PATH="$HOME/.poetry/bin:$PATH"

# Golang
export PATH="${PATH}:$(go env GOPATH)/bin"
