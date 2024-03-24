#!/usr/bin/env bash

source compilers.sh

mkdir -p "$TC_DIR"

compilers=(
    "r522817"
    "weebx"
    "zyc"
    "neutron"
    "playground"
    "cosmic")

for i in "${!compilers[@]}"; do
    ${compilers[$i]}
done

echo "Toolchain Details" >tcinfo.txt
for i in "${compilers[@]}"; do
    {
        echo ""
        echo "${i}:"
        "${TC_DIR}"/"${i}"/bin/clang --version
    } >>tcinfo.txt
done

printf -v compiler_list '%s,' "${compilers[@]}"
compiler_list=${compiler_list%,}

LINUX_VER=$(curl -sL "https://www.kernel.org" | grep -A 1 "latest_link" | tail -n +2 | sed 's|.*">||' | sed 's|</a>||')

echo ""
echo "Kernel Version: ${LINUX_VER}"
echo ""
cat tcinfo.txt

wget --quiet "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${LINUX_VER}.tar.xz"
tar xf "linux-${LINUX_VER}.tar.xz"
rm -rf "linux-${LINUX_VER}.tar.xz"
cd "linux-${LINUX_VER}" || exit 1

# shellcheck disable=SC2044
for i in $(find . -type f); do
    cat "$i" >/dev/null
    cat "$i" >/dev/null
    cat "$i" >/dev/null
    cat "$i" >/dev/null
done

# shellcheck disable=SC2016
hyperfine -w 2 -r 3 -p 'make distclean' -L compiler "${compiler_list}" 'PATH="$HOME/toolchains/{compiler}/bin:${PATH}" LD_LIBRARY_PATH="$HOME/toolchains/{compiler}/lib" make distclean defconfig all -j$(nproc --all) LLVM=1 LLVM_IAS=1' -c 'make distclean' --export-json x86.json
echo "" && cat x86.json
