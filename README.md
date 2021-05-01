# ubuntu-dotfiles

for Ubuntu.

## setup

### If you don't have `curl`

```sh
sudo apt update && sudo apt upgrade -y && sudo apt install -y curl
```

### If you have it

```sh
bash -c "$(curl -fsSL raw.github.com/diohabara/ubuntu-dotfiles/master/bin/setup.sh)"
```

## Setup

- `chsh -s $(which zsh)`
- connect GitHub via SSH
  - First follow this link <https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent>.
  - After finishing the instructions, execute this command.
  ```sh
  git remote set-url origin git@github.com:diohabara/ubuntu-dotfiles.git

## Manual install

- [Micrsoft Edge](https://www.omgubuntu.co.uk/2021/01/how-to-install-edge-on-ubuntu-linux)
- [Visual Studio Code](https://code.visualstudio.com/docs/setup/linux)

## FYI

- If you having difficulty Doom Emacs font rendering, please refer to [this issue](https://github.com/hlissner/doom-emacs/issues/116).

