#/bin/sh

abs_dir() {
    echo $(cd $(dirname $1) && pwd)
}

to_dst() {
    echo $HOME/$(echo $(basename $1) | sed s/_/./)
}

current_path="$(abs_dir $0})"
dotfiles_root_path="$(abs_dir $current_path)"

find $dotfiles_root_path -maxdepth 1 -name "_*" | while read src; do
    ln -vsfn $src $(to_dst $src)
done

