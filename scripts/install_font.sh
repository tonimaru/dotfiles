#!/bin/sh

get_work_dir () {
    local wd

    if [ -x "$(which mktemp)" ]; then
        wd="$(mktemp -d /tmp/XXXXXX)"
    else
        wd="/tmp/install_font"
    fi
    if [ ! -d "$wd" ]; then mkdir -p $wd; fi
    echo $wd
}

insfont_exit() {
    cd ~
    rm -rf $work_dir
    exit $1
}

insfont_error() {
    echo $1
    insfont_exit 1
}

font_dir=
ubuntu() {
    sudo aptitude install fontforge
    font_dir="$HOME/.fonts"
}

darwin() {
    brew install fontforge automeke pkg-config
    font_dir="$HOME/Library/Fonts"
}

os_name=$(uname -v)
case "$os_name" in
    *Ubuntu*) ubuntu ;;
    *Darwin*) darwin ;;
    *) insfont_error "unknown os" ;;
esac

if [ ! -x "$(which git)" ]; then insfont_error "git not found."; fi
if [ ! -x "$(which curl)" -a ! -x "$(which wget)" ]; then insfont_error "curl and wget not found."; fi

work_dir=$(get_work_dir)

migu_url="http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F59022%2Fmigu-1m-20130617.zip"
migu_zip=$work_dir/migu.zip

inconsolata_url="http://levien.com/type/myfonts/Inconsolata.otf"
inconsolata_out=$work_dir/Ricty/Inconsolata.otf

cd $work_dir

git clone https://github.com/yascentur/Ricty.git

if [ -x "$(which curl)" ]; then
    curl -L "$migu_url" > $migu_zip
    curl "$inconsolata_url" > $inconsolata_out
else
    wget -o $migu_zip "$migu_url"
    wget -o $inconsolata_out "$inconsolata_url"
fi

unzip -o $migu_zip
cp -vf ./migu*/*.ttf $work_dir/Ricty/

cd $work_dir/Ricty

./ricty_generator.sh Inconsolata.otf migu-1m-regular.ttf migu-1m-bold.ttf

if [ ! -d "$font_dir" ]; then
    mkdir -vp $font_dir
fi
cp -vf Ricty*.ttf $font_dir/

insfont_exit 0

