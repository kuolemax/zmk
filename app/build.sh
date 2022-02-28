#/bin/env sh

clean_build() {
    if [ ! -d "./result" ]; then
        mkdir ./result
    fi

    origin_file="./build/zephyr/zmk.uf2"
    if [ -f "$origin_file" ]; then
        cp $origin_file ./result/$1_$(date +%Y-%m-%d'_'%H-%M-%S).uf2
        rm -rf ./build
    fi
}

if [ "$1" == "" ]; then
    echo "please input keyboard name"
elif [ "$1" == "reviung41" ]; then
    base='/home/chenz/SharedFiles/DIY_keyboard/Keyboards/reviung/software/zmk-reviung41/config'
    echo "build reviung41..."
    west build -b nrfmicro_13 -- -DSHIELD=reviung41 -DZMK_CONFIG="$base"
    clean_build "reviung41"
elif [ "$1" == "corne" ]; then
    base='/home/chenz/SharedFiles/DIY_keyboard/Keyboards/corne/software/zmk-corne/config'
    echo "build corne left..."
    west build -b nrfmicro_13 -- -DSHIELD=corne_left -DZMK_CCONFIG="$base"
    clean_build "corne_left"
    echo "build corne right..."
    west build -b nrfmicro_13 -- -DSHIELD=corne_right -DZMK_CCONFIG="$base"
    clean_build "corne_right"
else
    echo "build $1..."
    west build -b nrfmicro_13 -- -DSHIELD=$1
    clean_build "$1"
fi
