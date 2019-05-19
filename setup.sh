# Toolchain paths

# Path to the root of the 64-bit GCC toolchain
tc=$HOME/toolchains/cust-gcc-9.1.0

# Path to the root of the 32-bit GCC toolchain
tc32=$HOME/toolchains/cust-gcc32-9.1.0

# Optional: target prefix of the 64-bit GCC toolchain
# Leave blank for autodetection
prefix=aarch64-elf-

# Optional: target prefix of the 32-bit GCC toolchain
# Leave blank for autodetection
prefix32=arm-eabi-

# Number of parallel jobs to run
# Do not remove, set to 1 for no parallelism.
jobs=6

# Do not edit below this point
# ----------------------------

# Load the shared helpers early to prevent duplication
source helpers.sh

gcc_bin=$tc/bin
gcc32_bin=$tc32/bin
[ -z $prefix ] && prefix=$(get_gcc_prefix $gcc_bin)
[ -z $prefix32 ] && prefix32=$(get_gcc_prefix $gcc32_bin)

# Clean up traces of Clang setup script
unset CROSS_COMPILE
unset CROSS_COMPILE_ARM32
unset CLANG_TRIPLE

export PATH=$gcc_bin:$gcc32_bin:$PATH

MAKEFLAGS+=(
    CROSS_COMPILE=$prefix
    CROSS_COMPILE_ARM32=$prefix32

    KBUILD_COMPILER_STRING="$(get_gcc_version ${prefix}gcc)"
)
