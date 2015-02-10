#!/bin/sh

# TODO tmp dir

work_dir=/tmp/_install_font

migu_url="http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F59022%2Fmigu-1m-20130617.zip"
migu_zip=$work_dir/migu.zip

inconsolata_url="http://levien.com/type/myfonts/Inconsolata.otf"
inconsolata_out=~/.fonts/Inconsolata.otf

if [ ! -x "`which git`" ]; then
    echo git not found.
    exit 1
fi
if [ ! -x "`which curl`" -a ! -x "`which wget`" ]; then
    echo curl and wget not found.
    exit 1
fi

ubuntu() {
    sudo aptitude install fontforge
}

os_name=`uname -v`
case "$os_name" in
    *Ubuntu*) ubuntu ;;
    *) echo "unknown os"; exit 1 ;;
esac

mkdir -p $work_dir
cd $work_dir

if [ -x "`which curl`" ]; then
    curl -L "$migu_url" > $migu_zip
    curl "$inconsolata_url" > $inconsolata_out
else
    wget -o $migu_zip "$migu_url"
    wget -o $inconsolata_out "$inconsolata_url"
fi

unzip -o $migu_zip

mkdir -vp ~/.fonts

cp -vf ./migu*/*.ttf ~/.fonts/

git clone https://github.com/yascentur/Ricty.git
cd Ricty

./ricty_generator.sh auto

cp -vf *.ttf ~/.fonts/

cd /tmp
rm -rf $work_dir

