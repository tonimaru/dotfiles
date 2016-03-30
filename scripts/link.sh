#/bin/sh

abs_dir() {
    echo $(cd $(dirname $1) && pwd)
}

current_path="$(abs_dir $0})"
dotfiles_root_path="$(abs_dir $current_path)"

# dotfiles/_* -> $HOME/.*

to_dst() {
    echo $HOME/$(echo $(basename $1) | sed s/_/./)
}

find $dotfiles_root_path -maxdepth 1 -name "_*" | while read src; do
    ln -vsfn $src $(to_dst $src)
done

# vim -> nvim
if [ -n "$XDG_CONFIG_HOME" ]; then
  ln -vsfn $dotfiles_root_path/_vim/vimrc $XDG_CONFIG_HOME/nvim/init.vim
else
  if [ ! -d "${HOME}/.config/nvim" ]; then
    mkdir -p ${HOME}/.config/nvim
  fi
  ln -vsfn $dotfiles_root_path/_vim/vimrc $HOME/.config/nvim/init.vim
fi

