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
ln -vsfn $dotfiles_root_path/_vim/vimrc $dotfiles_root_path/_vim/init.vim
if [ -n "$XDG_CONFIG_HOME" ]; then
  ln -vsfn $dotfiles_root_path/_vim $XDG_CONFIG_HOME/nvim
else
  ln -vsfn $dotfiles_root_path/_vim $HOME/.config/nvim
fi

