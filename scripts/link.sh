#/bin/sh

current_path="$(cd -P "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"

find $current_path/.. -maxdepth 1 -name "_*" | while read src; do
    dst_file_name=`echo $(basename $src) | sed s/_/./`
    dst=$HOME/$dst_file_name
    ln -vsfn $src $dst
done

