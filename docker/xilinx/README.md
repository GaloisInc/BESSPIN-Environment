# BESSSPIN+Xilinx Images

These images are based on our images in addition to Xilinx Vivado HW and Vivado Lab tools. These are mostly for internal CI use, but we are including them since they might be useful.

## Images

We add the Xilinx tools to two images: `gfe:xilinx` which is based on the [BESSPIN GFE image](../gfe/README.md) ,and `tool-suite:xilinx` which is based on the [BESSPIN Tool-Suite image](../tool-suite/README.md). 

## Build

The Dockerfile was initially copied from [this internal repo](https://gitlab-ext.galois.com/ssith/docker-tools/-/blob/develop/gfe_ci/Dockerfile).

You need to provide the following files for Xilinx:
- install_config_vivado.txt
- Xilinx_Vivado_Lab_Lin_2019.1_0524_1430.tar.gz
- install_config_hw.txt
- Xilinx_HW_Server_Lin_2019.1_0524_1430.tar.gz

For Internal Use:   
    If you have access to Galois artifactory, you can run:
    ```
        API_KEY=<YOURKEY> ./fetchSources.sh
    ```

After the files are provided, you can build the images:
```bash
docker build \
    --build-arg BASE=galoisinc/besspin:gfe \
    --build-arg DEFAULT_USER=root \
    --tag artifactory.galois.com:5008/gfe:xilinx \
    .

docker build \
    --build-arg BASE=artifactory.galois.com:5008/besspin:tool-suite \
    --build-arg DEFAULT_USER=besspinuser \
    --tag artifactory.galois.com:5008/tool-suite:xilinx \
    .
```

To publish them:
```bash
docker push artifactory.galois.com:5008/gfe:xilinx
docker push artifactory.galois.com:5008/tool-suite:xilinx
```