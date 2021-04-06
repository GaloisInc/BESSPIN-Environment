# Compile and archive freebsd version of
# riscv-gnu-toolchain on Debian 10.1
# This should be run with sudo, and takes several hours to complete.

set -eux

FREEBSD_DIR=/opt/riscv-freebsd
FREEBSD_BUILD_DIR=/tmp/build-freebsd/
GFE_DIR=/gfe

# Avoid overwriting any existing /opt/riscv-freebsd directory
if [ -d $FREEBSD_DIR ]; then
    mv -f $FREEBSD_DIR $FREEBSD_DIR.old
fi

# Create FreeBSD Sysroot (world directory)
echo "Bulding FreeBSD sysroot"

mkdir -p $FREEBSD_BUILD_DIR
cp -r $GFE_DIR/* $FREEBSD_BUILD_DIR

cd $FREEBSD_BUILD_DIR/freebsd

# Clone cheri-bsd
git clone https://github.com/CTSRD-CHERI/cheribsd.git
cd cheribsd
git checkout e75a79b70e377faf1355100961c91784c6c77585
cd ..

# We dont't build the image -- Leaving the deadcode for future compatibility with BBL_SRC
#Clone riscv-pk
#git clone https://github.com/riscv/riscv-pk.git
#cd riscv-pk
#git checkout 8c125897999720856262f941396a9004b0ff5d3d
#cd ..

make clean
TOOLCHAIN= make $PWD/world

SYSROOT=$FREEBSD_DIR/sysroot
OSREL=12.1
echo "SYSROOT=$SYSROOT, OSREL=$OSREL"

# Copy sysroot
mkdir -p $SYSROOT/usr
cp -r $FREEBSD_BUILD_DIR/freebsd/world/usr/lib $FREEBSD_BUILD_DIR/freebsd/world/usr/include $SYSROOT/usr

echo "Bulding FreeBSD toolchain"
# Clone the repo, name it different from standard riscv-gnu-toolchain
if [ ! -d /tmp/riscv-gnu-toolchain-freebsd ]; then
    git clone https://github.com/freebsd-riscv/riscv-gnu-toolchain.git /tmp/riscv-gnu-toolchain-freebsd
fi
cd /tmp/riscv-gnu-toolchain-freebsd

git checkout master
git clean -f
git pull

# Snapshot of master on 2020-3-26 -- update as needed
git checkout 1505830a3b757b3e65c15147388dd1a91ee2c786
git submodule update --init --recursive

# Configure and Make
./configure --prefix $FREEBSD_DIR
make clean
make freebsd OSREL=$OSREL SYSROOT=$SYSROOT
cd $GFE_DIR
echo "FreeBSD toolchain built!"

# Cleanup
rm -rf /tmp/riscv-gnu-toolchain-freebsd $FREEBSD_BUILD_DIR