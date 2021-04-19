# Build on top of which image
ARG BASE
FROM ${BASE}

USER root

# Copy all the files over 
ADD Xilinx_Vivado_Lab_Lin_2019.1_0524_1430.tar.gz \
    install_config_vivado.txt \
    Xilinx_HW_Server_Lin_2019.1_0524_1430.tar.gz \
    install_config_hw.txt \
    /

RUN cd /Xilinx_Vivado_Lab_Lin_2019.1_0524_1430 \
    && ./xsetup --agree XilinxEULA,3rdPartyEULA,WebTalkTerms --batch Install --config ../install_config_vivado.txt \
    # clean-up
    && rm -rf /Xilinx_Vivado_Lab_Lin_2019.1_0524_1430* /install_config_vivado.txt \
    # HW Server
    && cd /Xilinx_HW_Server_Lin_2019.1_0524_1430 \
    && ./xsetup --agree XilinxEULA,3rdPartyEULA,WebTalkTerms --batch Install --config ../install_config_hw.txt \
    # clean-up
    && rm -rf /Xilinx_HW_Server_Lin_2019.1_0524_1430* /install_config_hw.txt \
    # Install cable drivers
    && mkdir -p /etc/udev/rules.d \
    && cd /opt/Xilinx/Vivado_Lab/2019.1/data/xicom/cable_drivers/lin64/install_script/install_drivers/ \
    && ./install_drivers \
    # Make Vivado Lab available for all users
    && echo "source /opt/Xilinx/Vivado_Lab/2019.1/settings64.sh" | tee -a /etc/bash.bashrc

ARG DEFAULT_USER
USER ${DEFAULT_USER}
