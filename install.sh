#/bin/sh

current_path="$(cd -P "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"

ln -sf ${current_path}/_vim ~/.vim
