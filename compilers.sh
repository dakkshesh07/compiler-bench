#!/usr/bin/env bash

TC_DIR="$(pwd)/toolchains"

neutron() {
    mkdir -p "$TC_DIR/neutron" && cd "$TC_DIR/neutron"
    bash <(curl -s https://raw.githubusercontent.com/Neutron-Toolchains/antman/main/antman) -S --noprogress
    cd - || exit 1
}

# Git
git_repo_clone() {
    git clone "${1}" "$TC_DIR/${2}" --depth=1
}

cosmic() {
    git_repo_clone "https://gitlab.com/GhostMaster69-dev/cosmic-clang.git" "cosmic"
}

playground() {
    git_repo_clone "https://gitlab.com/PixelOS-Devices/playgroundtc" "playground"
}

# AOSP
aosp_clang() {
    mkdir -p "$TC_DIR/${1}" && cd "$TC_DIR/${1}"
    wget --quiet "https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/main/clang-${1}.tar.gz"
    tar -xf "clang-${1}.tar.gz" && rm -rf "clang-${1}.tar.gz"
    cd - || exit 1
}

# 18.0.1
r522817() {
    aosp_clang "r522817"
}

zyc() {
    cd "$TC_DIR" || exit 1
    wget --quiet "$(curl -s https://raw.githubusercontent.com/ZyCromerZ/Clang/main/Clang-main-link.txt)" -O "zyc-clang.tar.gz"
    mkdir zyc && tar -xf zyc-clang.tar.gz -C zyc && rm -rf zyc-clang.tar.gz
    cd - || exit 1
}

weebx() {
    cd "$TC_DIR" || exit 1
    wget --quiet "$(curl -s https://raw.githubusercontent.com/XSans0/WeebX-Clang/main/main/link.txt)" -O "weebx-clang.tar.gz"
    mkdir weebx && tar -xf weebx-clang.tar.gz -C weebx && rm -rf weebx-clang.tar.gz
    cd - || exit 1
}
