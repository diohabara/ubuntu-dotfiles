# Nix
if [ -e /home/jio/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jio/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
export XDG_DATA_DIRS="${HOME}/.nix-profile/share:$XDG_DATA_DIRS"

# Doc: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"${HOME}/.config"}"

# Doc: https://danielmangum.com/posts/vivado-2020-x-ubuntu-20-04/
VIVADO_PATH="/tools/Xilinx/Vivado/2020.3/bin"
if [ -d "${VIVADO_PATH}" ]; then
  export PATH="${PATH}:${VIVADO_PATH}"
  sudo ln -s /lib/x86_64-linux-gnu/libtinfo.so.6 /lib/x86_64-linux-gnu/libtinfo.so.5
fi

# Python
export PATH="$HOME/.poetry/bin:$PATH"

# Golang
# https://golang.org/doc/install#install
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:${HOME}/.go/bin"
export PATH="${PATH}:$(go env GOPATH)/bin"
