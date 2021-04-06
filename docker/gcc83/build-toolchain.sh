# Compile and archive both linux and newlib versions of
# riscv-gnu-toolchain on Debian 10.1
# This should be run with sudo, and takes several hours to complete.

set -eux

# Avoid overwriting any existing /opt/riscv directory
if [ -d /opt/riscv ]; then
    mv /opt/riscv /opt/riscv.old
fi

echo "Bulding GNU toolchain"
if [ ! -d /tmp/riscv-gnu-toolchain ]; then
    git clone https://github.com/riscv/riscv-gnu-toolchain /tmp/riscv-gnu-toolchain
fi
cd /tmp/riscv-gnu-toolchain
git clean -f
rm -f Makefile
git pull
# Snapshot of master on 2019-08-15 -- Last master commit of riscv-gnu-toolchain prior to bumping riscv-gcc to 9.2
git checkout 0914ab9f41b63681e538ec677c4adeaa889adae5
git submodule update --init --recursive
./configure --prefix /opt/riscv --enable-multilib --with-cmodel=medany --host=x86_64
make linux
make
cd ..
echo "GNU toolchain built!"

# Cleanup
rm -rf /tmp/riscv-gnu-toolchain

