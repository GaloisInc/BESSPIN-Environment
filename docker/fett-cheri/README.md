# SRI-Cambridge toolchain docker image #

The image is publicly available at: `galoisinc/besspin:fett-cheri`.

## CHERI Toolchains

The CHERI RISC-V processors have their own LLVM toolchain. This is
included in the image along with versions of GDB and QEMU that work
with CHERI processors. A CheriBSD sysroot can be found at
`/opt/cheri/sdk/sysroot`.

Here is an example of compiling a simple C program with the CHERI
toolchain:
```
clang -target riscv64-unknown-freebsd13.0 --sysroot /opt/cheri/sdk/sysroot \
    -march=rv64imafdcxcheri -mabi=l64pc128d -mno-relax -fuse-ld=lld \
    -o prog prog.c
```

If you want to run CheriBSD in QEMU, `/opt/cheri` contains a kernel
and a compressed disk image.
```
zstd -d /opt/cheri/disk-image-cheri.img.zst

qemu-system-riscv64cheri -machine virt -m 2048M -nographic \
    -kernel /opt/cheri/kernel-cheri.elf -bios /opt/cheri/sdk/bbl/riscv64-purecap/bbl \
    -drive file=/opt/cheri/disk-image-cheri.img,format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0
```

Consult the [CHERI C/C++ Programming
Guide](https://www.cl.cam.ac.uk/techreports/UCAM-CL-TR-947.pdf) for
more information.

## Instructions to create the image

### Using build-docker.py

You can build (`-b`) and push (`-p`):
```bash
    ./build-docker.py -bp -s fett-cheri
```

### Manually

We need an Ubuntu host for that. The easiest way is to use AWS. So spin up a strong instance with Ubuntu 18.04 (ami-0a634ae95e11c6f91) as the AMI. 

Note that I chose the AMD AMI, so if you use a different one, please change the docker installation instructions accordingly.

Also note that neither the FPGA CentOS AMI nor the Debian AWS instances have the UFS kernel module by default. 


```
cd ~
sudo modprobe ufs #If this doesn't work, don't bother with the rest. Find a machine that has this.
sudo apt update
sudo apt install -y git-all
sudo apt install -y git-lfs
sudo apt install -y awscli
git clone git@github.com:GaloisInc/BESSPIN-Tool-Suite.git
cd BESSPIN-Tool-Suite
git submodule update --init
cd BESSPIN-LFS
git lfs pull
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo apt install -y zstd
```

If you're going to modify the Dockerfile or any other files, please make sure your commits are not anonymous
```
git config --global user.name <yourName>
git config --global user.email <yourEmail>
```

Now let's create the docker image:
```
cd ~/BESSPIN-Tool-Suite/BESSPIN-Environment/docker/cheri/
./copy-files.sh
sudo docker build --tag cambridge-toolchain .
```

Save it to a tar.gz file:
```
sudo docker save cambridge-toolchain | gzip > cambridge-toolchain.tar.gz
```

Delete the extra files:
```
./clear.sh
```