# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "HanabiBuilder"
version = v"0.1.0"

# Collection of sources required to build HanabiBuilder
sources = [
    "https://github.com/findmyway/hanabi-learning-environment.git" =>
    "3531eaac21bab0c6ffcdd0584b2702d77a9e2e91",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd hanabi-learning-environment/
cmake -DCMAKE_INSTALL_PREFIX=$prefix -DCMAKE_TOOLCHAIN_FILE=/opt/$target/$target.toolchain .
make
make install
exit

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, libc=:glibc)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libpyhanabi", :libpyhanabi)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
