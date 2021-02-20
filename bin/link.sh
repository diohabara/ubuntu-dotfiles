#!/usr/bin/env bash
set -eu
export LC_ALL=C
export LANG=C
IFS="$(printf " \t\nx")"

GHQ_ROOT="${HOME}/repo"
REPO_ROOT="${GHQ_ROOT}/github.com/diohabara/ubuntu-dotfiles"
DOTFILES_HOME="${REPO_ROOT}/dotfiles"

cd "${DOTFILES_HOME}"

echo 'Symlinking dotfiles...'
command find . -type d | command xargs -I '{}' command mkdir -p "${HOME}/{}"
command find . -type f |
    command xargs -I '{}' command ln -snf "${DOTFILES_HOME}/{}" "${HOME}/{}"
echo 'Symlinking dotfiles complete.'
