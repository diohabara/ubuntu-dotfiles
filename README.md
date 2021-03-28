# ubuntu-dotfiles

for Ubuntu.

## setup

### If you don't have `curl`

```sh
sudo apt update
sudo apt upgrade -y
sudo apt install -y curl
```

### If you have it

```sh
bash -c "$(curl -fsSL raw.github.com/diohabara/ubuntu-dotfiles/master/bin/setup.sh)"
```

## Setup

- `chsh -s "/usr/bin/zsh"`
- connect GitHub via SSH
  - First follow this link <https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent>.
  - After finishing the instructions, execute this command.
  ```sh
  git remote set-url origin git@github.com:diohabara/ubuntu-dotfiles.git
  ```
