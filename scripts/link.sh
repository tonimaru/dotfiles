#/bin/sh

abs_path() {
    echo $(cd $(dirname $1) && pwd)/$(basename $1)
}

to_dst() {
    echo $HOME/$(echo $(basename $1) | sed s/_/./)
}

current_path="$(cd -P "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"

find $current_path/.. -maxdepth 1 -name "_*" | while read src; do
    ln -vsfn $(abs_path $src) $(to_dst $src)
done

