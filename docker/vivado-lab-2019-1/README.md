# BESSSPIN + Vivado Lab Images

These images are based on our images in addition to Xilinx Vivado Lab 2019.1. These are mostly for internal CI use, but we are including them since they might be useful.

The images are available to Galois partners at: 
    - `artifactory.galois.com:5008/vivado-lab-2019-1:gfe`
    - `artifactory.galois.com:5008/vivado-lab-2019-1:tool-suite`

## Images

We add the Vivado Lab to two images: `vivado-lab-2019-1:gfe` which is based on the [BESSPIN GFE image](../gfe/README.md) ,and `vivado-lab-2019-1:tool-suite` which is based on the [BESSPIN Tool-Suite image](../tool-suite/README.md). 

## Build 

The Dockerfile was initially copied from [this internal repo](https://gitlab-ext.galois.com/ssith/docker-tools/-/blob/develop/gfe_ci/Dockerfile).

### Using build-docker.py

You can build (`-b`) and push (`-p`):
```bash
    API_KEY=<YOURKEY> ./build-docker.py -bp -s vivado-lab-2019-1
```

### Manually

You need to provide the following files:
- install_config_vivado.txt
- Xilinx_Vivado_Lab_Lin_2019.1_0524_1430.tar.gz
- install_config_hw.txt
- Xilinx_HW_Server_Lin_2019.1_0524_1430.tar.gz

For Internal Use:   
    If you have access to Galois artifactory, you can fetch the files using:
    ```bash
        API_KEY=<YOURKEY> ./build-docker.py -r -s vivado-lab-2019-1
    ```

After the files are provided, you can build the images:
```bash
docker build \
    --build-arg BASE=galoisinc/besspin:gfe \
    --build-arg DEFAULT_USER=root \
    --tag artifactory.galois.com:5008/vivado-lab-2019-1:gfe \
    .

docker build \
    --build-arg BASE=galoisinc/besspin:tool-suite \
    --build-arg DEFAULT_USER=besspinuser \
    --tag artifactory.galois.com:5008/vivado-lab-2019-1:tool-suite \
    .
```

To publish them:
```bash
docker push artifactory.galois.com:5008/vivado-lab-2019-1:gfe
docker push artifactory.galois.com:5008/vivado-lab-2019-1:tool-suite
```